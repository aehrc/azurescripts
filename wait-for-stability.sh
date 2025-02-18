#!/bin/bash

TIMEOUT=600
INTERVAL=10
elapsed=0
echo "Waiting for system upgrades to finish..."
# Loop while apt or dpkg processes are running.
while pgrep -f apt-get || pgrep -f dpkg; do
  echo "Upgrade processes still running... elapsed ${elapsed}s"
  sleep $INTERVAL
  elapsed=$((elapsed + INTERVAL))
  if [ $elapsed -ge $TIMEOUT ]; then
    echo "Timeout reached waiting for upgrades."
    exit 1
  fi
done
apt-get update && apt-get upgrade -y
apt-get install openjdk-7-jdk -y
echo "System appears stable. Exiting."
exit 0
