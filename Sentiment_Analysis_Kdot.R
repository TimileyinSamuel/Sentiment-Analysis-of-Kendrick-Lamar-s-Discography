############## A SENTIMENT ANALYSIS OF KENDRICK LAMAR'S ALBUMS  ###############
### Loading Libraries
library(tidyverse) #data wrangling
library(rvest) #web scraping
library(tidylog) #track data wrangling
library(spotifyr) #spotify data
library(geniusr) #genius data
library(tidytext) # text analysis
library(wordcloud) #word cloud
library(textdata) #text
library(gt) #tables
library(gtExtras) #tables
library(yarrr)  #pirate plot   

##### GETTING DATA USING SPOTIFY'S API
## #Setting client_id and client_secret as environment variables
Sys.setenv(SPOTIFY_CLIENT_ID = "put_your_id")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "put_your_client_secret")

### Getting all Kendrick's projects from spotify
all_songs <- get_artist_audio_features('kendrick lamar',
                                       include_groups = "album")

### Check distinct project names
all_songs$album_name |> 
  unique()
# 10 unique projects.

### Removing unwanted projects
albums <- all_songs |> 
  filter(!album_name %in% c("Black Panther The Album Music From And Inspired By",
                              "DAMN. COLLECTORS EDITION.",
                            "good kid, m.A.A.d city", "Overly Dedicated",
                            "untitled unmastered."))
# Now, only albums needed are returned. 

albums$album_name |> 
  unique()
# A total of 5 albums

### Some albums have duplicates
albums |> 
  select(artist_name, album_name, album_id) |> 
  group_by(album_name, album_id) |> 
  summarise(n = n())

### Removing duplicates
albums <- albums |> 
  filter(album_id %in% c("0bLXUfNT34mna9aXq8ex68", "748dZDqSZy6aPXKcI9H80u",
                         "3OqPkYVDzHKistrI9exrjR", "1bkN9nIkkCnXeG4yitVS1J", 
                         "0CXmtbhJapIH7vw8go2DEb"))
# Now we have all 5 albums without duplicate

### selecting columns
albums <- albums |> 
  select(artist_name, album_id, album_name, track_name, album_release_date, instrumentalness,
         tempo, speechiness, liveness, danceability, loudness, acousticness,
         valence, tempo)


##### GETTING LYRICS DATA USING GENIUS LYRICS' API
### setting token
token <- "put_your_token"
Sys.setenv(GENIUS_API_TOKEN = 'put_your_token')
genius_token(TRUE)

### Getting Artiste ID
search_artist("Kendrick Lamar")
# Kendrick Lamar Id on genius is 1421

## getting all songs by Kendrick Lamar and the lyrics url from GeniusLyrics
songs <- get_artist_songs_df(1421)
## 393 songs with the lyrics url

## Get all song IDs
ids <- c(as.character(songs$song_id))

## Create empty dataframe to house them
allLyrics <- data.frame()

##### SCRAPPING LYRICS OF ALL SONGS FROM GENIUS WEBSITE
allLyrics <- data.frame()  # initialize empty data frame to store lyrics

### Writing a loop that scrapes the for each song
while (length(ids) > 0) {
  for (id in ids) {
    lyrics <- tryCatch({
      geniusr::get_lyrics_id(id)  # replace with the function that retrieves lyrics for a given id
    }, error = function(e) {
      print(paste("Error:", e$message))  # print the error message
      Sys.sleep(10)  # pause for 10 seconds to give the function more time
      return(NULL)  # return NULL if an error occurs
    })
    if (!is.null(lyrics)) {
      allLyrics <- rbind(allLyrics, lyrics)  # append lyrics to data frame
    }
    successful <- unique(allLyrics$song_id)
    ids <- ids[!ids %in% successful]
    print(paste("done - ", id))
    print(paste("New length is ", length(ids)))
  }
  if (length(ids) == 0) {
    break  # break out of the while loop if ids is empty
  }
}
## This process takes several minutes. So, I stored this result as csv
## to avoid running this loop every time.

### Adding the album the songs belong to
allIds <- data.frame(song_id = unique(allLyrics$song_id))
allIds$album <- ""

### And now, a loop to put it all together.
for (song in allIds$song_id) {
  allIds[match(song,allIds$song_id),2] <- get_song_df(song)[12]
  print(allIds[match(song,allIds$song_id),])
}

