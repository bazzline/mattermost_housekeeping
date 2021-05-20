# Lost connection, lock wait timeout

## Issue

This is a list of different errors.

* `ERROR 2013 (HY000) at line 1: Lost connection to MySQL server during query`
* `ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (111)`
* `ERROR 1205 (HY000) at line 1: Lock wait timeout exceeded; try restarting transaction`

There is a chance that your server either ran into an overload or that you find something in the log like `could not increase number of max_open_files`.

For the open files limit, you can see the current maximum nummer via.

```
SHOW VARIABLES LIKE 'open_files_limit';
```

## Solution

You can fix this by adding your own `systemd` local configuration on top of the distribution one.

```
#create local systemd service configuration file
systemctl edit mariadb.service

#add following two lines
#   My values are just a rough number.
[Service]
LimitNOFILE=100000

#restart service
systemctl restart mariadb.service
```
