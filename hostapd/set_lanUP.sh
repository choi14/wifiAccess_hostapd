#!/bin/bash

sudo iw dev mon0 del

sudo service network-manager start

sudo iw phy phy0 interface add wlp2s0 type managed

sudo ifconfig wlp2s0 up

