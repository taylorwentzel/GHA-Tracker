#!/bin/sh -l

curl -d '{"username":"$1", "name":"Kit Plummer"}' -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
