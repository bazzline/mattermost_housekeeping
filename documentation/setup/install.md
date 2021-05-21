# How to install

## Grant mysql user permissions to write to disk

```
#allow mattermost user to write to the filesystem
mysql -u root
GRANT FILE ON *.* TO 'mmuser'@'localhost';
FLUSH PRIVILEGES;
```

## If you have systemd, switch of private temporary

We have to adapt the systemd service configuration to disable private temporary directory.

```
#assuming you are using mariadb
sudo systemctl edit mariadb.service

#add the following lines value to disable private temporary directory
[Service]
PrivateTmp=false
#save the file

sudo systemctl restart mariadb.service

#check if the right tmp path is used
sudo systemctl status mariadb.service
cat /proc/<process id of maria db>/mountinfo | grep -i tmp
```

## Install the software

```
sudo su
mkdir -p /opt/net.bazzline
cd /opt/net.bazzline
git clone https://github.com/bazzline/mattermost_housekeeping
cd mattermost_housekeeping
bash bin/install.sh

#adapt user name, password and days
vim data/local_config.sh

```

## If you have systemd 

The script creates a `systemd service file` and multiple [systemd timer files](source/) *if* systemd is installed.
If you want to create your own timer, please read [this](../knowledge_base/create_your_own_timer.md)

```
#enable the fitting timer on your own.
systemctl enable weekly-rsyslog-housekeeping.timer
#_or
systemctl enable daily-rsyslog-housekeeping.timer
#_or
systemctl enable hourly-rsyslog-housekeeping.timer
```

## If you want to do the housekeeping right away

```
screen
/opt/net.bazzline/mattermost_housekeeping/bin/do_the_housekeeping.sh
```
