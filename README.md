# Devbowl Ubuntu Base

An ubuntu base image for devbowl that sets up the IDE server.

# Usage

Add this line in your Dockerfile to use it.

```Dockerfile
FROM devbowl/ubuntu-base:latest
```

To add a project to the code editor, place it's directory at `/home/user/projects`.
Multiple projects are supported.

To add docs, place your markdown at `/home/user/docs`.
Make sure to include an `index.md`, which is the first page displayed.
Markdown is served via [markserv](https://www.npmjs.com/package/markserv).