### Renaming NAs
head(allIds)
allIds$album[is.na(allIds$album)] <- "Not in Any Album"

### joining data frame
allLyrics2 <- full_join(allLyrics, allIds)
allLyrics2

### Filter only the albums needed from Genius Lyrics
NeededAlbums <- allLyrics2 |> 
  filter(album %in% c("Section.80", "good kid, m.A.A.d city (Deluxe Version)", 
                      "To Pimp a Butterfly", "DAMN." ,
                      "Mr. Morale & The Big Steppers"))

### Few songs in the album are missing from genius data set, I scraped these manually

## Function to get all missing songs
missing_songs <- c("Die Hard", "We Cry Together", "Purple Hearts", "Silent Hill", "Savior", "Mr. Morale")

### creating an empty data frame to store the lyrics
allLyrics <- data.frame(song_title = character(),
                        artist_name = character(),
                        lyrics = character(),
                        stringsAsFactors = FALSE)

### A loop to get lyrics for missing tracks 
for (i in seq_along(missing_songs)) {
  song_title <- missing_songs[i]
  lyrics <- tryCatch({
    geniusr::get_lyrics_search(artist_name = "Kendrick Lamar", song_title = song_title)
  }, error = function(e) {
    print(paste("Error:", e$message))
    return(NULL)
  })
  if (!is.null(lyrics)) {
    # create a new data frame with the same column names as allLyrics
    newLyrics <- data.frame(lyrics = lyrics$line,
                            section_name = lyrics$section_name,
                            section_artist = lyrics$section_artist,
                            song_name = lyrics$song_name,
                            artist_name = lyrics$artist_name,
                            stringsAsFactors = FALSE)
    # add the new data frame to allLyrics
    allLyrics <- rbind(allLyrics, newLyrics)
  }
}

# outputing the data frame
allLyrics


### For some reasons, this loop is still unable to get the lyrics for two songs 
## "Silent Hill" and "Savior"
## I instead scraped it directly from the website using rvest or used geniusr
url <- "https://genius.com/Kendrick-lamar-and-kodak-black-silent-hill-lyrics"
url <- read_html(url)

Silent_Hill <- url |>  
  html_element(css = ".Dzxov") |> 
  html_text2()

## converting to dataframe
Silent_Hill <- as.data.frame(Silent_Hill)

## adding album name
Silent_Hill <- Silent_Hill |> 
  mutate(song_name = "Silent Hill",
         album = "Mr. Morale & The Big Steppers") |> 
  rename(lyrics = line) |> 
  select(lyrics, song_name, album)

### Getting Lyrics for the song "The_Recipe_Remix" (using geniusr package)
The_Recipe_Remix <- geniusr::get_lyrics_search(artist_name = "Kendrick Lamar",
                                               song_title = "The Recipe (Black Hippy Remix)")
## adding album name
The_Recipe_Remix <- The_Recipe_Remix |> 
  mutate(song_name = "The Recipe (Black Hippy Remix)",
         album = "good kid, m.A.A.d city (Deluxe Version)") |> 
  rename(lyrics = line) |> 
  select(lyrics, song_name, album)


### Preparing All Data Frames for Join
# DataFrame1
NeededAlbums <- NeededAlbums |> 
  select(-song_id, -section_artist, -section_name, -artist_name) |> 
  rename(lyrics = line)

# DataFrame2
allLyrics <- allLyrics |> 
  select(-section_artist, -artist_name, -section_name) |> 
  mutate(album = "Mr. Morale & The Big Steppers")

### Binding all together
EVERYLYRICS <- rbind(NeededAlbums, allLyrics, Silent_Hill, The_Recipe_Remix)
EVERYLYRICS

### Collapsing song lyrics into one line
CombinedText <- EVERYLYRICS |> 
  group_by(song_name, album) |> 
  summarize(combined_lines = paste(lyrics, collapse = " ")) |> 
  ungroup()


