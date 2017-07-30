# httpd-docker

## Overview

This docker image contains [httpd](https://httpd.apache.org/) with [cgi](https://en.wikipedia.org/wiki/Common_Gateway_Interface), [eruby](https://en.wikipedia.org/wiki/ERuby), [php](https://php.net/), and [python](https://www.python.org/).

## Embedded Samples

This image has embedded sample scripts that can be used to test the deployment of a container, and the running configuration of httpd. This functionality is defined in `/etc/apache2/vhost.d/hello`. An autoindex listing of the scripts directory is available under `/hello`.

## Entrypoint Scripts

None.

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

