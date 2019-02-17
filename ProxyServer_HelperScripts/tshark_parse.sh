#!/bin/bash

for pcap in ~/pcaps/*.pcap; do
	tshark -r "$pcap" -Y "http" -T fields -e ip.src -e ip.dst -e http.response.code 2>/dev/null
done
