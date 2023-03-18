A repository containing a detailed documentation of the activities in the VSD-HDP program

Program link: [VSD-HDP](https://www.vlsisystemdesign.com/hdp/)

   - Author: Visruat(Visruat T R), [visruattr@gmail.com](https://mail.google.com/mail/u/0/#inbox?compose=DmwnWrRlQHWhjxdSBCGtJrvNFWlRTXScgPpNKrkdZjWtwZbdTKCNsWBlKpBtVKVvbwZCnwGMFPxg)

   * Program quick links:-
     1. [Images](https://github.com/Visruat/Visruat-VSD-HDP/tree/main/images)
     2. 

   * VSD-HDP Status Quick links:-
     1. [DAY 0](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-0)
     2. [DAY 1](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-1)
     3. [DAY 2](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-2)
     4. [DAY 3](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-3)
     5. [DAY 4](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-4)
     6. [DAY 5](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-5)
     7. [DAY 6](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-6)
     8. [DAY 7](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-7)
     9. [DAY 8](https://github.com/Visruat/Visruat-VSD-HDP/blob/main/README.md#day-8)
     10. 

# VSD-HDP Status 

## Day 0 
System/Tool Setup Check --> all necessary tools and system updates were installed.

GitHub ID creation --> Done(https://github.com/Visruat/Visruat-VSD-HDP).

Design choice --> PWM generator.

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
$ cd yosys-master/yosys/
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
**Note : if an error occurs use ``` sudo apt install ngspice```**

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


```flatten``` was used to break the hierachy and make a single module.

__D flip-flop with asynchronous and synchronous reset__


![dffsyn](https://user-images.githubusercontent.com/125136551/219857161-d6b5deb7-a456-447c-9366-c101d98ecd9d.png)


to make use of the D Flip-Flop , the following command needed to be executed before mapping to the standard cell library

```dfflibmap -liberty <relative or abs path>/ lib file```


## DAY 3

Logic Optimization: combinational and sequential (basic)

__Combinational Logic Optimisation__

To remove unused cells from the synthesis design, the command ```opt_clean -purge``` is used. It optimises the cells that are redundant to the design but have been intialised from RTL code.

![optcheck4cells](https://user-images.githubusercontent.com/125136551/219866952-a6359b0c-0293-466b-a704-990336f26dfd.png)

The above diagram involves the cells invoked to solve a complex boolean logic ```y = a?(b?(a & c ):c):(!c);```

The optimisation of this boolean funvtion resulted in a XNOR gate ```y = a^c``` as shown in the image below:

![optcheck4syn](https://user-images.githubusercontent.com/125136551/219857860-fd9eef1a-f501-43ea-a60a-e2a5de6ab7bc.png)


Here is another example where a hierachy of the modules exist.

![multmodcells](https://user-images.githubusercontent.com/125136551/219863939-d9b5747b-4356-4ba9-a227-639b9a418f4a.png)

these cells were inferred on synthesisiing the RTL file

![multmodsyn](https://user-images.githubusercontent.com/125136551/219864007-2e21564e-685c-4b21-84b8-8a13735fb073.png)

The above image shows the synthesis of the design without removal of the hierachy. Yosys infers only the necessary logic which is linked to the outputof the design.

On removal of hierachy and optimising the logic using ```flatten``` and ```opt_clean -purge``` , the following result was obtained:

![multmodpurged](https://user-images.githubusercontent.com/125136551/219864171-661fcb69-49e3-4a3b-b639-75861e510cb6.png)

__Sequential Logic Optimisation__

Two examples were used to show the difference in design. [Sequential Constant - Basics]

![seqconst](https://user-images.githubusercontent.com/125136551/219864385-e66978cb-a138-440c-9410-fd8149d88fc6.png)

The above diagram is the optimised design after identifying a sequential constant. Since the values of q1 and q remain unaffected by any change in inputs the combinations of D flipflops was replaced by a simple wires.


![seqconstcells](https://user-images.githubusercontent.com/125136551/219864498-ad0cda10-8698-4830-9b5b-7c19eba99664.png)

Now consider the second case where a sequential constant was not identified

![dffconst5syn](https://user-images.githubusercontent.com/125136551/219864643-8930f23a-4f09-4d32-ad22-4f712d944e62.png)

The outputs q1 and q were not constant throughout and could be affected by inputs like reset and clk. Hence flops had to be inferred to complete the design synthesis. 

![notseqconstcells](https://user-images.githubusercontent.com/125136551/219864822-8db95e97-3fd7-4cc6-989c-c9ccee49bbc2.png)

__A case of optimisation of unused ports which are not linked to the design output__

3 bit up counter:

case 1: ```assign q = count[0];```


![dffoptimistation](https://user-images.githubusercontent.com/125136551/219865087-55a24ebd-45d1-4dbf-8027-45eac6be59e4.png)

it is clearly visible that yosys has optimised uncessary logic i.e the other two bits of the counter , that is not linked to the output q. 

case 2: ```assign q = (count[2:0] == 3'b100);``` 

![dffoptimisation2](https://user-images.githubusercontent.com/125136551/219865474-298f0499-542e-4d17-a39e-1de1f186b660.png)

In this case all bits of the counter are affiliated with q. Hence three flops are inferred to represent the same. The other circuitry contributes to the incrementation of the counter.


## DAY 4

__GLS, blocking vs non-blocking and Synthesis-Simulation mismatch__

Testing to check whether the netlist generated from the synthesis tool works with ur testbench (it definitely should!). But cases of RTL to GLS mismatch do exist.

To make sure that the netlist is to be checked you will need to call the library files present in verilog_model.

### Simulation-Synthesis Match using 2x1 MUX

A RTL design for a 2x1 MUX using ternary operator was tested and the follwing waveform was obtained.

![d4mux1](https://user-images.githubusercontent.com/125136551/221217670-618c955f-be66-4720-b648-4964f3d1d517.png)

The netlist for the same was generated using yosys and it was tested with the same testbench. To do so the library files needed to be called before doing so since the standard cell modules were used.

![d4mux2](https://user-images.githubusercontent.com/125136551/221218052-6303043c-2a33-494c-ab17-0ca254c2b09f.png)

From the two pics, it is clear that Simulation and Synthesis matching is happening.

### Simulation-Synthesis Mismatch using 2x1 MUX

The RTL Design for a 'bad' 2x1 mux was done by not completing the sensitivity list and was tested.

![d4badmux1](https://user-images.githubusercontent.com/125136551/221218656-a53af479-8550-4de1-a10a-40073c0ca300.png)

The output shown is not correct as the _y_ is updated only when there is a change in _sel_. The netlistfor the samw was generated and tested.


![d4badmux2](https://user-images.githubusercontent.com/125136551/221219194-20e5071f-50a2-4dbd-8568-1ed198d02c3e.png)

The difference in outputs is clearly stated. Hence a case of Simulation-Synthesis Mismatch is observed.

### Blocking caveat (understanding blocking assignements)

This RTL desgin of an OR-AND gate was done to understand blocking assigments in verilog. Inputs _a,b_ were fed to the OR gate and its o/p and input _c_ 
to an AND gate. The block was deigned with blocking assignments with the AND operation first followed by the OR operation. 

![d4blocking1](https://user-images.githubusercontent.com/125136551/221220468-26e98bf2-64c9-4227-b390-19bc98855d2e.png)

Output _y_ is incorrect as the previous value of OR o/p is taken for evaluation (flopped value)
The synthesis of this desgin was done and the netlist was tested.

![d4blocking2](https://user-images.githubusercontent.com/125136551/221221451-1821cb83-9107-49a9-a960-4b064691ffaf.png)

The output shown does incur the previous value of OR o/p hence giving the correct result.

![d4blocking3](https://user-images.githubusercontent.com/125136551/221221832-9ef9dcb6-3c48-41c6-b0e8-014c855f89f1.png)


## DAY 5

### Avoiding latches due to incomplete if case conditions 

Eg1: A 2x1 mux with no else block will lead to latch on the i0 - this will become the enable signal for the latch. It is observed in RTL simulation below.

![incomp if RTL](https://user-images.githubusercontent.com/125136551/225942900-c63bed48-9184-4b83-8b78-1a7daabf03ff.png)


a latch is inferred in yosys as well


![latch inferred ](https://user-images.githubusercontent.com/125136551/225942940-fa2950fb-6e6c-46c3-b6c9-b0339844014d.png)


![show incompif](https://user-images.githubusercontent.com/125136551/225942950-f8141a75-c9c7-47ac-9e6e-539a262ea37f.png)


Eg2: An undefined case will again lead to a latch being inferred. RTL simulation is shown below


![incomp_if2RTL](https://user-images.githubusercontent.com/125136551/225943746-1ede8623-310c-491d-846b-308b9fac4f8f.png)


Synthesis results


![image](https://user-images.githubusercontent.com/125136551/225944046-3267d819-284c-4993-9b45-f9ad41ec48b6.png)


![image](https://user-images.githubusercontent.com/125136551/225945648-b623f3e6-db5d-4c74-8831-bce598e786a4.png)


### Avoiding latches due to incomplete case conditions, partial assignments of case outputs ,overlapping case conditions.

__1) Incomplete Case Statement__

Lets take a 4x1 mux where the condtions for select =2,3 are not defined along with default case. Latch is inferred for select =2,3 with enable being sel1_n.

RTL Simulation

![image](https://user-images.githubusercontent.com/125136551/225950975-b376be70-84da-4068-9d8a-8cbd4afabb3d.png)


Synthesis Output


![incomp_case latch ](https://user-images.githubusercontent.com/125136551/225949703-232279e3-08be-49b5-93b2-eed8c7610680.png)


![image](https://user-images.githubusercontent.com/125136551/225955077-46807c63-abf3-4496-b37f-a1a6b5883a66.png)


__2) Partial assignment case statement__
The partial assignment code is as follows 
```
module partial_case_assign (input i0 , input i1 , input i2 , input [1:0] sel, output reg y , output reg x);
always @ (*)
begin
	case(sel)
		2'b00 : begin
			y = i0;
			x = i2;
			end
		2'b01 : y = i1;
		default : begin
		           x = i1;
			   y = i2;
			  end
	endcase
end
endmodule
```
y will have no latches.A latch will be inferred for x as it has not been assigned a value when sel =1;


RTL simulation 

![image](https://user-images.githubusercontent.com/125136551/225957262-77528930-ed57-483c-9630-c4f99b260107.png)


Synthesis Output


![image](https://user-images.githubusercontent.com/125136551/225957910-0f037ed3-706d-426e-8cf2-8dd172748b80.png)


![image](https://user-images.githubusercontent.com/125136551/225958201-463e64b3-a7bb-41d6-b408-ec2a1562d740.png)


__3) overlapping case statements__

A situation where more than one case is satisfied in case-statement. This constitutes to bad coding as there should never be cases of case-statements conditions being the same. You will be at the mercy of the simulator to see how it will simultae this confused state since all the cases are checked in a case -statement despite being satisfied(no priority order).

```
module bad_case (input i0 , input i1, input i2, input i3 , input [1:0] sel, output reg y);
always @(*)
begin
	case(sel)
		2'b00: y = i0;
		2'b01: y = i1;
		2'b10: y = i2;
		2'b1?: y = i3;
		//2'b11: y = i3;
	endcase
end

endmodule
```

RTL simulation 

![image](https://user-images.githubusercontent.com/125136551/225959632-5e1487b8-8e9a-4362-8a10-694c732838cb.png)

Synthesis Output
The Synthesis tool will optimise the code and remove the redundant parallel case. It is observed that no latches are inferred.

![image](https://user-images.githubusercontent.com/125136551/225960701-efa5f105-603a-4a6f-bf60-cdd7c6424849.png)

![image](https://user-images.githubusercontent.com/125136551/225960995-59f6be66-3bf8-47c4-ba45-48c1f675df8a.png)

There will be a simulation synthesis mismatch in this case as the code was optimised to remove the confusion.

![image](https://user-images.githubusercontent.com/125136551/225961703-ba3d88a2-1092-481a-b7d8-e1c4d7c34503.png)

### for and for generate

for - used inside always block for evaluating multiple expressions --> like large mux ,demux etc
generate for - used outside always block for initialising/generating multiple hardware units --> like ripple carry adder(rca)

#### 4x1 mux using for loop 

RTL code

```![incomp_if2RTL](https://user-images.githubusercontent.com/125136551/225978520-c1202055-b1bc-4d49-8d0e-26ca12cb0847.png)

module mux_generate (input i0 , input i1, input i2 , input i3 , input [1:0] sel  , output reg y);
wire [3:0] i_int;
assign i_int = {i3,i2,i1,i0};
integer k;
always @ (*)
begin
for(k = 0; k < 4; k=k+1) begin
	if(k == sel)
		y = i_int[k];
end
end
endmodule
```

RTL Siumlation


![mux rtl](https://user-images.githubusercontent.com/125136551/225978550-df4022a4-86e1-4348-9f97-0f44312295ff.png)


Synthesis Output


![image](https://user-images.githubusercontent.com/125136551/225979553-526243da-264f-4214-b53c-76221ad92990.png)


GLS Results

![image](https://user-images.githubusercontent.com/125136551/225980048-2d028788-2249-424b-8262-e6fe19f0cf0a.png)


#### 8x1 demux using for loop

RTL code

```

module demux_generate (output o0 , output o1, output o2 , output o3, output o4, output o5, output o6 , output o7 , input [2:0] sel  , input i);
reg [7:0]y_int;
assign {o7,o6,o5,o4,o3,o2,o1,o0} = y_int;
integer k;
always @ (*)
begin
y_int = 8'b0;
for(k = 0; k < 8; k++) begin
	if(k == sel)
		y_int[k] = i;
end
end
endmodule
```

RTL Simulation

![image](https://user-images.githubusercontent.com/125136551/225980841-2729e4f7-d061-4fbd-b4c8-21e7b7af7979.png)


Synthesis Output

![image](https://user-images.githubusercontent.com/125136551/225981397-749ea292-6a5f-4c62-a8f6-ae64deb0ba2b.png)


GLS Result

![image](https://user-images.githubusercontent.com/125136551/225981782-432fceea-ec69-4252-96ff-decaa3abf7b8.png)


#### Ripple Carry Adder using for generate

rule for addition - [N,M] +1 bits = o/p; N,M are inputs

RTL code

RCA
```
module rca (input [7:0] num1 , input [7:0] num2 , output [8:0] sum);
wire [7:0] int_sum;
wire [7:0]int_co;

genvar i;
generate
	for (i = 1 ; i < 8; i=i+1) begin
		fa u_fa_1 (.a(num1[i]),.b(num2[i]),.c(int_co[i-1]),.co(int_co[i]),.sum(int_sum[i]));
	end

endgenerate
fa u_fa_0 (.a(num1[0]),.b(num2[0]),.c(1'b0),.co(int_co[0]),.sum(int_sum[0]));


assign sum[7:0] = int_sum;
assign sum[8] = int_co[7];
endmodule
```

FA
```
module fa (input a , input b , input c, output co , output sum);
	assign {co,sum}  = a + b + c ;
endmodule
```

RTL Simulation

![image](https://user-images.githubusercontent.com/125136551/225982924-b975dd11-2571-4d11-81a2-03bfb2eb3a94.png)


Synthesis Output

![image](https://user-images.githubusercontent.com/125136551/225983351-a2aa43bf-2c62-4a6f-a377-ba18d57aa054.png)


GLS Result

![image](https://user-images.githubusercontent.com/125136551/225983999-88e13c62-3dff-4bc9-902e-80bb046abb15.png)


## DAY 6
![RTL](https://user-images.githubusercontent.com/125136551/226122845-9088655f-2f77-42f4-87a2-575126563f88.png)
![syn op](https://user-images.githubusercontent.com/125136551/226122854-39fb9c4a-8ae6-4061-804d-a4d58499f829.png)
![show](https://user-images.githubusercontent.com/125136551/226122855-2b1f677f-924c-4d48-9d71-5eaa19d77dd5.png)
![gls ](https://user-images.githubusercontent.com/125136551/226122848-e7b3fa69-8c6f-4ae2-b632-18e28ccde82b.png)



## DAY 7
#### Introduction to STA
1) Delay is a function of input transition i.e current (inflow) and output load i.e load capacitance (size of the bucket). [ direct proportional ]
2) Timing arc --> delay infromation from all inputs to all outputs eg 2 i/p AND gate has 2 timing arcs -> a-q and b-q. Any changes in the inputs will affect the output. For a D FF we have 3 timimg arcs -> Clk - Q delay , setup time and hold time. For a D latch we have 4 timing arcs - D - Q delay ,Clk - Q delay ,setup time and hold time.

__Note : triggering of DFF and Dlatch (setup and hold time) occur at sampling points. Therefore, for DFF it will be at posedge or negedge of Clk and for Dlatch it will be at negedge or posedge of Clk (pos level Clk or neg level clk). ------- IMPORTANT.__

![image](https://user-images.githubusercontent.com/125136551/226082362-7174f5b1-c83e-404e-afb5-234012385d75.png)

3) Timing path - the path for data to move from a) clk of one flop to the input of next flop (reg 2 reg) b) input to output (not present usually IO path) c) input to flop d) clk of flop to output (c,d are IO Timing Paths). The max Tclk value will be the critical path of the design as it will be the least clk delay that can be used for the design.

__Note :a) MAX constraint :- Tclk >= Tcq + Tcombi + Tsetup --> Data path(max) > Clk path(min)  
	b) MIN constraint :- Thold <= Tcq + Tcombi --> Data path(min) < Clk path(max)__ 
	
[Basic STA](https://www.vlsi-expert.com/2011/03/static-timing-analysis-sta-basic-timing.html)
#### Constraints

![image](https://user-images.githubusercontent.com/125136551/226086438-3547f090-33e1-4854-a296-a1eef6497aee.png)

The constraints are applied based on the design specifications
1) reg2reg --> contrained by clk -> Tcombi will be squeezed to compensate.

![image](https://user-images.githubusercontent.com/125136551/226086407-a651153d-d1a2-4286-a072-625c365c4524.png)

2) in2reg --> constrained by clk ,input external delay and __input transition__ . Input logic will be squeezed to compensate.

input external delay

![image](https://user-images.githubusercontent.com/125136551/226086333-19932b6c-88e7-4bb8-b486-e568aa0ab356.png)

input transition delay --> incresase input logic delay which needs to be further squeezed.

![image](https://user-images.githubusercontent.com/125136551/226089763-cbfd7cca-cdd0-4d19-9baf-db826860a240.png)


3) reg2op --> constrained by clk ,output external delay and __output load (parasitic capacitance)__. Output logic will be squeezed to compensate.

output external delay

![image](https://user-images.githubusercontent.com/125136551/226086364-8046c554-8212-4f55-8151-3b4d43015f51.png)

output load (parasitic capacitance) --> incresase output logic delay which needs to be further squeezed.

![image](https://user-images.githubusercontent.com/125136551/226089930-8df87567-603a-44bc-8d11-1f299bfa717f.png)


4) reg2op and in2reg are called IO Paths and the delay modelling is called IO delay Modelling. (standard interface specifications like SPI,I2C --> industry protocols)

NOTE : 1) rule of thumb --> external delay : internal delay is 70:30.
       2) IO paths need to be constrained for MAX delay(setup) and MIN delay(hold).

#### LABS
- exploring the library file and learning how the files were characterised --> area ,power , delay , capacitances , input (rise , fall) transistion , pin attributes --> direction,function,Clock pin,Timing sense and type etc , Power pin conncetions ( since logic gates are nothing but CMOS --> VGND , VPBN etc), and other necessary information.

![image](https://user-images.githubusercontent.com/125136551/226095402-93a465f4-f094-4947-8362-028d8f8a9fb2.png)

![image](https://user-images.githubusercontent.com/125136551/226095433-7d1a397e-a4c6-4c83-a519-ba5670235308.png)



- Lookup tables were also present in the lib file so that tool is able to select the necessary o/p based of the 2 indexes. Eg indexes --> input transition and output capacitance  o/p --> timing delay. in case the specified values dont lie in the indexes the range in which the values lie is taken and interpolation is done obtain the value at the specified point.

![image](https://user-images.githubusercontent.com/125136551/226095511-2ab24ee8-a79f-4e16-b63b-8dca76afbda4.png)


similarly sequential cells will also have such factors and there exist more dependencies of one pin o/p on the other pin o/p --> related pins. They will also have Clock pins --> There timing type will be specified based of the type of flop it is (rising_edge  or falling_edge --> posedge or negedge). The setup/hold time claculation part should also be specified to the tool as "setup_rising" or  "setup_falling" to let the tool know at what edge of clock must the setup time be calculated.

LHS - posedge clk , RHS - negedge clk for DFF -  defining type of clock

![image](https://user-images.githubusercontent.com/125136551/226096008-c0cf751f-879d-4997-bb1f-b5d673ced382.png)


LHS - posedge clk , RHS - negedge clk for DFF - defining setup time calc

![image](https://user-images.githubusercontent.com/125136551/226096288-8d461cb1-1b27-4d7b-a620-f2931e8a1849.png)

__dc shell commands -->  in our case we will be using OpenSTA since its a free source__ // verify if these functions match with OpenSTA 

```
> list_lib
> foreach_in_collection my_lib_cell [get_lib_cells */*<the cell you need> { 
	set my_lib_cell_name [get_object_name $my_lib_cell]; 
	echo$my_lib_cell_name;
	}
> foreach_in_collection my_pins [get_lib_pins <cell name>/*]{  --> my_pins is a loop variable
	set my_pins_name [get_object_name $my_pins];		--> 'get_object_name' 
	set pin_dir [get_lib_attribute $my_pins_name direction];   --> 'set' is for variable instantiation ; get_lib_pins/attribute <file_name> <pin/attribute_name>
	echo$my_pins_name	$pin_dir;                      --> to use a variable we use $<var>; to print a variable echo$<var>
	}

> source <script filename>.tcl --> for calling a script file
> list_attributes -app > a  --> for seeing all defined attributes in a library ; it is fed to file called 'a'.
```
A script file called my_script.tcl
![image](https://user-images.githubusercontent.com/125136551/226098186-1e40662f-f136-4dde-97f5-35cac9c742fe.png)


## DAY 8
