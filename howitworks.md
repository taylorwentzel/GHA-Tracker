# How It Works

## Basics of GitHub and Git

To understand GitHub, you need to first understand Git.  Git is a version control software used to track changes in software source code.  In essence, Git keeps a log of the changes you have made to your code, allowing you to go back and look at previous edits, versions, etc.  Git does this by storing a collection of files from various different versions of your software in something called a repository.  You can think of a repository as large file cabinet that holds the current files of your project as well as previous versions of those files. Git allows you to interact with and access this file cabinet. GitHub then comes into play as a repository hosting service.  Users can "push" their repositories to GitHub, allowing other users to download copies of their repositories and even suggest edits. GitHub also allows you to browse for other user's projects, promoting collaboration between users and open source software.

## Intro to Github Actions

In 2019, GitHub released a feature known as GitHub Actions.  At the most basic level, actions allow a user to set up a workflow that will automatically run after being triggered by some event.  As an example, with Git, developers can "push" changes in their code to a remote repository service like GitHub.  A "push" in GitHub simply means that a user is updating their remote repository to match the changes they've made in their local copy of that same repository (editing code, adding/deleting files etc.).  With GitHub actions, a user could create a workflow that uses an action to automatically test the changes that they push to their GitHub repository. A workflow like this would allow a user to automatically generate testing results for their code. This is just one example of the many things that actions can do.

## Distinction Between Workflows and Actions

In understanding GitHub Actions, it is important to understand the distinction between workflows and actions. A workflow is simply a series of commands that the user can define that will automatically run on a repository event such as a push.  An action is contained within its own repository and can be called from a workflow to perform some task for the user.  In the earlier example, an action could be created that sets up a python shell that can then run a python file the user wants to test. The distinction here is that the workflow is what is triggered to run.  An action it was is used to actually carry out different subtasks (known as jobs) within that workflow.

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

With a basic understanding of GitHub Actions, it is easier to then understand the idea behind GHA-Tracker.  As seen in the workflow above, using an action is as simple as finding it on GitHub and calling it from a workflow.  This can be done without ever looking at the repository containing the action's source code.  That right there is what allows this vulnerability.  A user could create a GitHub action and market it as performing some useful task within a workflow. A second party could use this action for a legitimate purpose in a workflow, but unbeknownst to them, it could potentially be performing malicious tasks on the side.  A user would never know this unless they took the time to look through the action's source code, an endeavor that could potentially mean sorting though thousands of lines of code.

## What GHA-Tracker Does

In GHA-Tracker, user data such as a user's email, real name, username, and the location of the repository using the action are sent to a web app that logs that data.  Even more, this action works on private repositories. Repositories that other GitHub users shouldn't even know exist are at risk of potentially being exposed.  GHA-Tracker is currently in development, and the true risk that repositories face has yet to be fully explored.

## Why GHA-Tracker Works: Environment Variables and git log

When a workflow runs, GitHub sets default environment variables for that workflow. This allows an action to access several environment variables such as the user who triggered that workflow, where the workflow exists, what set off the workflow, and many others.  As such, GHA-Tracker can simply access those environment variables and send them via a HTTP POST request to a web app that I have created.  This entire process exists in just a few lines of code within the GHA-Tracker repository, allowing for it to potentially be hidden amongst thousands of lines of code.

Potentially more agregious then the data that can be scraped from environment variables is what can be found through git log.  For some background, "git log" is a command that can be run in git that will return a log of the entire commit history for a repository. A "commit" is simply an individual change to a file or set of files within a repository.  It can be better thought of as a set of revisions for a repository.  With this in mind, the log returned by git log will show instances where revisions have been made to a repository, as well as who made them and when.  When a user makes a commit on their local machine and then pushes that commit to GitHub, the git log will label this commit with the real name and email that the user used to sign up for GitHub. Bringing things back to GHA-Tracker, this action runs "git log" from within the repository that it is being called and simply parses the log for user's names and emails. This works on both public and private repositories.

## Significance

The fact that GitHub actions can collect sensitive user data without their knowledge is more than concerning.  This poses a huge security risk, and as stated before, the true extent of what an action like GHA-Tracker can find has yet to be fully explored.  Repositories hosted on GitHub might face an even larger risk than described here.  In terms of preventing this security risk, GitHub user's should do their due diligence and make sure they understand what exactly an action is doing before implementing it in a workflow.  In terms of the site, GitHub needs to do something to limit the access actions have to environment variables and git log.  If doing so is impossible, at the very least GitHub can warn their users of the potential security risk with GitHub Actions as well as implement a thorough review process for users who wish to list their actions on the GitHub Marketplace.