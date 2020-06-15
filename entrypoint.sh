#!/bin/sh -l

curl -d '{"username":"kitplummer", "name":"Kit Plummer"}' -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/