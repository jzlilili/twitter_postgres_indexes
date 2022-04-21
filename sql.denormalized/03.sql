SELECT t.lang, COUNT(*) AS COUNT
FROM (
    SELECT data->>'id', data->>'lang' AS lang
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
    UNION
    SELECT data->>'id', data->>'lang' AS lang
    FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) t
GROUP BY lang
ORDER BY COUNT DESC, lang;