### Performing join between Spotify and Genius data sets
### But before this, I need to modify the names because we will be joining by track_name
### So, as to be sure the names match in both Spotify and Genius data sets
albums$track_name[1] <- "United in Grief"
albums$track_name[5] <- "Father Time"
albums$track_name[6] <- "Rich (Interlude)"
albums$track_name[13] <- "Savior (Interlude)"
albums$track_name[17] <- "Mother I Sober"
albums$track_name[25] <- "LOYALTY."
albums$track_name[29] <- "LOVE."
albums$track_name[30] <- "XXX."
albums$track_name[35] <- "For Free? (Interlude)"
albums$track_name[41] <- "For Sale? (Interlude)"                                      
albums$track_name[44] <- "How Much a Dollar Cost" 
albums$track_name[58] <- "Swimming Pools (Drank)" 
albums$track_name[62] <- "The Recipe"
albums$track_name[65] <- "The Recipe (Black Hippy Remix)"
albums$track_name[63] <- "Black Boy Fly"
albums$track_name[64] <- "Now or Never"
albums$track_name[66] <- "Bitch, Don’t Kill My Vibe (Remix)"
albums$track_name[67] <- "Fuck Your Ethnicity"
albums$track_name[70] <- "No Make-Up (Her Vice)"
albums$track_name[73] <- "Ronald Reagan Era (His Evils)"
albums$track_name[74] <- "Poe Mans Dreams (His Vice)"
albums$track_name[76] <- "Keisha’s Song (Her Pain)"
albums$track_name[78] <- "Kush & Corinthians (His Pain)"
albums$track_name[80] <- "Ab-Soul’s Outro"
albums$track_name[81] <- "HiiiPoWeR"
albums$track_name[34] <- "Wesley’s Theory"
albums$track_name[46] <- "The Blacker the Berry"
albums$track_name[47] <- "You Ain’t Gotta Lie (Momma Said)"
albums$track_name[56] <- "good kid"
albums$track_name[59] <- "Sing About Me, I’m Dying of Thirst"
albums$track_name[68] <- "Hol’ Up"
albums$track_name[71] <- "Tammy’s Song (Her Evils)"
albums$track_name[39] <- "u"
albums$track_name[48] <- "i (Album Version)"
albums$track_name[57] <- "m.A.A.d city"

CombinedText$song_name[77] <- "u"
CombinedText$song_name[36] <- "i (Album Version)"
CombinedText$song_name[44] <- "m.A.A.d city"
CombinedText$song_name[30] <- "good kid"

##### Performing Join between Spotify data and Genius data
kendricklyrics <- inner_join(CombinedText, albums, by = c("song_name" = "track_name"))

### Renaming combined lines to lyrics and remove unwanted column
kendricklyrics <- kendricklyrics |> 
  rename(lyrics = combined_lines) |> 
  select(-artist_name, -album_id, -album_release_date, -album)


##################### DATA CLEANING (LYRICS CLEANING) #####################
## Some more cleaning need to be done on the lyrics. For instance, removing digits, 
## punctuation and so on

kendricklyrics$lyrics <- kendricklyrics$lyrics |> 
## removing newline characters
  str_replace_all(pattern = "\\n", replacement = " ") |>
## removing punctuation
  str_replace_all(pattern = "[.!?()\\[\\],—\\-/\\\\:;]", replacement = "") |>
## removing digits
  str_replace_all(pattern = "\\d", replacement = "") |>
## replacing consecutive spaces with just a single space
  str_replace_all(pattern = " {2,}", replacement = " ") |>
## convert all texts to lower character
  str_to_lower() |>
## removing characters like  \"\"
  str_replace_all(pattern = "\"", replacement = "") |>
## removing texts enclosed in bracket [] and (), and ** and replace with space
  str_replace_all(pattern = "\\[.*?\\]|\\(.*?\\)|\\*\\*.*?\\*\\*", replacement = " ") |> 
## replacing words that end with "'in" with the proper "ing"
  str_replace_all(pattern =  "in'", "ing")

##### Further data (lyrics) cleaning 
### renaming certain words properly
kendricklyrics <- kendricklyrics |> 
  mutate(lyrics = str_replace_all(lyrics, c("won't" = "will not",
                                            "won’t" = "will not",
                                            "can't" = "can not",
                                            "can’t" = "can not",
                                            "ain't" = "have not",
                                            "ain’t" = "have not",
                                            "don't" = "do not",
                                            "don’t" = "do not",
                                            "iam" = "i am",
                                            "'ll" = " will",
                                            "'re" = " are",
                                            "'ve" = " have",
                                            "'m" = " am",
                                            "’m" = "am",
                                            "'d" = " would",
                                            "’d" = " would",
                                            "'s" = "",
                                            "’s" = "",
                                            "y'all" = "you all",
                                            "y’all" = "you all",
                                            "'bout" = "about",
                                            "’bout" = "about",
                                            "'em" = "them",
                                            "’em" = "them",
                                            "gon'" = "going to",
                                            "gon’" = "going to",
                                            "dat" = "that",
                                            "wanna" = "want to",
                                            "tryna" = "trying to",
                                            "outta" = "out of",
                                            "gotta" = "got to")))

