#!/bin/bash
set -e

echo "Starting mongod..."
exec $(which mongod) --fork --logpath /var/log/mongodb.log
exec "$@"
