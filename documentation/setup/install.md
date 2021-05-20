# How to install

```
sudo su
mkdir -p /opt/net.bazzline
cd /opt/net.bazzline
git clone https://github.com/bazzline/mattermost_housekeeping
cd mattermost_housekeeping
bash bin/install.sh

#add user name, password and days
vim data/local_config.sh

#you can to choose between on of the three shipped timers
systemctl enable weekly-mattermost-housekeeping.timer
#_or
systemctl enable daily-mattermost-housekeeping.timer
#_or
systemctl enable hourly-mattermost-housekeeping.timer

#if you want to do housekeeping right away
screen
/opt/net.bazzline/mattermost_housekeeping/bin/do_the_housekeeping.sh
```

The script creates a `systemd service file` and multiple [systemd timer files](source/) *if* systemd is installed.
If you want to create your own timer, please read [this](../knowledge_base/create_your_own_timer.md)