# Remove words enclosed in asterisks
## These words are used for sounds in lyrics like *screaming*, *gulping*
kendricklyrics$lyrics <- str_replace_all(kendricklyrics$lyrics, "\\*\\w+\\*", "")

##### Further Cleaning
# Remove undesirable words (manual list of unnecessary words)
# Remove stop words (overly common words such as "and", "the", "a", "of", etc.)
# Remove words with fewer than three characters (often used for phonetic effect in music)
# Split the lyrics into individual words (tokenization)

### List of unwanted words
unwanted_words <- c("yah", "oh", "nah", "huh", "uh", "uhh", "yeah", "ooh", "ah", "ahh", "ha",
                    "mm", "whoa", "haa", "woi", "hey", "shh", "woopdiwoopwoop", "yup", "yupyup",
                    "ooh", "baby", "mmm", "hmm", "woahohohoh", "brrt", "oohoohooh dada",
                    "yee", "yawk", "da", "ohoh", "mm", "zoom", "hahahahahahahahahahahaha",
                    "aha", "heyeah", "aha", "ohhhh", "ayy", "ugh", "uhuh", "woopdiwoop",
                    "woahwoah", "iii", "oohoohooh", "sheesh", "ya", "ayy", "woah",
                    "woahwoahwoahwoah", "yep")

## Tokenize, remove unwanted words, remove two letter words and stop words
kendrick_cleaned <- kendricklyrics |> 
  unnest_tokens(word, lyrics) |> # tokenize lyrics
  filter(!word %in% unwanted_words) |> #remove unwanted words
  filter(!nchar(word) < 3) |> # remove two letter words
  anti_join(stop_words) # remove stop words


###################################### ANALYSIS ######################################
##### VALENCE ALBUM BY ALBUM
vale <- pirateplot(valence ~ album_name,
           data = kendricklyrics,
           pal = "southpark", 
           xlab = "ALBUM", ylab = "VALENCE",
           theme = 0, point.o = 0.7, avg.line.o = 1, jitter.val = .05, 
           bty = "n", cex.axis = 0.6, xaxt = "n",
           main = "HOW POSITIVE ARE KENDRICK LAMAR'S ALBUMS?") 
axis(1, cex.axis = 0.6, lwd = 0)
legend("bottomright", c("1: DAMN.", "2: good kid, \n m.A.A.d city (Deluxe)", 
        "3: Mr. Morale & The Big Steppers", "4: Section.80", "5: To Pimp A Butterfly"), bty = "n", cex = 0.6)


##### VALENCE
### Creating function for tables
## since I will be making tables a lot, I created a function
## for the most common codes I will use for the tables
create_table <- function(data) {
  gt(data) |> 
    gt_theme_nytimes() |> 
    cols_width(
      everything() ~ px(120)) |> 
    tab_style(
      style = cell_text(color = "black"),
      locations = cells_column_labels())
}

#### valence by albums
kendricklyrics |> 
  select(album_name, valence) |> 
  group_by(album_name) |> 
  summarise(mean_valence = sum(valence)/n()) |>
  arrange(desc(mean_valence)) |> 
  ungroup() |> 
  create_table() |> 
  gt_color_rows(mean_valence, palette = "ggsci::blue_material") |> 
  cols_width(
    album_name ~ px(180))

### Top 10 tracks with lowest valence
kendricklyrics |> 
  select(song_name, album_name, valence) |> 
  arrange(valence) |>
  head(10) |> 
  create_table() |> 
  gt_color_rows(valence, palette = "ggsci::blue_material") |> 
  cols_width(
    song_name ~ px(150),
    album_name ~ px(190))

### Top 10 tracks with highest valence
kendricklyrics |> 
  select(song_name, album_name, valence) |> 
  arrange(desc(valence)) |> 
  top_n(10) |> 
  create_table() |> 
  gt_color_rows(valence, palette = "ggsci::blue_material") |> 
  cols_width(
    song_name ~ px(150),
    album_name ~ px(190))


