FROM python:3.6-alpine
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

RUN apk update && apk upgrade && pip install -U pip
RUN apk add --update alpine-sdk make gcc python3-dev python-dev libxslt-dev libxml2-dev \
    libc-dev openssl-dev libffi-dev zlib-dev py-pip openssh dcron wget rsync ca-certificates \
    && rm -rf /var/cache/apk/*

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY . /code
RUN crontab /code/crontabfile && touch /crontab.log

WORKDIR /code
CMD crond && tail -f /crontab.log
