SELECT
    COUNT(*)
FROM (
    SELECT data->>'id'
    FROM tweets_jsonb
    WHERE to_tsvector('english', data->>'text') @@
          to_tsquery('english', 'coronavirus')
      AND data->>'lang' = 'en'
    UNION
    SELECT data->>'id'
    FROM tweets_jsonb
    WHERE to_tsvector('english', data->'extended_tweet'->>'full_text') @@
          to_tsquery('english', 'coronavirus')
      AND data->>'lang' = 'en'
) t;


