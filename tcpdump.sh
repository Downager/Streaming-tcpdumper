#!/bin/bash
set -e

trap "{ echo 'Terminating...'; killall -INT tcpdump; wait $i; exit 0; }" TERM

gcloud auth activate-service-account "${SERVICE_ACCOUNT}" --key-file="${KEY_FILE}"

mkfifo /tmp/tcpdump
tcpdump -i any -B 262144 -nn -n -w - > /tmp/tcpdump &
gsutil cp /tmp/tcpdump "gs://${GCS_BUCKET}/$(date +%Y-%m-%d)/$(date +%H:%M:%S)_$(hostname).pcap" &
wait