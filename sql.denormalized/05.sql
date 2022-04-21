SELECT '#' || tag AS tag, COUNT(*) AS COUNT
FROM (
    SELECT data->>'id',
           jsonb_path_query(data, '$.entities.hashtags[*]')->>'text' AS tag 
    FROM tweets_jsonb
    WHERE (to_tsvector('english', data->>'text') @@ to_tsquery('english', 'coronavirus')
       OR to_tsvector('english', data->'extended_tweet'->>'full_text') @@ 
          to_tsquery('english', 'coronavirus'))
      AND data->>'lang' = 'en'
    UNION
    SELECT data->>'id',
           jsonb_path_query(data, '$.extended_tweet.entities.hashtags[*]')->>'text' AS tag
    FROM tweets_jsonb
    WHERE (to_tsvector('english', data->>'text') @@ to_tsquery('english', 'coronavirus')
       OR to_tsvector('english', data->'extended_tweet'->>'full_text') @@ 
          to_tsquery('english', 'coronavirus'))
      AND data->>'lang' = 'en'
) t
GROUP BY tag
ORDER BY COUNT DESC, tag
LIMIT 1000;
