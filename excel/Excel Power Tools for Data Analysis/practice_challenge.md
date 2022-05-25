## Week 2

1. Создать запрос на получение данных из книги Sales Summary.
2. Удалить все ненужные строки, чтобы заголовки данных находились в верхней строке, а затем преобразовать верхнюю строку в заголовки.
3. Убедиться, что столбец Категория (ategory) заполнен.
4. Удалить столбец Monthly Average.
5. Отменить свёртывание данных и изменить имена столбцов так, чтобы они выглядели следующим образом (показаны не все строки):
<!--![Отменённые сводные данные и переименованные столбцы выглядят так]()-->
6. Добавить столбец с именем % Target Achieved, который делит Sales на Monthly Target, и изменить тип данных на Процент.
7. Закрыть и загрузить запрос на лист Sales Data.
8. Используя результаты запроса данных о продажах, создать сводную таблицу, которая возвращает среднее значение % Target Achieved по подкатегории (Subcategory).
- Какая подкатегория показала наилучшие результаты (самый высокий %)?
  - Самый высокий показатель оказался у подкатегории Socks (средний процент 123.27%).
9. Создать ещё одну сводную таблицу, чтобы показать общий объём продаж по категориям и месяцам (Total Sales by Category and Month). Отфильтровать сводную таблицу так, чтобы  отображались только аксессуары (Accessories) и одежда (Clothes).
- Каков был общий совокупный объём продаж аксессуаров и одежды за февраль?
  - Общий совокупный объём продаж за февраль составил 76645 единиц товара.
<!--![Общий совокупный объём продаж аксессуаров и одежды за февраль]()-->
10. Создать сводную диаграмму с областями и накоплением, чтобы визуализировать тенденции продаж в сводной таблице. Это должно выглядеть примерно так:
<!--![]()-->