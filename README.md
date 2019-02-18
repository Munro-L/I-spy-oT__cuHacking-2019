# cuHacking-2019

![alt text](https://raw.githubusercontent.com/Munro-L/I-spy-oT__cuHacking-2019/master/presentations/banner.JPG)

Ever wonder how much of your data IoT devices might be sending back to their servers?

Our project provides a method for us to keep track of how much of our data is being sent out. Obviously, blocking the sending of our data may prevent devices from working, but we would at least like a clean way to catalog what data is going where.

The goal of our project is to make use of a Qualcomm Dragonboard 410c as a stand-in for a hypothetical chatty IoT device. We configured the device to make use of a proxy server that we control (thanks for the Google Cloud credits) while sending arbitrary data home to its creators. This proxy server will be using Squid to pass along the connections from the IoT device to the intended destination so it can continue to function. However, alongide our proxy, the server will be using tcpdump to take full packet captures. The pcaps will be parsed for juicy data we might want to know about, and logged in a convinent webapp for the user to browse. 

This project is meant to be a proof of concept that we can keep track of what our IoT devices are up to with a bit of tinkering. 
