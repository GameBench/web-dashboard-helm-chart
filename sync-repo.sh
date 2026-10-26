#!/bin/bash
set -ex

helm package .
mv gamebench-*.tgz gb-helm-charts/
helm repo index gb-helm-charts --url https://gb-helm-charts.storage.googleapis.com/
gcloud storage rsync gb-helm-charts/ gs://gb-helm-charts --checksums-only
