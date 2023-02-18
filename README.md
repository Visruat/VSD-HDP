A repository containing a detailed documentation of the activities in the VSD-HDP program

Program link: [VSD-HDP](https://www.vlsisystemdesign.com/hdp/)

   - Author: Visruat(Visruat T R), [visruattr@gmail.com](https://mail.google.com/mail/u/0/#inbox?compose=DmwnWrRlQHWhjxdSBCGtJrvNFWlRTXScgPpNKrkdZjWtwZbdTKCNsWBlKpBtVKVvbwZCnwGMFPxg)

   * Program quick links:-
     1. ....


# VSD-HDP Status 

## Day 0 
System/Tool Setup Check --> all necessary tools and system updates were installed.

GitHub ID creation --> Done(https://github.com/Visruat/Visruat-VSD-HDP).

Design choice --> to be discussed on 18th Feb,2023.

### Tool-1 Yosys 
__Installation guide__
```
https://github.com/YosysHQ/yosys
```

__Prerequiste dependency__
```
$ sudo apt-get install build-essential clang bison flex \
  libreadline-dev gawk tcl-dev libffi-dev git \
  graphviz xdot pkg-config python3 libboost-system-dev \
  libboost-python-dev libboost-filesystem-dev zlib1g-dev
```
	
__Installation Flow__
```
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
```

_Note : one can choose to make a separate build folder for performing the make command(installing yosys). This should be done after installing the dependency in the installation flow_
```
$ mkdir build; cd build
$ make -f ../Makefile
```
_Provides a path to the Makefile_

__Progress image__

![yosys](https://user-images.githubusercontent.com/125136551/218370390-bf2de5a9-b37c-48e3-b94a-840633051597.png)


### Tool-2 OpenSTA
__Installation guide__

```https://github.com/The-OpenROAD-Project/OpenSTA```
 
__Prerequiste dependency__

```$ sudo apt install swig```

__Installation flow__
```
$ git clone https://github.com/The-OpenROAD-Project/OpenSTA.git
$ cd OpenSTA
$ mkdir build
$ cd build
$ cmake ..
$ make
```
_optional_

```$ cmake .. -DUSE_TCL_READLINE=ON```

__Progress image__

![OpenSTA_3](https://user-images.githubusercontent.com/125136551/218371448-24d89203-6ad8-4032-9604-c2d83a0b6358.png)


### Tool-3 ngspice
__Installation guide__

Download the tarbell file `ngspice-37.tar.gz` from old releases parent folder from 

```https://sourceforge.net/projects/ngspice/files/```

__Installation flow__
```
$ tar -zxvf ngspice-37.tar.gz
$ cd ngspice-37
$ mkdir release
$ cd release
$ ../configure  --with-x --with-readline=yes --disable-debug
$ make
$ sudo make install
```
__Progress image__

![ngspice](https://user-images.githubusercontent.com/125136551/218372833-4e918809-5289-442d-888c-36851d5127f3.png)


**Note: gtkwave and iverilog were also installed**

_iverilog_

```$ sudo apt-get install iverilog ```

_gtkwave_

```
$ sudo apt update
$ sudo apt install gtkwave
```

_Magic_

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```

## Day 1

Learning how to use softwares like iverilog , gtkwave ,yosys etc

### 7x1 MUX using iverilog and gtkwave 

flow for simulation:
```
Iverilog and gtkwave codelines
- iverilog <filetop.v> <file1.v> …. <tb_filetop.v>
- ./a.out
Copy the generated dumpfile.vcd and run it with
- gtkwave dumpfile.vcd
```

__RTL__

``` 
`timescale 1ns / 1ps

module own_MUX_7x1(

    input [6:0] i,

    input [2:0] s,

    output reg y

    );

	always@(i,s)
	begin
		case(s)
				3'b000: y = i[0];
				3'b001: y = i[1];
				3'b010: y = i[2];
				3'b011: y = i[3];
				3'b100: y = i[4];
				3'b101: y = i[5];
				3'b110: y = i[6];
				3'b111: y = i[6];
				default: y = i[0];
		endcase
	end
endmodule
```

__Testbench__

```
`timescale 1ns / 1ps

module tb_own_MUX_7x1();

  reg [6:0]i;

  reg [2:0]s;

  wire y;

  own_MUX_7x1 uut(i,s,y);


initial
    begin
    $dumpfile("own_MUX_7x1.vcd");
    $dumpvars(0,tb_own_MUX_7x1);
    i=0;
    s=0;
    
    #300 $finish;
    end

always #10 i=i+1;
always #25 s=s+1;

endmodule

```

__Simulation Waveform__


![mux7x1_sim](https://user-images.githubusercontent.com/125136551/219855886-9130768c-4f81-4812-8152-2f44d8e2214b.png)


__Synthesis__

flow for synthesis under yosys:
```
yosys
read_liberty -lib <relative or abs path>/ lib file 
read_verilog <verilog_file.v>
synth -top <verilog_file> 
abc -liberty <relative or abs path>/ lib file ( generates results on ur design → netlist verify them before continuing)
show 
write_verilog <file_name>.v  OR    write_verilog -noattr  <file_name>.v 
```

![mux7x1cells](https://user-images.githubusercontent.com/125136551/219855926-364b343b-7303-473f-9ea2-206114cef57c.png)

The following standard cells were invoked when mapped to the standard library file.

The synthesis of the design is as shown below


![mux7x1syn](https://user-images.githubusercontent.com/125136551/219855998-d2f4b03f-24e6-48f1-b24b-92102bca1da3.png)

__Netlist__

```
/* Generated by Yosys 0.26+4 (git sha1 5ea2c290a, clang 10.0.0-4ubuntu1 -fPIC -Os) */

module own_MUX_7x1(i, s, y);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  wire _34_;
  wire _35_;
  wire _36_;
  wire _37_;
  wire _38_;
  wire _39_;
  wire _40_;
  wire _41_;
  wire _42_;
  input [6:0] i;
  wire [6:0] i;
  input [2:0] s;
  wire [2:0] s;
  output y;
  wire y;
  sky130_fd_sc_hd__mux2_1 _43_ (
    .A0(_33_),
    .A1(_34_),
    .S(_39_),
    .X(_36_)
  );
  sky130_fd_sc_hd__mux2_1 _44_ (
    .A0(_29_),
    .A1(_30_),
    .S(_39_),
    .X(_37_)
  );
  sky130_fd_sc_hd__mux2_1 _45_ (
    .A0(_31_),
    .A1(_32_),
    .S(_39_),
    .X(_38_)
  );
  sky130_fd_sc_hd__mux4_2 _46_ (
    .A0(_37_),
    .A1(_38_),
    .A2(_36_),
    .A3(_35_),
    .S0(_40_),
    .S1(_41_),
    .X(_42_)
  );
  assign _41_ = s[2];
  assign _40_ = s[1];
  assign _39_ = s[0];
  assign _35_ = i[6];
  assign _34_ = i[5];
  assign _33_ = i[4];
  assign _32_ = i[3];
  assign _31_ = i[2];
  assign _30_ = i[1];
  assign _29_ = i[0];
  assign y = _42_;
endmodule
```

## DAY 2

Hierarchy and flat synthesis under Yosys ; Synthesis of a flop

__Hierachy png__


![mux7x1synhier](https://user-images.githubusercontent.com/125136551/219856997-6584e4c7-fd94-4501-a307-a370e71d02e8.png)


__Flattened png__

![mux7x1synflat](https://user-images.githubusercontent.com/125136551/219857030-9ca7b55e-3e5d-40c7-b671-aa9cab585093.png)


'flatten' was used to break the hierachy and make a single module.

__D flip-flop with asynchronous and synchronous reset__


![dffsyn](https://user-images.githubusercontent.com/125136551/219857161-d6b5deb7-a456-447c-9366-c101d98ecd9d.png)


to make use of the D Flip-Flop , the following command needed to be executed before mapping to the standard cell library

```dfflibmap -liberty <relative or abs path>/ lib file```


## DAY 3

Logic Optimization: combinational and sequential (basic)

__Combinational Logic Optimisation__

To remove unused cells from the synthesis design, the command ```'opt_clean -purge'``` is used. It optimises the cells that are redundant to the design but have been intialised from RTL code.


![optcheck4cells](https://user-images.githubusercontent.com/125136551/219857892-20726746-7c77-4676-8f29-cd8d123b2312.png)


The above diagram involves the cells invoked to solve a complex boolean logic ```y = a?(b?(a & c ):c):(!c);```

The optimisation of this boolean funvtion resulted in a XNOR gate ```y = a^c``` as shown in the image below:

![optcheck4syn](https://user-images.githubusercontent.com/125136551/219857860-fd9eef1a-f501-43ea-a60a-e2a5de6ab7bc.png)
