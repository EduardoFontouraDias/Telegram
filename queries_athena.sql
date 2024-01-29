Quantidade de mensagens por dia.(Query1)
SELECT  context_date,  count(1) AS "message_amount" FROM telegram
GROUP BY context_date
ORDER BY context_date DESC

Quantidade de mensagens por usuário por dia(Query2)

SELECT
  user_id,
  user_first_name,
  context_date,
  count(1) AS "message_amount"
FROM telegram
GROUP BY
  user_id,
  user_first_name,
  context_date
ORDER BY context_date DESC

Média dos tamanhos das mensagens por usuário por dia(Query3)

SELECT
  user_id,
  user_first_name,
  context_date,
  CAST(AVG(length(text)) AS INT) AS "average_message_length"
FROM "telegram"
GROUP BY
  user_id,
  user_first_name,
  context_date
ORDER BY context_date DESC

Quantidade de mensagens por hora por dia da semana por número da semana(Query4)
  
WITH
parsed_date_cte AS (
    SELECT
        *,
        CAST(date_format(from_unixtime("date"),'%Y-%m-%d %H:%i:%s') AS timestamp) AS parsed_date
    FROM "telegram"
),
hour_week_cte AS (
    SELECT
        *,
        EXTRACT(hour FROM parsed_date) AS parsed_date_hour,
        EXTRACT(dow FROM parsed_date) AS parsed_date_weekday,
        EXTRACT(week FROM parsed_date) AS parsed_date_weeknum
    FROM parsed_date_cte
)
SELECT
    parsed_date_hour,
    parsed_date_weekday,
    parsed_date_weeknum,
    count(1) AS "message_amount"
FROM hour_week_cte
GROUP BY
    parsed_date_hour,
    parsed_date_weekday,
    parsed_date_weeknum
ORDER BY
    parsed_date_weeknum,
    parsed_date_weekday

Quantidade de usuários que interagem com o bot do grupo(Query5)

SELECT user_first_name FROM telegram
GROUP BY user_first_name
