#!/bin/bash

aws s3 cp ${CONFIG_BUCKET_PATH}/$CONFIG_FILE /app/config.json
exec node server.js -c config.json

