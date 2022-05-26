-- Запрос 1
SELECT * FROM A JOIN B ON A.a = B.b;

-- Запрос 2
SELECT * FROM A LEFT JOIN B ON A.a = B.b;

-- Запрос 3
SELECT * FROM A RIGHT JOIN B ON A.a = B.b;

-- Запрос 4
SELECT * FROM A FULL JOIN B ON A.a = B.b;

-- Запрос 5
SELECT COUNT(mark),
       name
FROM TABLE
WHERE mark = 5
  AND name IN
    (SELECT name
     FROM TABLE
     WHERE mark = 2
     GROUP BY name
     HAVING COUNT(mark) > 3)
GROUP BY name;

-- Запрос 6
SELECT SUM(t.sum)
FROM transact t
JOIN drugs d ON t.id = d.id
WHERE d.name = 'Арбидол'
  AND strftime('%Y-%m', t.tr_date) = '2020-01';

-- Запрос 7
SELECT drugs.name,
       SUM(transact.sum) AS Сумма
FROM transact
JOIN drugs ON transact.id = drugs.id
JOIN availability ON transact.id = availability.id
JOIN price ON transact.id = price.id
WHERE (availability.amount > 1
       AND (strftime('%Y-%m-%d', availability.eff_date_from) >= '2020-12-31'
            AND strftime('%Y-%m-%d', availability.eff_date_to) <= '2020-12-31')
       AND (price.price > 100
            AND strftime('%Y', availability.eff_date_from) = '2020'
            AND strftime('%Y', availability.eff_date_to) = '2020'));