##### TOTAL WORD COUNT PER ALBUM
#### Making a theme function
plot_theme <- function() {
  theme_minimal() +
    theme(
      panel.grid = element_blank(),
      axis.ticks.y = element_blank(),
      axis.ticks.x = element_blank(),
      axis.title.x = element_blank(),
      axis.text = element_text(colour = "#000000"),
      text = element_text(colour = "#000000", family = "source", size = 14))
}

#### Adding font
font_add_google("Source Code Pro", family = "source")
showtext_auto()

#### WORD COUNT PER ALBUM
kendricklyrics |> 
  unnest_tokens(word, lyrics) |>
  group_by(album_name) |>
  summarize(wordcount = n()) |>
  arrange(desc(wordcount)) |> 
  ungroup() |> 
  ggplot(data = _, mapping = aes(x = reorder(album_name,wordcount), y = (wordcount))) +
  geom_col(width = 0.6, size = 0.5) +
  labs(x = "Album", y = "Number of Words") +
  coord_flip() +
  plot_theme()

#### Top songs that contain the highest word count
kendricklyrics |> 
  unnest_tokens(word, lyrics) |>
  group_by(song_name, album_name) |>
  summarize(wordcount = n()) |>
  arrange(desc(wordcount)) |> 
  ungroup() |> 
  head(10) |> 
  create_table() |> 
  gt_color_rows(wordcount, palette = "ggsci::blue_material") |> 
  cols_width(
    song_name ~ px(180),
    album_name ~ px(195))

#####  OVERALL MOST FREQUENTLY USED WORDS ACROSS ALL ALBUMS
### Wordcloud
allalbums_wordcount <- kendrick_cleaned |> 
  count(word, sort = TRUE) 

wordcloud(words = allalbums_wordcount$word, 
          freq = allalbums_wordcount$n, 
          min.freq = 1,
          max.words=200, random.order=FALSE, 
          rot.per=0.35,            
          colors=brewer.pal(8, "Dark2"))

#####  MOST FREQUENTLY USED WORDS (PER ALBUM)
### Wordcloud

### Writing a function to plot word cloud for each album
makewordcloud <- function(album) {
wordclouddf <- kendrick_cleaned |>
  filter(album_name == album) |> 
  count(word, sort = TRUE) 

wordcloud(words = wordclouddf$word,
          freq = wordclouddf$n, 
          min.freq = 1,
          max.words=200, random.order=FALSE, 
          rot.per=0.35,            
          colors=brewer.pal(8, "Dark2"))
}

### For each album
makewordcloud("Section.80")
makewordcloud("good kid, m.A.A.d city (Deluxe)")
makewordcloud("To Pimp A Butterfly")
makewordcloud("DAMN.")
makewordcloud("Mr. Morale & The Big Steppers")


##### LEXICAL DIVERSITY PER ALBUM
## tokenize lyrics
tokens <- kendricklyrics |> 
  group_by(album_name) |>
  summarize(text = paste(lyrics, collapse = " ")) |>
  unnest_tokens(word, text) 

## calculate lexical diversity
tokens |>
  group_by(album_name) |>
  summarize(total_words = n(),
            distinct_words = n_distinct(word)) |> 
  arrange(desc(distinct_words)) |> 
  ungroup() |> 
  create_table() |> 
  gt_color_rows(distinct_words, palette = "ggsci::blue_material") |> 
  cols_width(
    album_name ~ px(180))

##### LEXICAL DENSITY PER ALBUM
tokens |>
  group_by(album_name) |>
  summarize(total_words = n(),
            distinct_words = n_distinct(word)) |>
  mutate(lexical_density = distinct_words / total_words) |> 
  arrange(desc(lexical_density)) |> 
  create_table() |> 
  gt_color_rows(lexical_density, palette = "ggsci::blue_material") |> 
  cols_width(
    album_name ~ px(180))

##### MOST LEXICALLY DENSE SONGS
kendricklyrics |> 
  unnest_tokens(word, lyrics) |> 
  group_by(album_name, song_name) |> 
  summarize(lexical_density = n_distinct(word)/n()) |> 
  arrange(desc(lexical_density)) |> 
  ungroup() |> 
  head(10) |> 
  create_table() |> 
  gt_color_rows(lexical_density, palette = "ggsci::blue_material") |> 
  cols_width(
    album_name ~ px(180))
## put in Nice GT Tables

