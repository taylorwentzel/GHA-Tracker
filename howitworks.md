# How It Works

## Basics of GitHub and Git

To understand GitHub, you need to first understand Git.  Git is a version control software used to track changes in software source code.  In essence, Git keeps a log of the changes you have made to your code, allowing you to go back and look at previous edits, versions, etc.  Git does this by storing a collection of files from various different versions of your software in something called a repository.  You can think of a repository as large file cabinet that holds the current files of your project as well as previous versions of those files. Git would you to interact with and access this file cabinet. GitHub comes into play as a repository hosting service.  Users can push their repositories to GitHub, allowing other users to download copies of their repositories and even suggest edits. GitHub also allows you to browse for other user's projects, promoting collaboration between users and open source software.

## Intro to Github Actions

In 2019, GitHub realeased a feature known as GitHub Actions.  At the most basice level, actions allow a user to set up a workflow that will automatically run after being triggered by some event.  As an example, with Git, developers can "push" changes in their code to a remote repository like GitHub.  A "push" in GitHub simply means that a user is updating their remote repository to match the changes they've made in their local copy of that same repository (editing code, adding/deleting files etc.).  With GitHub actions, a user could create a workflow that uses an action to automatically tests the changes that they push to their GitHub repository. This is just one example of the many things that actions can do.

## Distinction Between Workflows and Actions

In understanding GitHub Actions, it is important to understand the distinction between workflows and actions. A workflow is simply a series of commands that the user can define that will automatically run on a repository event such as a push.  An action is contained within its own repository and can be called in a workflow to perform some task for the user.  In the earlier example, an action could be created that sets up a python shell that can then run a python file the user wants to test. The distinction here is that the workflow is what is triggered to run.  An action it was is used to actually carry out different subtasks (known as jobs) within that workflow.

```yaml
name: GHA-Tracker Test

on: [push, pull_request]

jobs:
  request:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: taylorwentzel/GHA-Tracker@master
```

In this above example, the workflow is the entire block of code.  It triggers on both "push" and "pull_request" events and calls two actions, checkout and GHA-Tracker.

## The Concept behind GHA-Tracker

Now that you have a basic understanding of how GitHub actions are used, you can begin to understand the idea behind GHA-Tracker.  As seen in the workflow above, using an action is as simple as finding it on GitHub and calling it from a workflow.  This can be done without ever looking at the repository that contains the source code for the action.  That right there is the vulnerability.  A user could create a GitHub action and market it as performing some useful task within a workflow. A second party could use this action for a legitimate purpose in a workflow, but unbeknownst to them, it could potentially be performing malicious tasks on the side.  A user would never know this unless they took the time to look through the actions source code, an endeavor that could potentially mean sorting though thousands of lines of code.

## What GHA-Tracker Does

In GHA-Tracker, user data such as username, repository location, and several other variables are sent to a web app that logs the data.  The owner of GHA-Tracker is then able to see who is using their action as well as when and where.  Even more, this action works on private repositories. Repositories that other GitHub users shouldn't even know exist are at rick of potentially being exposed.  GHA-Tracker is currently in development, and the true risk that repositories face has yet to be fully explored.

## Why GHA-Tracker Works: Environment Variables and git log

When a workflow runs, GitHub sets default environment variables for that workflow. This allows an action to access several environment variables such as the user who triggered that workflow, where the workflow exists, what set off the workflow, and many others.  As such, GHA-Tracker works by simply accessing those environment variables and sending them via an HTTP POST request to a web app that I have created.  This entire process exists in just a few lines of code within my repository, allowing for it to potentially be hidden amongst thousands of lines of code.

To Add: git log usage