SELECT
  links.id AS postable_id,
  'Link' AS postable_type,
  links.title AS title,
  links.url AS body,
  links.votes_count AS votes_count,
  links.votes_sum AS votes_sum,
  round(cast(log(greatest(abs(links.votes_sum), 1)) * sign(links.votes_sum) + (date_part('epoch', links.created_at) - 1134028003) / 45000.0 as numeric), 7) as hotness,
  links.created_at AS created_at,
  links.author_id AS author_id
FROM links

UNION

SELECT
  snippets.id AS postable_id,
  'Snippet' AS postable_type,
  snippets.title AS title,
  snippets.body AS body,
  snippets.votes_count AS votes_count,
  snippets.votes_sum AS votes_sum,
  round(cast(log(greatest(abs(snippets.votes_sum), 1)) * sign(snippets.votes_sum) + (date_part('epoch', snippets.created_at) - 1134028003) / 45000.0 as numeric), 7) as hotness,
  snippets.created_at AS created_at,
  snippets.author_id AS author_id
FROM snippets
