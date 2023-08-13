# Sentiment-Analysis-of-Kendrick-Lamar-s-Discography

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/3b907c6d-f9ae-4052-95dd-572437828d65)


I. Introduction
During a casual internet browsing session in 2015, I came across an article discussing the provocative aspects of one of Kendrick Lamar’s tracks, “The Blacker The Berry,” from his critically acclaimed album, “To Pimp a Butterfly.” Intrigued by the thought-provoking analysis of the song, I decided to give it a listen. Lamar’s impassioned delivery, the powerful subject matter, and the intricate depth of the lyrics instantly captivated me. This profound experience left an indelible impression and ignited a desire to explore Lamar’s discography further.

After immersing myself in his music, I became convinced that “To Pimp a Butterfly” was Lamar’s magnum opus, and he quickly ascended to become one of my all-time favorite artists. As I delved deeper into his work, I was struck by the emotional intensity of his music and its profound impact on me. Lamar’s unique fusion of conscious rap, jazz, and funk elements resonated deeply, and I knew that if I were to conduct a study on any musician, it would be an analysis of Kendrick Lamar’s music.

With this goal in mind, I embark on a text analysis project to examine Lamar’s lyrics from his debut studio album, “Section.80,” released in 2011, to his latest release, “Mr. Morale & The Big Steppers,” in 2022. Driven by curiosity, I sought to explore the dominant themes in his music, trace the evolution of his lyrical content over time, and discern the emotional nuances conveyed throughout his albums.

II. Data
To assemble the necessary data for my analysis, I leveraged the Spotify API to acquire information about Kendrick Lamar’s albums. Additionally, I employed the Genius Lyrics API to extract the lyrics for each album. Genius Lyrics proved to be an indispensable resource, as it stands as one of the most popular platforms for music lyrics.

To focus exclusively on Kendrick Lamar’s studio albums for my analysis, I filtered out certain projects. For example, I excluded the “Black Panther” album, a collaborative effort between Kendrick and various artists, created specifically for the “Black Panther” movie. Furthermore, I dismissed the “DAMN. COLLECTORS EDITION” album, as it simply rearranges the tracks from the original “DAMN.” album. Kendrick intended the original “DAMN.” album to be experienced in reverse order, beginning with the last track, and the collector’s edition was merely a version with the tracks reordered accordingly.

Additionally, I eliminated the mixtape album “Overly Dedicated” and the compilation album “untitled unmastered.” Ultimately, I opted for the deluxe version of “good kid, m.A.A.d city,” which features all the original tracks plus several additional ones, over the original version. After filtering, I was left with a total of five albums for my analysis: “Section.80,” “good kid, m.A.A.d city (Deluxe),” “To Pimp A Butterfly,” “DAMN.,” and “Mr. Morale & The Big Steppers,” organized in chronological order of release.

The code for this project can be found here.

III. Analysis
To commence my analysis, I first explored the data provided by Spotify’s API, which offers a variety of track attributes, such as valence, liveness, speechiness, and instrumentalness, among others. In my investigation, I chose to concentrate primarily on valence, as it is the most pertinent attribute for my analysis of Kendrick Lamar’s music. While other attributes like danceability, instrumentalness, or liveness might be valuable for different genres, I deemed them less relevant for examining rap music.

a) Valence

Spotify’s API characterizes “valence” as a metric assessing whether a song is likely to evoke feelings of happiness (higher valence) or sadness (lower valence) in the listener. This metric is measured on a scale that spans from 0.0 to 1.0, with values approaching 1.0 suggesting a more positive, uplifting sound (e.g., cheerful, euphoric), while values nearing 0.0 indicate a more negative, somber sound (e.g., sad, depressed, angry). In essence, valence offers an estimation of the musical positivity conveyed by a track.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/3414bcac-1045-464d-b136-e224cd722eae)


