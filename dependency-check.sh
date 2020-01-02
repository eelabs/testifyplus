#!/usr/bin/env bash

if [ ! -d "$OWASPDC_DIRECTORY" ]; then
  ###OWASPDC_DIRECTORY=$PWD/owasp-dependency-check
  OWASPDC_DIRECTORY=~/go/owasp-dependency-check
  echo "Initially creating owasp root directory: $OWASPDC_DIRECTORY"
  mkdir -p "$OWASPDC_DIRECTORY"
fi

DATA_DIRECTORY="$OWASPDC_DIRECTORY/data"
REPORT_DIRECTORY="$OWASPDC_DIRECTORY/reports"
CACHE_DIRECTORY="$OWASPDC_DIRECTORY/data/cache"

if [ ! -d "$DATA_DIRECTORY" ]; then
  echo "Initially creating persistent directory: $DATA_DIRECTORY"
  mkdir -p "$DATA_DIRECTORY"
fi
if [ ! -d "$REPORT_DIRECTORY" ]; then
  echo "Initially creating persistent directory: $REPORT_DIRECTORY"
  mkdir -p "$REPORT_DIRECTORY"
fi
if [ ! -d "$CACHE_DIRECTORY" ]; then
  echo "Initially creating persistent directory: $CACHE_DIRECTORY"
  mkdir -p "$CACHE_DIRECTORY"
fi

docker pull owasp/dependency-check

docker run --rm \
  --volume $(PWD):/src \
  --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data \
  --volume "$REPORT_DIRECTORY":/report \
  owasp/dependency-check \
  --scan /src \
  --format "ALL" \
  --project "OWASP Dependency Check" \
  --out /report
  # Use suppression like this: (/src == $pwd)
  # --suppression "/src/security/dependency-check-suppression.xml"