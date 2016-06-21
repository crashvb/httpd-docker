# httpd-docker

## Overview

This docker image contains [httpd](https://httpd.apache.org/) with [cgi](https://en.wikipedia.org/wiki/Common_Gateway_Interface) and [php](https://php.net/).

## Entrypoint Scripts

None.

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ apache2/
│  │  ├─ conf-available/
│  │  │  └─ php5-fpm.conf
│  │  └─ sites-available/
│  │     └─ 000-default.conf
│  ├─ php5/
│  │  └─ fpm/
│  │     └─ php.ini
│  └─ supervisor/
│     └─ config.d/
│        ├─ apache2.conf
│        ├─ fcgi.conf
│        └─ php.conf
└─ var/
   └─ hello/
      ├─ hello.cgi
      ├─ hello.html
      └─ hello.php
```

### Exposed Ports

* `80/tcp` - httpd listening port.

### Volumes

None.

## Development

[Source Control](https://github.com/crashvb/httpd-docker)