The pirate plot provides a visual depiction of the valence of individual tracks from each of Kendrick Lamar’s albums (represented by dots) and the average valence of the album itself (denoted with a thick line). “good kid, m.A.A.d city (deluxe)” seems to exhibit the lowest mean valence, with the majority of its tracks registering a valence below 0.4. This is unsurprising, considering the album’s introspective themes that delve into the harsh realities of growing up in Compton, including losing friends and grappling with gang culture and racism. For example, tracks like “Sing About Me, I Am Dying of Thirst” tackle these sensitive subjects, resulting in a poignant and somber listening experience.

Intriguingly, only two of Kendrick’s albums have a mean valence marginally above 0.5. This is not unexpected, as his music is often typified by introspection and social commentary. For instance, “Section.80” narrates the experience of growing up amidst the crack epidemic, gang violence, and systemic racism of the 1980s. Similarly, “To Pimp A Butterfly” wrestles with the guilt Kendrick feels after achieving fame and leaving his loved ones behind in Compton, while “DAMN.” examines the tension between free will and destiny. In contrast, “Mr. Morale & The Big Steppers” is a reflective album that explores Kendrick’s relationships with family and self-discovery.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/6551e28a-c925-4101-85fa-7ee9a7e39edb)


Overall, except for “good kid, m.A.A.d city (deluxe)”, which has a mean valence below 0.36, all of Kendrick’s albums fall between 0.45 and 0.5. This emphasizes the notion that Kendrick’s music is often characterized by introspective, thought-provoking themes that may not necessarily correspond to a particularly high valence.

Top 10 tracks with the lowest valence

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/f49c191b-d235-4415-8c8e-badf6a8a74e1)


Upon further examination, it is fascinating to observe that six out of the top ten tracks with the lowest valence belong to the “good kid, m.A.A.d city (deluxe)” album. While this may astonish some, it aligns with the album’s overall introspective and frequently somber themes.

It is important to recognize that valence is not necessarily an ideal indicator of a track’s emotional impact. For instance, “Keisha’s Song (Her Pain),” which narrates the tragic real-life story of one of Kendrick’s female friends, is not assigned an exceptionally low valence by Spotify. Yet, upon listening to the track, one cannot help but be touched by its raw emotional intensity. Such examples remind us that while valence can offer a useful metric for assessing a song’s overall emotional tone, it should not be regarded as the sole determinant of a track’s emotional impact.

Top 10 tracks with highest valence


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/59a7c77d-f243-4618-ad66-9bc7614c75f6)


Another intriguing finding from my analysis is that “The Heart Part 5,” a track from Kendrick’s “Mr. Morale & The Big Steppers” album, received a surprisingly high valence score. While a few elements of the song may contain uplifting lyrics, such as the third verse, I would not have anticipated it to receive such a high score overall.

Additionally, it is noteworthy that four out of the top ten songs with the highest valence are from the “Mr. Morale & The Big Steppers” album. While this is a subjective assessment and opinions may differ, I personally do not entirely concur with this conclusion. It is worth noting, however, that Spotify does not explicitly disclose the exact method it employs to determine a song’s valence.

b) Word Count

Word count is a crucial aspect of rap music, and a comprehensive analysis of word count in Kendrick Lamar’s discography reveals intriguing patterns and trends. Among his albums, “good kid, m.A.A.d city (Deluxe)” boasts the highest total word count, while his debut album, “Section.80,” has the lowest. This is unsurprising, as “good kid, m.A.A.d city (Deluxe)” is a storytelling album featuring long narratives and intricate lyricism.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/75fa08a2-297c-4b78-ba95-8862cae94799)

Tracks such as “Sing About Me, I’m Dying of Thirst” and “Real” exemplify Kendrick’s remarkable lyricism and captivating storytelling skills. With a total runtime exceeding 95 minutes and an average track length of 5 minutes, “good kid, m.A.A.d city (Deluxe)” stands as the longest of Kendrick’s albums. Close contenders in terms of duration include “To Pimp A Butterfly” and “Mr. Morale & The Big Steppers,” both spanning 78 minutes. Interestingly, Kendrick’s albums have generally seen a rise in word count since his debut studio album, “Section.80,” with the notable exception of his Pulitzer Prize-winning 2017 album, “DAMN.”

Top 10 Songs by Word Count

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/93ca8570-d41c-4712-921e-70f789297ee0)

