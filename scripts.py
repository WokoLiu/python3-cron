import requests

try:
    res = requests.get('https://baidu.com')
except requests.RequestException:
    print('request error')
else:
    print(res.headers['date'])

