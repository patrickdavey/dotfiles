#!/bin/sh
RUNNING=`sqlite3 ~/.timetrap.db "select count(id) from entries where end IS NULL"`

if [ "$RUNNING" -eq "0" ]; then
  echo "#[fg=colour255,bg=colour1,bold] OFF"
else
  echo "#[fg=colour255,bg=colour2,bold] ON"
fi