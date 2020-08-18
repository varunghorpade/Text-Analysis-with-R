# Go to https://apps.twitter.com
# Register API using your Twitter a/c.

api_key <- 'xxx'
api_secret <- 'xxx'
access_token <- "xxx"
access_token_secret <- "xxx"

# Load twitteR library  
install.packages("twitteR")
library(twitteR)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
covid_tweets = searchTwitter('$covid', n = 20, lang = 'en')
covid_tweets
df <- twListToDF(covid_tweets)
write.csv(df, file = '~/Applications/covid.csv', row.names = F)

#trend locations
trend <- availableTrendLocations()
head(trend)
trend

# Getting Trends
World <- getTrends(1)
World

Dublin <- getTrends(560743)
Dublin

Mumbai <- getTrends(2295411)
Mumbai
