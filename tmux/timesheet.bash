#!/bin/bash
not_running="$(t n 2>&1 > /dev/null)"
if [[ "$not_running" =~ .*not\ running ]]
then
  rm ~/.timesheet_running
else
  touch ~/.timesheet_running
fi

