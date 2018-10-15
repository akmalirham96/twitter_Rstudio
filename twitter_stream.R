#Make sure you have apply for twitter developer
#Install the library by clicking tool and search twitteR
library(twitteR)

#Enter your API key from twitter developer
consumer_key <- ""
consumer_secret <- ""
access_token <- ""
access_token_secret <- ""

setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_token_secret)

#Enter your account 
account <- ""
account

# n = number of tweet that you want to extract
account.timeline <- userTimeline(account,n=500,includeRts = TRUE)

TrialDF <- twListToDF(account.timeline)
file.timeline <- paste(account,"test.csv",sep = "")
write.csv(TrialDF,file.timeline)

