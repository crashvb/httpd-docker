# httpd-docker

[![version)](https://img.shields.io/docker/v/crashvb/httpd/latest)](https://hub.docker.com/repository/docker/crashvb/httpd)
[![image size](https://img.shields.io/docker/image-size/crashvb/httpd/latest)](https://hub.docker.com/repository/docker/crashvb/httpd)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/httpd-docker.svg)](https://github.com/crashvb/httpd-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [httpd](https://httpd.apache.org/) with [cgi](https://en.wikipedia.org/wiki/Common_Gateway_Interface), [eruby](https://en.wikipedia.org/wiki/ERuby), [php](https://php.net/), and [python](https://www.python.org/).

## Embedded Samples

This image has embedded sample scripts that can be used to test the deployment of a container, and the running configuration of httpd. This functionality is defined in `/etc/apache2/vhost.d/hello`. An autoindex listing of the scripts directory is available under `/hello`.

## Entrypoint Scripts

### httpd-cleanup

The embedded entrypoint script is located at `/etc/entrypoint.d/httpd-cleanup` and performs the following actions:

1. The contents under `/run/apache2/` are purged.

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ apache2/
│  │  └─ vhosts.d/
│  │     └─ hello
│  └─ supervisor/
│     └─ config.d/
│        ├─ apache2.conf
│        ├─ fcgi.conf
│        └─ php.conf
├─ usr/
│  └─ lib/
│     └─ cgi-bin/
└─ var/
   └─ www/
      ├─ hello/
      │  ├─ hello.cgi
      │  ├─ hello.erb
      │  ├─ hello.html
      │  ├─ hello.php
      │  ├─ hello.pl
      │  ├─ hello.py
      │  └─ hello.rb
      └─ html/
```

### Exposed Ports

* `80/tcp` - insecure httpd listening port.
* `443/tcp` - secure httpd listening port.

### Volumes

None.

## Development

[Source Control](https://github.com/crashvb/httpd-docker)

