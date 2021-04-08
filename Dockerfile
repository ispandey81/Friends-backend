FROM julia:1.6.0-buster

RUN apt-get update && apt-get install -y gcc
ENV JULIA_PROJECT @.
WORKDIR /home

ENV VERSION 1
ADD . /home

RUN julia deploy/packagecompile.jl

EXPOSE 8080

ENTRYPOINT ["julia", "-JFriends.so", "-e", "Friends.run(\"test/friendsdb.sqlite\")"]