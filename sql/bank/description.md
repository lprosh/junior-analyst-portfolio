Источником данных является таблица TEST_SQL. 
Тестовый вариант можно найти в файле 
[make_database]('make_database.sql').

Поля таблицы:
- **ST_ORD (Varchar)** - сnатус заявки
- **TYPE_PRODUCT_NAME (Varchar)** - тип заявки
- **PRODUCT_INFOSOURCE1 (Varchar)** - источник
- **CREATE_DATE (Date)** - дата создания заявки
- **INDEX_LEAD (Number)** - индикатор заявки. Флаг 0/1 определяет регистрацию лида в системе
(все тестовые данные содержали 1, поэтому 1 установлена по дефолту)
- **INDEX_ISSUE (Number)** - индикатор выдачи. Флаг 0/1 определяет наличие выдачи по заявке
(все тестовые данные содержали 1, поэтому 1 установлена по дефолту)
- **INDEX_SUM (Number)** - сумма по продукту

### Задание 1

<p>Сгруппировать по месяцам количество заявок, 
сумму выдач, вычислить долю выдач.</p>
<pre><code>SELECT
  monthname(create_date) AS months,
  COUNT(index_lead) AS amount,
  SUM(index_sum) AS total_sum,
  CONCAT(ROUND((SUM(index_sum) / (SELECT SUM(index_sum) FROM test_sql)) * 100.0, 2), '%') AS share_total_sum
FROM
  test_sql
GROUP BY
  months;
</code></pre>

### Задание 2

<p>Добавить индикатор, который будет выделять следующие значения:
<ul>
<li>Если сумма по заявке больше 2.000.000 и 
дата создания заявки «март 2020» - 1</li>
<li>Если сумма по заявке больше 1.000.000, 
но меньше 2.000.000 и дата создания заявки «март 2020» - 2 </li>
<li>Все остальные заявки не должны попасть в результат 
выполнения запроса.</li>
</ul>
</p>
<pre><code>WITH ind (
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
</code></pre>


### Задание 3

<p>Показать источник, через который пришло наибольшее число заявок.</p>
<pre><code>SELECT
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
</code></pre>


### Задание 4

<table style="text-align:right">
<caption>tab_nums</caption>
    <tr><th>numbers</th></tr>
    <tr><td>1</td></tr>
    <tr><td>-21</td></tr>
    <tr><td>0</td></tr>
    <tr><td>-100</td></tr>
    <tr><td>7</td></tr>
    <tr><td>5</td></tr>
    <tr><td>0</td></tr>
    <tr><td>10</td></tr>
    <tr><td>-2</td></tr>
    <tr><td>5</td></tr>
    <tr><td>-2</td></tr>
</table>

<p>Напишите запрос, не используя предложение WHERE, 
который выводит только положительные числа.</p>
<pre><code>SELECT
  t1.numbers
FROM
  table_num t1
  JOIN table_num t2 ON t1.numbers = t2.numbers
  AND t1.numbers > 0;
</code></pre>

<p>Напишите запрос, не используя предложение WHERE 
и явные операторы соединения JOIN, который выводит
только положительные числа.</p>
<pre><code>SELECT
  numbers
FROM
  table_num
GROUP BY
  numbers
HAVING
  numbers > 0;
</code></pre>

Все запросы можно найти в файле [queries]('queries.sql').
