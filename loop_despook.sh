#!/bin/sh -e

while ps aux | grep -i "[M]icrosoftEdgeUpdate" > /dev/null 2>&1; do
  kill `ps aux | grep -i "[M]icrosoftEdgeUpdate" | awk '{print $2}'`
  echo "found and killed."
done

