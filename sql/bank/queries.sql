-- Задание 1
-- Запрос a
SELECT
  monthname(create_date) AS months,
  COUNT(index_lead) AS amount
FROM
  test_sql
GROUP BY
  months;

-- Запрос b
SELECT
  monthname(create_date) AS months,
  SUM(index_sum) AS total_sum
FROM
  test_sql
GROUP BY
  months;

-- Запрос c
SELECT
  monthname(create_date) AS months,
  CONCAT(ROUND((SUM(index_sum) / (SELECT SUM(index_sum) FROM test_sql)) * 100.0, 2), '%') AS share_total_sum
FROM
  test_sql
GROUP BY
  months;

-- Одним запросом
SELECT
  monthname(create_date) AS months,
  COUNT(index_lead) AS amount,
  SUM(index_sum) AS total_sum,
  CONCAT(ROUND((SUM(index_sum) / (SELECT SUM(index_sum) FROM test_sql)) * 100.0, 2), '%') AS share_total_sum
FROM
  test_sql
GROUP BY
  months;

-- Задание 2
WITH ind (
  st_ord, type_product_name, product_infosource1,
  create_date, index_lead, index_issue,
  index_sum, indicator
) AS (
  SELECT
    *,
    CASE WHEN index_sum > 2000000
    AND MONTH(create_date) = 3
    AND YEAR(create_date) = 2020 THEN 1 WHEN index_sum < 2000000
    AND index_sum > 1000000
    AND MONTH(create_date) = 3
    AND YEAR(create_date) = 2020 THEN 2 ELSE -1 END
  FROM
    test_sql
);

SELECT * FROM ind WHERE indicator <> -1;

-- Задание 3
SELECT
  t1.product_infosource1
FROM
  (
    SELECT
      product_infosource1,
      COUNT(*) AS total_amount
    FROM
      test_sql
    GROUP BY
      product_infosource1
  ) AS t1
ORDER BY
  total_amount DESC
LIMIT
  1;

-- Задание 4
-- Запрос a
SELECT
  t1.numbers
FROM
  table_num t1
  JOIN table_num t2 ON t1.numbers = t2.numbers
  AND t1.numbers > 0;

-- Запрос b*
SELECT
  numbers
FROM
  table_num
GROUP BY
  numbers
HAVING
  numbers > 0;




