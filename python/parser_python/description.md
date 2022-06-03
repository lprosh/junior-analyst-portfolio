### Задание
Написать скрипт на Python, получающий данные из [HTML таблицы с данными по рождаемости 
в России](https://worldtable.info/gosudarstvo/tablica-rozhdaemosti-po-godam-rossija.html) 
и визуализирующий их на графике.

Обязательные к установке пакеты и библиотеки:

```
pip install beautifulsoup4
pip install lxml
pip install requests
pip install pandas
pip install matplotlib
```

Весь код находится в файле [main.py](https://github.com/lprosh/junior-analyst-portfolio/blob/main/python/parser_python/main.py).
Результаты парсинга записываются в [birth_rate_table](https://github.com/lprosh/junior-analyst-portfolio/blob/main/python/parser_python/birth_rate_table.csv).
