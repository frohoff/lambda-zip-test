FROM ubuntu:16.04

WORKDIR /app

RUN apt-get update && apt-get install -y zip unzip python2.7 python-pip p7zip-full

RUN pip install awscli

ADD . /app

RUN sh build-zip.sh

CMD sh test-all.sh
