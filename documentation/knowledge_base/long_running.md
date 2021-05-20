# Long runtime

## Issue

It can be that the amount of deleted items is to high.

This results into long running queries.

## Solution

Execute following statement in your mysql shell.

```
SHOW ENGINE INNODB STATUS \G
```

The last few lines are containing the important messages with `25.21 inserts/s, 0.00 updates/s, 1137.62 deletes/s, 1139.97 reads/s` (as example).
Based on that number, you can do some calculation how long it will take.

Adapt the `NUMBER_OF_ENTRIES_TO_DELETE_PER_RUN` in the file `local_configuration.sh` to a suiteable number for your system.
