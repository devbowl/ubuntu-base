  FROM ubuntu:16.04

# Install general dependencies.
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    build-essential \
    sudo \
    software-properties-common \
    acl

# Install IDE server dependenices.
# Set the DEBIAN_FRONTEND environment variable so tzdata doesn't prompt about location.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nginx \
    php \
    php-zip \
    php-mbstring \
    git

# Install ttyd. 
RUN add-apt-repository ppa:tsl0922/ttyd-dev
RUN apt-get update && apt-get install -y \
    ttyd

# Install setup scripts.
RUN apt-get update && apt-get install -y \
    python3
ADD https://bootstrap.pypa.io/get-pip.py .
RUN python3 get-pip.py
RUN pip install virtualenv
COPY setup /setup
RUN virtualenv setup/venv
RUN /bin/bash -c "source /setup/venv/bin/activate && pip install -r /setup/requirements.txt"

# Install mkdocs and theme.
# NOTE: these envvars allow mkdocs to run on Python 3.
# See http://click.pocoo.org/5/python3/ .
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN pip install mkdocs
RUN pip install mkdocs-bootstrap

# Install nginx configuration.
COPY nginx/site /etc/nginx/sites-available/site
RUN ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site 
RUN unlink /etc/nginx/sites-enabled/default 

# Download codiad.
RUN rm -rf /var/www/html
RUN git clone -b 'v.2.8.4' --single-branch --depth 1 https://github.com/Codiad/Codiad /var/www/html

# Set-up codiad with a dummy user and set the project directory.
COPY codiad/auth.php /var/www/html/auth.php
COPY codiad/config.php /var/www/html/config.php
COPY codiad/users.php /var/www/html/data/users.php
COPY codiad/projects.php /var/www/html/data/projects.php

# NOTE: We want files created by the editor to be writable to the terminal and vice versa.
# We place both users in a group and give the group access to all files in the project repo.
# We also set the gid so all new files created in the directory will belong do the group.

# Create the group with project access.
RUN groupadd project

# Create user for the terminal with a dummy password.
RUN useradd -m -d /home/user -G sudo,project user
RUN echo 'user:password' | chpasswd

# Add editor server to project group.
RUN usermod -aG project www-data

# Create the project directory.
RUN mkdir /home/user/projects

# Download the IDE static content.
RUN mkdir /var/www/devbowl
COPY site /var/www/devbowl

# Grant nginx permission to code.
RUN chown www-data:www-data -R /var/www

# Add placeholder docs.
COPY docs /home/user/docs

# Add placeholder project.
COPY project /home/user/projects/project

# Remove placeholders when used as base.
ONBUILD RUN rm -rf /home/user/docs /home/user/projects/project

# Script for starting services.
COPY entrypoint entrypoint
ENTRYPOINT ["/entrypoint"]
CMD ["--ip", "0.0.0.0", "--port" , "80", "--base_url", "", "--token", "", "--project_name", "project", "--username", "user", "--return_url", "http://devbowl.io"]
