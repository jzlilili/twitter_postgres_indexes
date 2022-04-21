SELECT '#' || t.text AS tag, COUNT(*) AS COUNT 
FROM (
    SELECT 
        data->>'id',
        jsonb_path_query(data, '$.entities.hashtags[*]')->>'text' AS text
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
    UNION
    SELECT 
        data->>'id',
        jsonb_path_query(data, '$.extended_tweet.entities.hashtags[*]')->>'text' AS text
    FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) t
GROUP BY tag
ORDER BY COUNT DESC, tag
LIMIT 1000;

