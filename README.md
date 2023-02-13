# Visruat-VSD-HDP
documentation of the activities in the VSD-HDP program

## Day 0 
System/Tool Setup Check --> all necessary tools and system updates were installed.
GitHub ID creation --> Done(https://github.com/Visruat/Visruat-VSD-HDP).
Design choice --> to be discussed on 18th Feb,2023.

### Tool-1 Yosys 
__Installation guide__
> __https://github.com/YosysHQ/yosys__

__Prerequiste dependency__
>$ __sudo apt-get install build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev__
	
__Installation Flow__
$ mkdir yosys-master
$ cd yosys-master

$ git clone https://github.com/YosysHQ/yosys.git

$ sudo apt install make(installing make if you havent done it yet)

$ sudo apt-get install build-essential clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev

$ make

$ sudo install make
 

 
