---
title: "Setup a Scalable Ghost With Docker and Traefik"
date: 2018-06-08T15:50:10Z
draft: false
---

I was hosting my static web site on Netlify. Then Github announced support for
HTTPS on custom domains and I migrated there. Recently I bought an iPad Pro.
Since I hold my [SSH keys on my
Yubikeys](https://gunes.io/2017/11/12/i-carry-my-ssh-and-gpg-keys-all-the-time/)
there is no easy way to write a post on my iPad and push it to Github. So I
decided give Ghost a try.

The biggest advantage of having Netlify or Github host your website, you don't
have to worry about your sites availability. It's somebody else's problem. But
I like things to be responsible of. I wanted it to be my problem. I decided to
deploy Ghost on a Centos virtual machine.

I used [docker images](https://hub.docker.com/_/ghost/) for Ghost. By default
it uses a SQLite database. It means I can't scale my blog without sharing
SQLite database between containers. I decided to go with an external MySQL
container.

Initially I have Nginx in my mind to use as reverse proxy. But while
researching about it I came across to one of the most beautiful piece of
software I've encountered: [Traefik](https://traefik.io/). It was a pure joy to
configure and run it, because I didn't configure anything. I just give docker's
socket path to Traefik and it just worked.

Traefik handles routing by container labels. For example to
`docker-compose.yml` file of Ghost I added this:

```
labels:
    - "traefik.frontend.rule=Host:gunes.io"
```

Traefik listens 80 and if `Host` header in request is "gunes.io", it routes
this request to Ghost. If I scale Ghost to 2 containers or more, it
automatically load balance between them. You don't need anything other than
default configuration for it.

But I need more of course. First I wanted to fetch metrics with Prometheus. So
I enabled the config option. Second I wanted to have SSL. So I tried to
configure Traefik automatically issue Let's Encrypt certificate by my frontend
rules. It didn't work and I hit the rate limit for my IP.

Honeymoon must end sometime.
