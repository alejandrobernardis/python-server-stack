python-server-stack
===================

Environment build with CentOS, Memcached, MongoDB, RabbitMQ, Nginx and Python.

### First Steps:

1. Set your own configuration and then copy the `installer` folder into your server.
2. Modify file privileges: `$: chmod +x install.sh`
3. Run: `$: ./install.sh`

### Structure:

    installer/
    ├── application.sh
    ├── common.sh
    ├── config
    │   ├── celery
    │   │   └── installer.sh
    │   ├── erlang
    │   │   └── installer.sh
    │   ├── linux
    │   │   ├── etc
    │   │   │   ├── security
    │   │   │   │   └── limits.conf
    │   │   │   ├── sudoers
    │   │   │   └── sysctl.conf
    │   │   ├── installer.sh
    │   │   └── root
    │   │       └── dot_bash_profile
    │   ├── memcached
    │   │   ├── etc
    │   │   │   └── sysconfig
    │   │   │       └── memcached
    │   │   └── installer.sh
    │   ├── mongodb
    │   │   ├── data
    │   │   │   └── etc
    │   │   │       └── mongod
    │   │   │           ├── keys
    │   │   │           │   ├── r_main_s_all
    │   │   │           │   └── r_track_s_all
    │   │   │           ├── r_main_s_0_27000.yaml
    │   │   │           ├── r_main_s_1_27001.yaml
    │   │   │           ├── r_main_s_2_27002.yaml
    │   │   │           ├── r_main_s_3_27003.yaml
    │   │   │           └── r_track_s_0_27100.yaml
    │   │   ├── etc
    │   │   │   ├── rc.d
    │   │   │   │   └── init.d
    │   │   │   │       ├── r-main-s-0
    │   │   │   │       ├── r-main-s-1
    │   │   │   │       ├── r-main-s-2
    │   │   │   │       ├── r-main-s-3
    │   │   │   │       └── r-track-s-0
    │   │   │   └── yum.repos.d
    │   │   │       └── 10gen.repo
    │   │   ├── installer.sh
    │   │   └── tmp
    │   │       ├── r_main_s_all.mjs
    │   │       └── r_track_s_all.mjs 
    │   ├── nginx
    │   │   ├── data
    │   │   │   ├── etc
    │   │   │   │   └── nginx
    │   │   │   │       ├── common.conf
    │   │   │   │       ├── errors.conf
    │   │   │   │       └── sites-available
    │   │   │   │           ├── backend.vhost
    │   │   │   │           ├── backoffice.vhost
    │   │   │   │           └── public.vhost
    │   │   │   └── ssl
    │   │   │       ├── server.crt
    │   │   │       ├── server.csr
    │   │   │       ├── server.key
    │   │   │       └── server.key.org
    │   │   ├── etc
    │   │   │   ├── nginx
    │   │   │   │   └── nginx.conf 
    │   │   │   └── yum.repos.d
    │   │   │       └── nginx.repo
    │   │   └── installer.sh
    │   ├── python
    │   │   ├── installer.sh
    │   │   └── tmp
    │   │       └── requirements.txt 
    │   ├── rabbitmq
    │   │   └── installer.sh
    │   └── supervisor
    │       ├── data
    │       │   └── etc
    │       │       └── supervisord
    │       │           ├── backend.conf
    │       │           ├── backoffice.conf
    │       │           └── tasks.conf
    │       ├── etc
    │       │   ├── rc.d
    │       │   │   └── init.d
    │       │   │       └── supervisord
    │       │   └── supervisord.conf
    │       └── installer.sh
    └── install.sh

#### Project Path

    ─── /data
        ├── /bin
        ├── /ect
        ├── /lib
        ├── /src
        └── /var

---

### Disclaimer: 

* Please, be careful if you implement this solution for your production server. We recommend using other solutions like Puppet or Chef.

* This software was created for build a development and testing environment.

---