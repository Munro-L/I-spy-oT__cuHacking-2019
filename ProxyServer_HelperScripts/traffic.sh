#!/bin/bash

while :
do
        sudo timeout 60 tcpdump -w ~/pcaps/capture.pcap
        ./tshark_parser.sh
        sudo rm ~/pcaps/capture.pcap
done