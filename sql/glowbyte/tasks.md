### 1. Реализовать работу джоинов (INNER, LEFT, RIGHT, FULL) для таблиц A и B и вывести полученные результаты.


|  A   |  B   | 
|:----:|:----:|  
|  a   |  b   |  
|  7   |  1   |
|  1   |  3   |
|  2   |  5   |
|  3   |  7   |
|  4   |  7   |
|  1   | NULL |
| NULL | NULL |

+ **INNER JOIN**:

|  a  |  b  | 
|:---:|:---:|
|  7  |  7  |
|  7  |  7  |
|  1  |  1  |
|  3  |  3  |
|  1  |  1  |


<p>SQL-запрос к этой задаче:</p>
<pre><code>SELECT * FROM A JOIN B ON A.a = B.b;
</code></pre>

+ **LEFT JOIN**:

|  a   |  b   | 
|:----:|:----:|
|  7   |  7   |
|  7   |  7   |
|  1   |  1   |
|  2   | NULL |
|  3   |  3   |
|  4   | NULL |
|  1   |  1   |
| NULL | NULL |

<p>SQL-запрос к этой задаче:</p>
<pre><code>SELECT * FROM A LEFT JOIN B ON A.a = B.b;
</code></pre>

+ **RIGHT JOIN**:

|  a   |  b   | 
|:----:|:----:|
|  1   |  1   |
|  1   |  1   |
|  3   |  3   |
| NULL |  5   |
|  7   |  7   |
|  7   |  7   |
| NULL | NULL |
| NULL | NULL |


<p>SQL-запрос к этой задаче:</p>
<pre><code>SELECT * FROM A RIGHT JOIN B ON A.a = B.b;
</code></pre>

+ **FULL JOIN**:

|  a   |  b   | 
|:----:|:----:|
|  7   |  7   |
|  7   |  7   |
|  1   |  1   |
|  2   | NULL |
|  3   |  3   |
|  4   | NULL |
| NULL |  5   |
| NULL | NULL |
| NULL | NULL |

<p>SQL-запрос к этой задаче:</p>
<pre><code>SELECT * FROM A FULL JOIN B ON A.a = B.b;
</code></pre>

### 2. Написать запрос, который выводит количество пятёрок и фамилии тех учеников, которые имеют более трёх двоек.

Входящие данные:

| name    | mark | subj         |
|---------|------|--------------|
| Иванов  | 5    | Математика   |
| Иванов  | 4    | Физика       |
| Петров  | 5    | Математика   |
| Смирнов | 5    | Математика   |
| Петров  | 2    | Физика       |
| Иванов  | 2    | Математика   |
| Смирнов | 5    | Математика   |

<p>SQL-запрос к этой задаче:</p>
<pre><code>SELECT COUNT(mark),
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
</code></pre>

### 3. Создать простую базу данных аптеки (см. [medicines_erd](https://github.com/lprosh/junior-analyst-portfolio/blob/main/sql/glowbyte/medicines_erd.png)).


- **drugs** 
  - id — код лекарства
  - name — название
  - producer — производитель
<!---->
- **availability**
  - eff_date_from — день изменения количества лекарства на складе
  - eff_date_to — день, когда количество лекарства на складе не менялось в последний раз
  - id — код лекарства
  - amount — количество
<!---->
- **price** 
  - id — код лекарства
  - eff_date_from — день изменения количества лекарства
  - eff_date_to — день, когда количество лекарства не менялось в последний раз
  - price — цена лекарства
<!---->
- **transact**
  - tr_date — дата покупки лекарства
  - id — код лекарства
  - sum — сумма покупки
  - amount — количество купленного лекарства
  - client — имя покупателя

<p>На какую сумму было продано арбидола за январь 2020?</p>
<pre><code>SELECT SUM(t.sum)
FROM transact t
JOIN drugs d ON t.id = d.id
WHERE d.name = 'Арбидол'
  AND strftime('%Y-%m', t.tr_date) = '2020-01';
</code></pre>

<p>Вывести названия товаров, сумму продаж по этим товарам из TRANSACT, 
  у которых количествово товаров из таблицы AVAILABILITY на 31.01.2020 было больше десяти, 
  а цена по этим товарам в таблице PRICE в течение 2020 года была не менее 100 рублей.</p>
<pre><code>SELECT drugs.name,
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
</code></pre>

Все запросы можно найти в файле [queries](https://github.com/lprosh/junior-analyst-portfolio/blob/main/sql/glowbyte/queries.sql).