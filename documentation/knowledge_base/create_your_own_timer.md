# Create your own timer

## Issue

The offered systemd timers with "weekly", "daily" and "hourly" are not fitting to your environemnt so you want create your own one.

## Solution

Use the existing [timers](../../source) as template.
If you want to run it every five minutes, `OnCalendar=*:0/5` will do the trick.

You don't have to fear process locking. This is something systemd is doing for you.
If a timer triggers a service file, the service fill becomes the state "active". As long as a service file is "active", systemd won't start another service, even if a timer tries to trigger another run. See [official documentation](www.freedesktop.org/software/systemd/man/systemd.html#Concepts).

If you want to execute the service file more often, it is recommended to disable `EXECUTE_DATABASE_OPTIMIZE` and to keep the `NUMBER_OF_ENTRIES_TO_DELETE_PER_RUN` as well as `NUMBER_OF_RUNS` small.
