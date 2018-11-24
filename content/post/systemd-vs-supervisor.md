---
title: "Systemd vs Supervisor"
date: 2017-08-25T15:49:49Z
draft: false
---

[Supervisord](http://supervisord.org/) is a well-known tool among developers
for controlling processes. It's especially useful for monitoring process status
and restarting on a crash. For a long time, I used supervisor on my personal
projects and still using it at work. But while migrating
[HastaTakip](https://github.com/egegunes/hastatakip) from Ubuntu 14.04 to
Centos 7, I made a different choice for process monitoring and
controlling:[systemd](https://www.freedesktop.org/wiki/Software/systemd/).

Well...I'm sure you heard about systemd before. It's the controversial software
that landed to Linux environment in 2010 and replaced [System
V](https://en.wikipedia.org/wiki/UNIX_System_V) init system. Its name is enough
to flame wars between Linux users. I don't like some of the features introduced
by systemd, like binary logs, network interface names etc. but let's face the
fact--systemd is here to stay. So I think we should get familiar with it and
harness it's useful features to our benefit.

### supervisord as a process supervisor

Let's say I have a Django application named `Foo`. I want to be sure `Foo` is
running all the time, even if it crashes. Also, I want a simple interface to
start, stop and restart its process. `Supervisord` is a perfect match for this
job.

```
[program:foo]
command=/home/foo/bin/start_foo
user=foo
environment=LANG=en_US.UTF-8,LC_ALL=en_US.UTF-8
```

With `supervisord.conf` above I can control process easily:

```sh
$ supervisorctl status foo
$ supervisorctl stop foo
$ supervisorctl start foo
$ supervisorctl restart foo
```

Let's say I have some background tasks to do upon request and I want to use
[Celery](http://www.celeryproject.org/) for this. Now I have two processes to
monitor and control.

```
[program:foo_django]
command=/home/foo/bin/start_foo
user=foo
environment=LANG=en_US.UTF-8,LC_ALL=en_US.UTF-8

[program:foo_celery]
command=/home/foo/bin/start_celery
user=foo
environment=LANG=en_US.UTF-8,LC_ALL=en_US.UTF-8

[group:foo]
programs=foo_django,foo_celery
```

```sh
$ supervisorctl status foo:*
$ supervisorctl stop foo:*
$ supervisorctl start foo:*
$ supervisorctl restart foo:*
```

Almost two years of using supervisor I didn't need any other command or option.
It's simple and gets the job done. So why I made the switch? Because I had a
tool as useful as `supervisord` and came pre-installed with Centos 7.

### systemd as a process supervisor

`systemd` uses configuration files named 'unit file'. Below is a unit file for
`Foo`:

```
[Unit]
Description="Foo web application"
After=network.target

[Service]
User=foo
Group=foo
Environment=LANG=en_US.UTF-8,LC_ALL=en_US.UTF-8
ExecStart=/home/foo/bin/start_foo

[Install]
WantedBy=multi-user.target
```

After copying this to `/etc/systemd/system/foo.service` I can control `Foo`
with `systemctl`:

```sh
$ systemctl status foo
$ systemctl stop foo
$ systemctl start foo
$ systemctl restart foo
```

One of the key features of `supervisord` is restarting the process on a crash.
With `systemd` I can have the same behavior by adding `Restart=always` to
`[Service]` section. `Restart` option can have settings other than `always`.
For complete list see
[systemd.service(5)](https://www.freedesktop.org/software/systemd/man/systemd.service.html).

Let's add `Celery` to the equation. I want to control my main service and
Celery both independently and together. For this, I have to create a 'target'.
Targets are unit files too but useful for grouping and ordering other services.

`/etc/systemd/system/foo.target`:

```
[Unit]
After=network.target
Wants=foo_django.service foo_celery.service

[Install]
WantedBy=multi-user.target
```

According to
[systemd.unit(5)](https://www.freedesktop.org/software/systemd/man/systemd.unit.html),
services listed in `Wants` starts when target starts, but if one of them fails
it won't affect the target. So, if `foo_celery.service` fails to start, it
will not affect `foo_django.service`.

In order to use my target, I have to change my units like this:

```
[Unit]
Description="Foo web application"
After=network.target
PartOf=foo.target

[Service]
User=foo
Group=foo
Environment=LANG=en_US.UTF-8,LC_ALL=en_US.UTF-8
ExecStart=/home/foo/bin/start_foo

[Install]
WantedBy=multi-user.target
```

According to the same manual, a dependency is established between units and
targets listed in the `PartOf` and starting or stopping the target will affect
these units. However, this dependency relation is unidirectional, starting or
stopping one of the units will not affect other units dependent on the same
target. So, when I start `foo.target`, it will start `foo.service` and
`foo_celery.service` but if I restart `foo_celery`, `foo` won't be affected.

Finally, I can check dependent services with `list-dependencies`. The dot on
the left is green or red according to the service's status.

```
$ systemctl list-dependencies foo.target
foo.target
● ├─foo_django.service
● └─foo_celery.service
```

### Conclusion

I'm not saying `supervisor` is bad or `systemd` is superior. `Supervisor` is a
reliable tool that I use day to day. Also, it has some features that `systemd`
has not, like controlling services with a web interface. Nevertheless, if your
only use case is making sure of your processes are running all the time you can
consider using `systemd` and getting rid of one dependency from your systems.
