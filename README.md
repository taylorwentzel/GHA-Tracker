# GHA Tracker

This action sends an http post request with json data to [this web app](https://ghatracker.herokuapp.com/). This action is written in bash and the second iteration of my previous python http request action.

## Significance

Using only a few dozen lines of code, I can track who is using my action, what repository it is being used in, and the time and date it was used.  A user would never know they were being tracked unless they looked through my source code.  This is a potential security risk becasue it allows me to keep tabs on other github users without their knowledge.

## Example Usage

```yaml
uses: taylorwentzel/GHA-Tracker@master
```