##### LEAST-LEXICALLY DENSE SONGS
kendricklyrics |> 
  unnest_tokens(word, lyrics) |> 
  group_by(album_name, song_name) |> 
  summarize(lexical_density = n_distinct(word)/n()) |> 
  arrange(lexical_density) |> 
  ungroup() |> 
  head(10) |> 
  create_table() |> 
  gt_color_rows(lexical_density, palette = "ggsci::blue_material") |> 
  cols_width(
    album_name ~ px(180))

############################### SENTIMENT ANALYSIS ###############################
###### EXPLORING SENTIMENT LEXICONS
### function to get count of sentiment categories for each of the lexicon libraries
sentiment_summary <- function(sentiment_source) {
  sentiment_data <- get_sentiments(sentiment_source)
  
  if ("value" %in% colnames(sentiment_data)) {
    sentiment_data <- sentiment_data |> 
      mutate(sentiment = ifelse(value >= 0, "positive", "negative")) |> 
      group_by(sentiment) |> 
      summarize(count = n())
  } else {
    sentiment_data <- sentiment_data |> 
      group_by(sentiment) |> 
      summarize(count = n())
  }

  return(sentiment_data)
}

sentiment_summary("afinn")
sentiment_summary("bing")
sentiment_summary("nrc")

###### Finding Match Ratio Between Lyrics and Each of the Sentiment Lexicon
sentiments <- list(afinn_sentiments = "afinn",
                   nrc_sentiments = "nrc",
                   bing_sentiments = "bing")

lapply(sentiments, function(x) {
  get_sentiments(x) |> 
    inner_join(kendrick_cleaned, by = "word") |> 
    distinct(word) |> 
    summarize(match_words = n())
})
### nrc lexicons has the most word match

##### CREATING SENTIMENTS DATASETS
### afinn
kendrick_afinn <- kendrick_cleaned |> 
  inner_join(get_sentiments("afinn"), by = "word")

### bing
kendrick_bing <- kendrick_cleaned |> 
  inner_join(get_sentiments("bing"), by = "word")

### nrc
kendrick_nrc <- kendrick_cleaned |> 
  inner_join(get_sentiments("nrc"), by = "word")
### nrc sub
kendrick_nrc_sub <- kendrick_cleaned |> 
  inner_join(get_sentiments("nrc"), by = "word") |> 
  filter(!sentiment %in% c("positive", "negative"))


##### SENTIMENT RANKING OF KENDRICK LAMAR'S ALBUMS
### Examining sentiments using Afinn lexicon
kendrick_afinn |> 
  group_by(album_name) |> 
  summarise(sentiment = sum(value)) |> 
  ungroup() |> 
  ggplot(data = _, mapping = aes(x = album_name, y = sentiment)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  plot_theme()

### I create a function to make the following plots since I will be reusing the same code
## plot function to create all 3 sentiment plots
create_sentiment_plot <- function(df) {
  df |> 
    group_by(sentiment) |> 
    summarise(word_count = n()) |> 
    ungroup() |> 
    mutate(sentiment = reorder(sentiment, word_count)) |> 
    ggplot(data = _, mapping = aes(x = sentiment, y = word_count)) +
    geom_col() +
    coord_flip() +
    plot_theme()
}

### Examining Overall Mood of Kendrick's Lyrics Using NRC lexicon
create_sentiment_plot(kendrick_nrc)

### Examining using Nrc lexicon without positive or negative words
create_sentiment_plot(kendrick_nrc_sub)

### Examining sentiment using Bing lexicon
create_sentiment_plot(kendrick_bing)

### Album by Album sentiment check using Bing lexicon
kendrick_bing |> 
  group_by(album_name,sentiment) |> 
  summarise(word_count = n()) |> 
  ungroup() |> 
  ggplot(data = _, mapping = aes(x = sentiment, y = word_count)) +
  geom_col() +
  facet_wrap(~ album_name) + 
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    text = element_text(colour = "#000000", family = "source", size = 12))


### Top 10 tracks with highest negative words (bing lexicon)
kendrick_bing |> 
  filter(sentiment == "negative") |> 
  group_by(song_name, album_name) |> 
  summarise(word_count = n()) |> 
  ungroup() |>
  arrange(desc(word_count)) |> 
  slice(1:10) |> 
  create_table() |> 
  gt_color_rows(word_count, palette = "ggsci::blue_material") |> 
  cols_width(
    album_name ~ px(180))
################################### END ######################################