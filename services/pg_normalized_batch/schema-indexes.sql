CREATE INDEX ON tweet_tags(tag, id_tweets);
CREATE INDEX ON tweet_tags(lang, tag, id_tweets);
CREATE INDEX ON tweets(lang);
