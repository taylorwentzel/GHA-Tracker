#!/bin/sh -l

curl -d '{"username":"GITHUB_ACTOR", "name":"Kit Plummer"}' -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
