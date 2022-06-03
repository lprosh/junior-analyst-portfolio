from bs4 import BeautifulSoup
import requests
import pandas as pd
import matplotlib.pyplot as plt

url = 'https://worldtable.info/gosudarstvo/tablica-rozhdaemosti-po-godam-rossija.html'
pages = requests.get(url)
soup = BeautifulSoup(pages.text, 'lxml')
table1 = soup.find('tbody')

all_data = []
headers = []
for i in table1.find_all('tr'):
    title = i.text.replace('\n', '-').replace(' ', '').replace('-', ' ').strip()
    all_data.append(title)
tmpl = all_data.pop(0)
index_k = tmpl.find('К')
index_r = tmpl.find('р')
index_ch = tmpl.rfind('ч')
headers.append(tmpl[:index_k - 1])
headers.append(tmpl[index_k:index_r] + ' ' + tmpl[index_r:index_ch] + ' ' + tmpl[index_ch:])

mydata = pd.DataFrame(columns = headers)
for j in table1.find_all('tr')[1:]:
    row_data = j.find_all('td')
    row = [i.text for i in row_data]
    for r in range(len(row)):
        row[r] = row[r].replace(' ', '')
    length = len(mydata)
    mydata.loc[length] = row

mydata.to_csv('birth_rate_table.csv', index = False)

df = pd.read_csv('birth_rate_table.csv')

y_list = df[headers[1]].astype(int)
x_list = df[headers[0]].astype(int)

plt.title('Рождаемость в России')
plt.xlabel(headers[0])
plt.ylabel(headers[1] + ', млн.')

plt.plot(x_list, y_list, marker = '.')
plt.grid()
plt.show()