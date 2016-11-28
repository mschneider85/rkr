SELECT
  links.id AS searchable_id,
  'Link' AS searchable_type,
  links.title AS title,
  links.url AS body,
  links.votes_count AS votes_count,
  links.votes_sum AS votes_sum,
  links.updated_at AS updated_at,
  links.created_at AS created_at,
  links.author_id AS author_id
FROM links

UNION

SELECT
  snippets.id AS searchable_id,
  'Snippet' AS searchable_type,
  snippets.title AS title,
  snippets.body AS body,
  snippets.votes_count AS votes_count,
  snippets.votes_sum AS votes_sum,
  snippets.updated_at AS updated_at,
  snippets.created_at AS created_at,
  snippets.author_id AS author_id
FROM snippets
