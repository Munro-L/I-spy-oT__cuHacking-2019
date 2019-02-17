#!/bin/bash

for pcap in ~/pcaps/*.pcap; do
	tshark -r "$pcap" -Y "http" -T fields -e text -e ip.src -e ip.dst -e http.response.code | tee -a  traffic.log
done