The 12-minute songs “Mortal Man” and “Sing About Me, I’m Dying of Thirst” closely vied for the title of highest word count. Ultimately, “Mortal Man” from the “To Pimp A Butterfly” album claimed the top spot, reportedly inspired by Kendrick’s visit to Nelson Mandela’s cell on Robben Island during his South African trip. Intriguingly, most of the highest word count songs are from “good kid, m.A.A.d city (Deluxe),” boasting four tracks in total, with “Mr. Morale & The Big Steppers” following closely behind at three.

Most Common Words in Kendrick’s Albums

Analyzing the frequency of individual words in Kendrick’s music can reveal crucial patterns and trends, such as repetition or rarity, offering deeper insights into his artistic style and message. To focus on the most impactful words in Kendrick’s lyrics, unwanted words like sound effects, interjections like “ah,” “oh,” and “uh,” and common stop words like “the,” “and,” and “in” were removed.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/4c95eb9d-e890-432a-b7dd-1eb5f4b08e69)

Across his albums, the “n-word” emerges as the most frequently used, reflecting its prevalence in rap music. Other common words include expletives such as “fuck” and “bitch,” influenced by tracks like “We Cry Together” and “Bitch, Don’t Kill My Vibe.” Kendrick frequently uses words like “live,” “die,” “dead,” “living,” “hate,” “deep,” “kill,” “love,” “life,” “money,” “pain,” “truth,” “loyalty,” “feel,” “feelings,” “world,” and “homie,” reflecting the themes and stories conveyed in his music. Interestingly, “Compton,” Kendrick’s hometown, ranks among his most-used words, underscoring his strong connection to the city. A word cloud was generated for each album, illustrating the most common words and providing a visual representation of the recurring themes and motifs in Kendrick Lamar’s music.

Word Cloud for Each Album

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/24c12b31-33ca-41c3-95b8-367097a9bb57)


Mr. Morale & The Big Steppers

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/81ce95da-1907-4921-a1c8-1a7853ddcd3f)

The word cloud analysis offers insights into the themes and emotions Kendrick explores in each album. In “Section.80,” words like “police,” “ethnicity,” “kill,” “crack,” and “pain” dominate, reflecting the challenges of growing up in the 80s. “good kid, m.A.A.d city (Deluxe)” features words like “love,” “life,” “kill,” and “gun,” highlighting his autobiographical account of his upbringing. “To Pimp A Butterfly” delves into Kendrick’s guilt for leaving his family and friends in Compton, with words such as “resentment,” “depression,” and “power.” “DAMN.” grapples with free will versus destiny, using words like “fear,” “God,” and “living.” Finally, “Mr. Morale & The Big Steppers” focuses on Kendrick’s relationship with his family, employing words such as “pain,” “hope,” and “faith.”

I find it interesting that the word “God” appears frequently in all albums, reflecting religious themes in Kendrick’s music. He has explored his religious beliefs throughout his career, with lyrics like “Lord save me, the devil is working hard” in “hiiipower” and “I believe that Jesus is Lord” in “good kid, m.A.A.d city.” In a letter responding to an article about “DAMN,” Kendrick stated:

“I feel it’s my calling to share the joy of God, but with exclamation, more so, the FEAR OF GOD, the balance, knowing the power of what he can build and what he can destroy at any given moment.”

Comparing Word Clouds: Section.80 (2011) vs. Mr. Morale & The Big Steppers (2022)

Upon comparing the word clouds of Kendrick Lamar’s first studio album, Section.80,” from 2011 and his latest album, “Mr. Morale & The Big Steppers,” released in 2022, I observed noteworthy consistencies and disparities in his lyrical content over time.

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/0a30084c-121c-46c8-a693-994af41cee27)


A careful examination of the word clouds for “Section 80” and “Mr. Morale & The Big Steppers” reveals that many words, such as life, live, die, God, love, and black, are persistently present in both albums. Despite the varying themes and subject matter of each album, Kendrick’s approach to storytelling has remained relatively consistent. His exploration of societal issues and personal experiences is conveyed through a stable and expressive linguistic style that has not undergone significant changes over the years.

