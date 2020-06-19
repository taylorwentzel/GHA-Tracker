# How It Works

## Basics of Github and Git


## Intro to Github Actions

## User Defined Work Flows

When used in a workflow, this action will keep track of how and where it's being used along with who is using it without its user's knowledge.  Currently, all this action does is track its user.  However, it can be modified to also provide some legitimate functionality.  In this sense, users can use it for a legitimate task without realizing they are being tracked.

## Environment Variables

GitHub sets default environment variables for each GitHub Actions workflow run. This allows an action to access several environment variables such as the user who triggered that workflow, where the workflow exists, what set off the workflow, and many others.  As such, my action works by simply accessing those environment variables and sending them via an HTTP POST request to a web app that I have created.  This entire process exists in just a few lines of code within my bash script.  As a result, a user would only know the true nature of my action by sifting through my source code. In a much larger repository, this code could go easily unnoticed.

## Security Risk