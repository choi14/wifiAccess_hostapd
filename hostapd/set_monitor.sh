#!/bin/bash

sudo service network-manager stop

sudo iw dev wlp2s0 del

sudo iw phy phy0 interface add mon0 type monitor

sudo ifconfig mon0 up

sudo iw dev set freq 5200