c) Lexical Diversity

Lexical diversity and lexical density are linguistic features that can be used to analyze text. Higher vocabulary variation results in greater lexical diversity. Song Vocabulary measures the number of unique words used in a song and counts the number of distinct words in an album. In this analysis, I tokenized the original dataset again, including all stop and short words, as I aimed to gain more quantitative insights from this plot.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/2369a564-6415-48da-871f-e9f4a6a14af5)



The analysis indicates that “good kid, m.A.A.d city (deluxe)” boasts the highest number of distinct words, followed by “Mr. Morale & The Big Steppers” and “To Pimp a Butterfly.” However, lexical diversity only considers the absolute number of distinct words in a text. To better comprehend the relationship between the number of distinct words and the total number of words, we can use lexical density as a measure of the proportion of lexical items.

d) Lexical Density

Lexical density is the ratio of unique words to the total number of words in a text. Token-type ratios are often employed to calculate lexical diversity and density, taking the number of unique words (types) and dividing it by the total number of words (tokens) in the text.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/0c9d4e6c-c12a-4690-9065-88f5363c7762)

“Good Kid, M.A.A.D City (Deluxe)” has the highest lexical diversity, while “DAMN” exhibits the highest lexical density. It is interesting to note that albums with lower total word counts tend to have higher lexical density. This is logical, as a higher proportion of unique words in a smaller text will likely result in a higher lexical density.

Most Lexically Dense Songs


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/c07445da-a9df-44ad-9a15-ae89dc2597cd)

The song “DUCKWORTH” stands out for its high lexical density. Although the track “BLOOD.” has the highest lexical density, it is a 1-minute, 59-second track that opens his 2017 “DAMN” album. Four out of ten tracks are from “DAMN.” Chapter ten is also shorter than 90 seconds. “Rich Interlude” is under 2 minutes, as is the fifth song. This makes sense because an artist is less likely to repeat phrases in shorter songs. The songs that dominate here are generally shorter in duration.

Least Lexically Dense Songs

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/c8b9d616-85ae-459e-91b3-9a4780d0affc)


“Crown,” a track from the album “Mr. Morale & The Big Steppers,” takes the lead in the least lexically dense songs. Kendrick frequently repeats the statement “I can’t please everybody” throughout the chorus, verses, and outro, emphasizing his conflicting emotions about being a community leader, doing his best, and inevitably failing to satisfy everyone.

e) Sentiment Analysis

Sentiment analysis is a valuable technique that allows us to comprehend the emotional tone and attitudes expressed in written text. Kendrick Lamar’s lyrics are no exception, and by utilizing the tidytext package, I explored three distinct lexicons: AFINN, Bing, and NRC. AFINN scores words on a scale of -5 to 5, with negative scores representing negative sentiment and positive scores indicating positive sentiment. Bing categorizes words as either positive or negative, while the NRC assigns words to ten different categories, including positive, negative, anger, anticipation, disgust, fear, joy, sadness, surprise, and trust.

To determine the most suitable lexicon for analyzing Kendrick Lamar’s lyrics, I looked for matches between the data and each sentiment lexicon. After comparing the ratio of matched words in each lexicon, I found that the NRC lexicon had the highest number of matches. Nonetheless, I used all three lexicons in my analysis to gain a comprehensive understanding of the emotional tones conveyed in the lyrics.

To ensure the accuracy of the sentiment analysis, I removed all stop words and unwanted words, such as sounds, from the lyrics. By doing so, I was able to delve into the emotional tones and attitudes expressed in Kendrick Lamar’s lyrics.

Sentiment Ranking Based on AFINN Lexicon

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/db26ae2d-6f1f-42a2-992d-4988e458fee3)

Despite the inspiring and powerful messages often conveyed in Kendrick Lamar’s music, his lyrics tend to have a negative sentiment. This is evident not only in the words he uses, but also in the titles of his songs, which often explore challenging and difficult aspects of life, such as “Mother, I’m Sober,” “Sing About Me, I’m Dying of Thirst,” and “We Cry Together.”

