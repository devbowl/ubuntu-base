# Devbowl Ubuntu Base

An ubuntu base image for devbowl that sets up the IDE server.

# Usage

Use this image in for your container with this line in your Dockerfile:

```Dockerfile
FROM neprune/ubuntu-base:latest
```

To add a project to the code editor, place it's directory at `/home/user/projects`.
Multiple projects are supported.
