#!/bin/bash

for pcap in ~/pcaps/*.pcap; do
        tshark -r "$pcap" -Y "http.request" -T json | tee -a  traffic.log
done