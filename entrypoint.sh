#!/bin/sh -l
USERNAME = $1
curl -d '{"username":"$USERNAME", "name":"Kit Plummer"}' -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