After analyzing Kendrick’s albums using various sentiment lexicons, it was found that all his albums have a predominantly negative sentiment. Specifically, albums like “good kid m.A.A.d city (deluxe)” and “Mr. Morale & The Big Steppers” had the highest negative sentiment scores, followed by “Section.80,” “To Pimp A Butterfly,” and “DAMN,” which had the lowest negative sentiment score.

Examining Overall Mood of Kendrick’s Lyrics Using NRC Lexicon

To gain a comprehensive understanding of the overall mood conveyed in Kendrick’s lyrics, I utilized the NRC lexicon to analyze sentiments across all his albums, in addition to using the AFINN lexicon to classify sentiments by album.

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/77a2a378-462b-40ba-9e7f-3aeddd4769fa)

After analyzing Kendrick’s lyrics with the NRC lexicon, a chart was created to display the prevalence of positive and negative emotions. The results showed that negative emotions were more frequent than positive ones, although the difference was not statistically significant. However, it is crucial to note that the NRC lexicon tends to classify words with emotions like disgust or anger as negative, which may have contributed to the higher number of negative emotions. To address this concern, I reanalyzed the data using the NRC lexicon but excluded the negative and positive categories.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/aa2aba86-ef6e-4b74-a18d-4ce1e98358c9)


Examining Overall Mood of Kendrick’s Lyrics Using Bing Lexicon

To gain further insight into the overall mood of Kendrick Lamar’s lyrics, I used Bing’s sentiment analysis to classify sentiments into positive or negative categories across all his albums. Interestingly, the results showed that negative sentiments were more prevalent than positive ones.


![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/1b52ff41-681a-4a5b-8cd2-cb64ff059eeb)


However, it’s important to note that the negative sentiment score may have been inflated due to the inclusion of words like “fuck,” “kill,” and “bitch,” which are classified as negative in the Bing lexicon. These words appear frequently in some of Kendrick’s songs, such as “We Cry Together” and “Bitch, Don’t Kill My Vibe,” which could have contributed to the higher number of negative sentiments found in the analysis.

Album by Album Sentiment Analysis Using the Bing Lexicon

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/8c917bb9-ea82-4085-8309-3ff810680bdf)


The sentiment analysis using the Bing lexicon revealed similar results to the AFINN lexicon, indicating that Kendrick Lamar’s albums generally contain more negative sentiments than positive ones. Specifically, “good kid, m.A.A.d City (Deluxe),” “Mr. Morale & The Big Steppers,” and “To Pimp a Butterfly” were found to be the most negative of all his albums.

To further explore the sentiment analysis, I decided to identify the tracks with the highest positive and negative sentiments, using the Bing lexicon.

Top 10 most-negative tracks using Bing Lexicon

![image](https://github.com/TimileyinSamuel/Sentiment-Analysis-of-Kendrick-Lamar-s-Discography/assets/119361599/9e307160-b436-457a-bdd6-ad8c456d40b9)


After analyzing the sentiment of Kendrick Lamar’s tracks using the Bing lexicon, it was found that the track “We Cry Together” from his latest album “Mr. Morale & The Big Steppers” had the highest negative sentiment score, surpassing the 12-minute long, melancholic track “Sing About Me, I am Dying of Thirst,” which was initially anticipated to hold the top spot. Further analysis revealed that “We Cry Together” contained numerous repetitions of words classified as negative, such as “Fuck you” and “Bitch,” which were repeated at least 50 times throughout the track’s dialogue. These words significantly contributed to its overall higher negative sentiment score.

In summary, while the absolute values may differ, all three sentiment lexicons (AFINN, NRC, and Bing) indicate that Kendrick Lamar’s lyrics generally express more negative sentiments than positive ones. The AFINN lexicon yielded the highest negative values, while the NRC lexicon produced fewer negative results. However, the Bing lexicon had a higher count of negative values, possibly due to the classification of words like “fuck” and “bitch” as negative. Overall, the sentiment analysis suggests that Kendrick Lamar’s lyrics tend to convey negative emotions and sentiments.
