A repository containing a detailed documentation of my progress in the VSD-HDP program

Program link: [VSD-HDP](https://www.vlsisystemdesign.com/hdp/)

   - Author: Visruat(Visruat T R), [visruattr@gmail.com](https://mail.google.com/mail/u/0/#inbox?compose=DmwnWrRlQHWhjxdSBCGtJrvNFWlRTXScgPpNKrkdZjWtwZbdTKCNsWBlKpBtVKVvbwZCnwGMFPxg)

   * Program quick links:-
     1. [PROJECT](https://github.com/Visruat/Visruat-VSD-HDP/tree/main/PROJECT)
     2. [netlists](https://github.com/Visruat/Visruat-VSD-HDP/tree/main/netlists)
     3. [PVT_Reports](https://github.com/Visruat/Visruat-VSD-HDP/tree/main/timing_reps)
     4. [Useful Scripts](https://github.com/Visruat/Visruat-VSD-HDP/tree/main/PROJECT/useful%20scripts)

   * VSD-HDP Status Quick links:-
     1. [DAY 0](#day-0)
     2. [DAY 1](#day-1)
     3. [DAY 2](#day-2)
     4. [DAY 3](#day-3)
     5. [DAY 4](#day-4)
     6. [DAY 5](#day-5)
     7. [DAY 6](#day-6)
     8. [DAY 7](#day-7)
     9. [DAY 8](#day-8)
     10. [DAY 9](#day-9)
     11. [DAY 10](#day-10)
     12. [DAY 11](#day-11)
     13. [DAY 12](#day-12)
     14. [DAY 13](#day-13)
     15. [DAY 14](#day-14)
     16. [DAY 15](#day-15)
     17. [DAY 16](#day-16)
     18. [DAY 17](#day-17)
     19. [DAY 18](#day-18)
     20. [DAY 19](#day-19)
     21. [DAY 20](#day-20)
     22. [DAY 21](#day-21)

## DAY 0

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

if it doesn't work ( version mismatch might occur when combining other open software )
$ sudo apt install yosys
$ sudo apt upgrade
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

if it doesn't work ( version mismatch might occur when combining other open software )
$ sudo apt install opensta
$ sudo apt upgrade
```

__Progress image__

![image](https://user-images.githubusercontent.com/125136551/226966597-885579c8-976b-475c-874e-f27dfca0be5f.png)


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


if it doesn't work ( version mismatch might occur when combining other open software )
$ sudo apt install ngspice
$ sudo apt upgrade
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
### PWM Generator with Variable Duty Cycle 

Pulse Width Modulation is a well-known technique used to create pulses of the desired width. The duty cycle is the ratio of how long that PWM signal stays at the high position to the total time period.

![image](https://user-images.githubusercontent.com/125136551/226958359-8436338d-4abd-4561-b30d-43bff62e4f49.png)

### Applications 
Pulse Width Modulated Wave Generator can be used to:

    - control the brightness of the LED
    - drive buzzers at different loudnes
    - control the angle of the servo motor
    - encode messages in telecommunication
    - used in speed controlers of motors
### Block Diagram

This PWM generator generates 10Mhz signal(dependent on the counter module in the block). We can control duty cycles in steps of 10%. The default duty cycle is 50%. Along with clock signal we provide another two external signals to increase and decrease the duty cycle.

![image](https://user-images.githubusercontent.com/125136551/226959879-1ecfcb77-c003-40eb-a5ca-18a2ea976ded.png)

In this specific circuit, we mainly require a n-bit counter and comparator. Duty given to the comparator is compared with the current value of the counter. If current value of counter is lower than duty then comparator results in output high. Similarly, If current value of counter is higher than duty is then comparator results in output low. As counter starts at zero, initially comparator gives high output and when counter crosses duty it becomes low. Hence by controlling duty, we can vary the duty cycle.

![image](https://user-images.githubusercontent.com/125136551/226961190-e529fe7a-2c46-4da1-8959-aee9d0ebcdda.png)

### RTL Simulation 

![RTL SIM  f](https://user-images.githubusercontent.com/125136551/226961985-c7ad5d84-f5ed-4fa7-b43c-79841d5a7785.png)

### Synthesis output

The logic of the code was implemented using the following components

![syn f](https://user-images.githubusercontent.com/125136551/226962025-541f88c7-2415-4467-969a-6c279fe5a422.png)

The gate level netlist generated connections were shown as follows

![syn imp](https://user-images.githubusercontent.com/125136551/226962038-11f69a85-23c7-4cdf-825f-75fdd3cf5766.png)

### GLS Simulation

The functionality of the PWM generator with variable duty cycle is retained post-synthesis. Hence the deisgn does not have __Simulation-Synthesis Mismatch__

![gls f](https://user-images.githubusercontent.com/125136551/226962059-d2b5ccf8-ceee-400b-a78f-ae5645e93074.png)


The related files are present in the [PROJECT](https://github.com/Visruat/Visruat-VSD-HDP/tree/main/PROJECT) folder.

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

NOTE: Important Constraint Commands
      1)get_clocks
      2)get_ports
      3)get_pins
      4)get_nets
      5)set_input_transition -min -max
      6)set_input_delay -min -max 
      7)set_clock_latency -source 
      8)set_clock_latency -
      9)set_clock_uncertainty -
      10)create_clock -name -per -wave
      11)get_attribute 
      12)create_generated_clock -master -source -div
      13) regexp a b
      
      
## DAY 9

__IN2REG constraints and REG2OUT constraints__

The three start point is from the inputs of the design : reset, increase_duty(Flop),  decrease_duty(Flop). There is no slack violation in the mentioned cases.

![image](https://user-images.githubusercontent.com/125136551/232226421-a99156da-5d16-40a9-b6c5-3f7789728707.png)




![image](https://user-images.githubusercontent.com/125136551/232226453-2f31eb16-37e9-4633-90af-4ac87c5ed26a.png)




![image](https://user-images.githubusercontent.com/125136551/232226481-ce6b6c91-14ec-4441-a957-dd5ac33c52b4.png)


The __reports__ generated by OpenSTA show that the design does not have any violators // add hyperlink here


## DAY 10

#### An introduction to SPICE and how it is used to analyse MOSFETS 

The graph below is a spice simulation of a long channel NMOS with __W = 5 L = 2__


![image](https://user-images.githubusercontent.com/125136551/233771071-c14b2d88-1c8b-40f7-8425-d2d989a0d941.png)


Some of the coordinates as shown in ngspice

![image](https://user-images.githubusercontent.com/125136551/233771047-132f89bf-25d7-4a4d-b76f-9682cd5fe603.png)

__Long and Short channel__ ( L > 25nm and L < 25nm ) 

Due to velocity saturation effect in short channel MOS, the saturation sets in early. As a result the peak current is much less compared to long channel MOS.

in the given case the L-channel MOS has peak current idmax = 410 uA while S-channel MOS had peak current idmax = 197 uA.

<img src ="https://user-images.githubusercontent.com/125136551/233771071-c14b2d88-1c8b-40f7-8425-d2d989a0d941.png" width="500" height="500"><img src ="https://user-images.githubusercontent.com/125136551/233774523-fd57c97e-a4c3-4f5c-9dbe-2f8e8c2342fa.png" width="500" height="500">

a plot between id vs Vgs at constant Vds = 1.8V

![image](https://user-images.githubusercontent.com/125136551/233775052-ab88d22d-df4f-4d73-8977-2cc97b945803.png)

The threshold voltage Vt =  0.75V for this NMOS 

__CMOS Voltage Transfer Characteristics__ 

![image](https://user-images.githubusercontent.com/125136551/233779653-3d2e6d8d-057c-43c0-b223-ee471122931c.png)

NMOS and PMOS dc characteristics were merged and the voltage transfer characteristics for CMOS inverter was plotted. The above diagram denotes the behavior exhibited by the NMOS and PMOS clubbed together at different Vin and Vout conditions in the range of 0 to 2 V.


## DAY 11

__SPICE Simulations for Id vs Vds for W = 0.39u and L = 0.15u
![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/edcae396-09af-4a22-bf2c-284e48abf77f)

- It can be seen that compared to the previous Id vs Vds graph that the saturation current slightly increases even though W/L ratio remains constant. This is because of short channel effect.

__SPICE Simulations for Id vs Vgs for W = 0.39u and L = 0.15u__
![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/b4b88d77-b5c0-46f6-b4f1-d5cf7f79f0ad)


__SPICE Simulations for Id vs Vgs for W = 3.12u and L = 1.20u__
![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/ed89cd8b-a633-4ca1-9e88-ebdb8d3a3e41)

- It can be seen from the even though the W/L ratio remains 2.6 for both the plots, Id is slightly different. Short channel transistor characteristics has more linearity than the long channel one.

__Velocity Saturation__

- At higher electric fields, the electrons velocity becomes constant.
- This happens in short channel as the electric field strengh increases due to reduced channel length.

__VTC__

- Used to calculate the delay tables for STA.
- The plot of Vout vs Vin in CMOS inverter.

## DAY 12
__Spice Netlist for inverter__

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/0afa4e76-d92e-4444-9c02-022bf00ad043)

__Spice Simulation for VTC of CMOS Inverter__
![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/4e549d52-0c62-4c46-8c42-81a6e4712529)

The switching threshold voltage was found to be around __0.87 V.__

## DAY 13
__Spice Simulation of CMOS Inverter ( V vs Time )__

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/d953ae15-2526-49cf-a6bd-4f04db9465a0)

- From the above simulation delay values for rise and fall can be observed.
- Rise time --> 0.33ns
- Fall time --> 0.28ns 
- The delay values of different inverters with increased pmos W/L ratio can be found.
- It is seen that the value of rise delay decreases and fall delay increases with increase in W/L of pmos.

## DAY 14
__NOISE MARGIN__
```
    NMH = VOH-VIH // High noise margin
    NML = VIL-VOL // Low noise margin
```

__SPICE Simulation__

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/51d61db3-5507-497f-98f9-432d5c20d3e6)

- VOH = 1.728 V , VOL = 0.066 V, VIL = 0.754 V, VOH = 1.014 V.
- NMH = 0.714 V
- NML = 0.688 V

## DAY 15
__Spice Simulation of Power Supply Scaling__

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/f65bde36-74ff-4e60-90f1-de13655e662e)

- It can be observed by the above values that the gain increases as power supply is reduced upto 1.2 V and after 1 V it starts decreasing.

__Spice Simulation of Device Variation__

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/711622b6-3ab7-4455-af62-f0b4927df364)

- The swithing threshold is observed to be around 0.98 V.
- The pmos W/L ratio is more than its nmos counterpart due to which the pmos charges the load capacitor more. Meaning we have a strong p-fet and a weak n-fet.

## DAY 16

### STA on PWM_gen.v with different ss,ff,tt PVT corner

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/c6453e93-04ae-4b16-a89e-6430162f01b0)

__Plot of TNS,WNS,WHS and Worst Slack with multiple corners__

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/5dbc0368-59f7-4a83-9045-9705dbb21728)

## DAY 17

### Software - Hardware (S-H) Communication


![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/10c5d32d-1104-441a-acd3-51af8262cc29)


The above image represents the S-H translation. It starts at the __software application level__ which takes in an __input__. This input is now processed by the __Operating System (OS)__. An OS performs low level system functions, handles IO operations and allocates memory. It instigates the __Compiler__ to convert _high level abstract code_ of the software to _Assembly/Low level code instructions_. This is further converted into a _bit stream_ by the __Assembler__ to serve as input to the __Hardware__.

<p align="center">
	<img width="450" height="500" src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/412487d0-b764-449f-9da2-8c5eaf6bd351">
</p>


The __Instruction Set Architecture (ISA)__ refers to the 'architecture' of the computer/processor. For example, if the ISA used is of RISC-V, the code converted by the compiler should give instructions suitable for RISC-V core. Hence, one can say that ISA basically represents the Hardware at an intermediate stage. 


![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/9a58e474-b8a3-446a-bdb1-772cab4a852c)


The Assembler converts the instructions into a bitstream that is fed to the Hardware. To obtain the hardware or final layout, a certain number of steps need to be followed. The RTL/HDL of the core followed by an optimised/synthesized netlist which is converted into the layout/hardware.

### Introduction to Physical Design

Consider a chip on an arduino board, it would contain the following components:-


![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/1551e2ed-fba2-4277-a661-073d2be9152a)


It has several protocols, an _external_ memory unit (SDRAM), GPIOS, PWM etc. Now all (except memory external chip) of these are contained in a __package__ as shown below.


![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/484c9864-35d7-4120-8ad1-e57419dc6a1a)


It represents a 7x7 [dimensions] QFN-48 [Quad Flat No leads; 48 pins].


![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/ac6af3b0-f2c0-45fa-ac35-1fbc0109fe9b)


The chip is connected to the package with the help of __wire bonds__


![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/51f2a10b-b436-4fac-8c70-9e4418f4efaf)


Signals are sent to and fro the pins of the chip via __pads__. The __die__ is the minimal silicon area on which the pads are present. The __core__ is the region which contains the logic of the designed chip.


![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/62ec00a5-33cc-45a3-8fee-00c6f07a51e4)


The core region contains __Macros__ and __Foundry IPs__. __Foundry IPs__ are intellectual blocks which are designed specifically by the foundry and it is unique to each foundry. Some examples are PLL, SRAM, DAC, ADC, etc. __Macros__ are Digital designs which form the crux of the core region. In this case, RISC-V SoC, GPIO bank etc.

__Summary__

- The chip in general contains many cores which are known as foundary IPs. These can be PLL, SRAM, DAC etc.
- The general flow from applicaton software down to the hardware with system software block in between.
- System Compiler consists of the OS, Compiler and the assembler.
- OS handles I/O operations, memory management, process management and low level system functions.
- Compliler converts high level code into the respective low level code according to hardware (ARM, Intelx86, RISCV, MIPS etc).
- Assembler converts low level machine instructions (ISA) into binary streams.
- Hardware description is written in HDL for respective ISA to follow PD flow.

### Openlane and sky130 pdk inception

__What is PDK?__

PDK (process design kit) is the interface between the FAB and the designers.
It contains a collection of files used to model a fabrication process for the EDA tools used to design an IC.
- Process Design Rules: DRC,LVS,PEX
- Device Models
- Digital Standard Cell Libraries
- I/O Libraries etc

__RTL TO GDSII flow__

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/069f7525-a2f1-4430-a535-c33f2e5ec505)
1) RTL Design

2) Synthesis
   - Translation of RTL to a gate level netlist using Standard Cell Library (SCL). It is followed by STA to check for initial timing violation.
  
3) Floor planning (PD)
   - Initial Layout of the Design.
     - Chip Partitioning --> divide the design into smaller blocks while maintaining functionality.
     - Macro Partitioning --> dividing and placing macros, rows and pins.
     - Power planning --> setting the VDD and GND layers. The top layers are used as they are wide and offer less resistance.
       
> the above steps involve Partitioning, Floor planning and Power planning.

4) Placement
   - finalised layout of the modules, macros, pins and pads.
     - Global --> tries to find optimal position for all cells. Such cells are __not neccesarily legal__. There is __overlapping__ of cells.
     - Detailed --> placements obtained from global are minimally altered to be legal.

5) Clock Distribution Network  
	- Clock Tree Synthesis (CTS) performed to ensure the clk signal reaches all sequential elements in a circuit design with __zero to minimal skew__.
        - CTS alters the netlist. Functionality check is required before progressing
        - __Logical Equivalence Check (LEC)__ --> formally confirm that the function did not change after modifying netlist
> it is imperative to check functionality when the netlist is modified.

Note: __Fake antenna diode insertion__ --> Antenna violations may occur which cause damage to the transistors as reactive charges begin to accumulate (usually taken care by Routing).
There are two methods to approach this issue.

- Bridging --> Attaches higher layer intermediary.
- Antenna diodes --> nullify reactive charges.
  
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/e003fdee-41e0-4709-8136-45a33d6c4c48" width="400" height="200">	<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/f0dc3fa0-3805-4353-a8e1-4e712a247844" width="200" height="200">

OpenLane adds fake antenna cells to all gates after placement --> if ant violation is detected it will replace the fake cell with a real one.

6) Routing ([Reference](https://www.vlsi-backend-adventure.com/routing.html))
   - Implement the interconnect (horizontal and vertical wires) using the available metal layers.
   - The skywater pdk contains all the data ( location, size, thickness, pitch, vias ..etc) about the interconnect/metal layers.
   - Metal tracks form a routing grid.
     - Global Routing --> coarse grained grids used to generate routing guides
     - Detailed Routing -->  fine grained grids and routing guides to implement actual wiring.
   - Physical Verification --> DRC and LVS.
   - Timing Verification --> STA
  
> skywater130 pdk --> (1) lowest layer/local interconnect layer (Titanium Nitride) + 5 layers above (Aluminium) = (6)
	
__Note: OpenLANE --> produce clean (no DRC, LVS, timing violations) GDSII with no human intervention.__

5) DFT (Design for Testing)
	- Scan insertion
	- Automatic Test Pattern Generation (ATPG)
	- Test Patterns Compaction
	- Fault Coverage
	- Fault Simulation

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/2b673784-f3fa-4fa3-9efa-1cb9d0189007" width="400" height="200">

6) Physical Implementation (Automatic PNR) --> OpenRoad
	- Floor/Power planning
	- End Decoupling capacitors and tap cell insertion
	- Placement
	- Post Placement Optimization
	- CTS
	- Routing

### Installation ([Reference](https://openlane.readthedocs.io/en/latest/getting_started/installation/installation_ubuntu.html))

Docker installation.
``` 	
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot 
```

After reboot, check for correct installation.
```
docker run hello-world
```

Successfull installation

![Screenshot from 2023-11-20 11-38-47](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/060050d6-988e-4ce1-aff2-da981d1a0b46)


Check for the following dependencies.
```
git --version
docker --version
python3 --version
python3 -m pip --version
make --version
python3 -m venv -h
```

Download and build OpenLane from github
```
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```

Run a basic test.
```
# Enter a Docker session:
make mount

# Open the spm.gds using KLayout with sky130 PDK
klayout -e -nn $PDK_ROOT/sky130A/libs.tech/klayout/tech/sky130A.lyt \
   -l $PDK_ROOT/sky130A/libs.tech/klayout/tech/sky130A.lyp \
   ./designs/spm/runs/openlane_test/results/final/gds/spm.gds

# Leave the Docker
exit
```

Successful execution with some warnings.

![Screenshot from 2023-11-20 12-07-11](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/dc397965-39c5-4d37-8988-47871b39ae9f)


### Labs

Openlane is automated RTL to GDSII flow that consists of multiple tools (obviously opensource) such as OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, KLayout and a number of custom scripts for design exploration and optimization. It has two modes to promote "No human in flow", that is, autonomous and interactive. For understanding the process of the flow, I will be using the "interactive" method.

Before I get into the Openlane Flow, A small intro about Opensource pdks used in Openlane would be helpful. 

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/cd47dd12-2490-44b3-9400-dbafa6a4da6e" width="400"> <img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/aa718735-34ec-4175-9951-4d45a61c4140" width="400">

From Openlane is compatible with pdks namely skywater130 and osu. _sky130A_ is the variant of _skywater-pdk_ which is compatible with opensource tools.
Under the variant, we have libs.tech--> contains the library files related to the tools used in the flow and libs.ref--> contains library files for the different skywater pdks

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/6031a7c1-5379-417d-9a29-f6993af06441" width="400"> <img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/222593c1-444e-43c0-ae4e-5c1efc69b5d1" width="400">

I will be using _sky130_fd_sc_hd_ for my design. 

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/bf0c6efd-5d19-4a88-858e-838d4b2478a0" width="400">

> Look into the different types of file types which are used to build a pdk.
> - verilog --> netlists
> - techlef --> metal layer data and design rules (technology files)
> - spice --> circuit netlists of analog devices 
> - maglef --> used for displaying metal layers in the layout tool
> - mag --> used for displaying layout on the layout tool
> - lib --> contains the flavours of library files for different process corners. In short logical libraries.
> - lef --> contains physical info such as shape, size, direction, and symmetry, input and output pins direction for each cellin the design.
> - gds --> (GDSII) used to store IC layout information.   
> - cdl --> similar to spice netlists; stores electronic circuit information.

### Commands to run OpenLane

Starting up docker 
```
cd Openlane
make mount
```

In docker
```
./flow.tcl -interactive
package require openlane 0.9
prep -design picorv32a
```
This sets up the tool for running the flow for the design _picorv32a_ under the _designs_ folder.

``` run_synthesis``` 

is used to perform synthesis and sta of your design.

Note: For a custom design. You will need to create a _config.tcl_. The _sky130_fd_sc_hd_config.tcl_ is not compulsory. _Config.tcl_ overwrites default parameters.

So the question that arises is _what is in the file?_
```
 # Design
set ::env(DESIGN_NAME) "picorv32a"

set ::env(VERILOG_FILES) "./designs/picorv32a/src/picorv32a.v"
set ::env(SDC_FILE) "./designs/picorv32a/src/picorv32a.sdc"

set ::env(CLOCK_PERIOD) "5.000"
set ::env(CLOCK_PORT) "clk"


set ::env(CLOCK_NET) $::env(CLOCK_PORT)




set filename $::env(OPENLANE_ROOT)/designs/$::env(DESIGN_NAME)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
        source $filename
}
```

Config.tcl is used to set the files and parameters in the flow environment. As shown in the snippet above.

### Lab exercise
__Flop ratio and chip area__

pattern_1 ( before opt command ) <br>
1613/18036 = 8.9432%

pattern_2 ( post opt command ) <br>
1613/14876 = 10.8430%

Chip area for module '\picorv32a': 147712.918400

## DAY 18

### Width and Height of cells
Lets consider a basic example of a combo logic between capture and launch flops. Each cell and each flop will have dimensions (in this case lets take unit dimensions). Now to produce the components of the netlist (cell and flops) , it needs to be structured on the silicon wafer die. Hence I would need to place these components of the netlist in certain way such that it fits in the core to be placed on the die.

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/64240f25-2bab-4cbb-ad2d-187fb5cf8420" width="400" height="150">
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/a2b07969-04a4-44eb-9b33-a47b07e89af6" width="450" height="150">

__Utilization factor__ = Area of the netlist / Total area of the core ( < 1 usually 0.5/0.6 ) <br>
__Aspect ratio__ = Height / Width of the core ( if 1 --> square core; else --> rectangle core ) <br>

The below image explains the factors <br>
<br>
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/8b3d7831-2b46-4173-95ee-05292dea43d1" width="450" height="250">

### Chip Partitioning 
lets consider a combo logic which consists of a massive number of gates (50,000). When implementing this on a single die the utilization factor will surely increase. Hence the gates are partitioned into smaller blocks with input and outputs between these blocks. These blocks can further be converted to a black box to aid in reuseability of the function in the design.

<p align="center">
	<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/c284fe11-8418-4fc3-880b-b66c82c8be84" width="450" height="350">
</p>

When hard macros such as memory, comparator,.. etc are used in the designs, these locations are user defined and the tools will not touch these IPs during the automated PnR flow.  
<br>

Note: Macro is a predefined and reuseable blocks of logic which can perform specific tasks. There are two types of macros, namely: <br>
- Hard macros --> non-flexible, PPA and timing is fixed, available as ICs, industry graded.
- Soft macros --> flexible, PPA and timing is unpredictable, synthesizable RTL.

### De-coupling Capacitors

Memories are often placed close to the input side. Memory units serve as pre-placed cells. Now connectivity with these units is done through the supply/power lines in the chip. They are connected with wires. The physical distance between the source and the cell will cause a drop in the voltage. In such a scenario, if the voltage reaching the cell is not sufficient to meet the _Noise Margin_ specifications, it would cause an unpredictable output at the cell. The solution for it is to use de-coupling capacitors to provide a "backup supply" closer to the unit(zero to minimal voltage drop due to very short distance).

__How does a de-coupling capacitor work?__ <br>
lets take an AND gate. During switching from 0 to 1 state, if the voltage being supplied to the gate from the Power line drops below the required voltage, the __capacitor Cd__ discharges and supplies power to the AND gate temporarily to ensure correct voltage is being supplied. When no switching is taking place the __Cd__ is charged by the Power lines. Hence it ensures proper voltage is being supplied to the gate during switching operations. <br>
It also bypasses high frequency noise from other units and prevents crosstalk between closely placed cells. <br>

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/21fcf596-e024-4452-8aad-48501dc14ff1" width="450" height="350">
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/f49706b1-f480-4db8-b725-3c1ead2bf18d" width="450" height="350">

### Power Grids
The power fluctuation issue was stabilised for a local module using de-coupling capacitors. Now I will have to consider fluctuations between multiple such modules in the chip. <br>

<p align="center">
	<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/d979f008-6b43-434a-b1a0-13b14a840bca"  width="500" height="500">  
</p>

<p align="center">	
	The orange line indicates a 16-bit bus.
</p>

<p align="center">
	<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/da8f65a2-5885-438e-9ece-ebb122102efd" width="600" height="200">
</p>

It is not feasible to have capacitors throughout the chip. However, if not considered it will lead to __voltage drooping__ and __ground bounce__ which will momentarily affect the working of the chip (it is bad for large designs). __Voltage drooping__ is a condition in which multiple capacitors (of a bus) draw current from the same power line causing the source voltage to drop below the original value. Closely, __ground bounce__ is a state when the ground value is slightly above zero because of many capacitors discharge current into a single ground line. These will definitely lead to uncertaintity in the internal functioning of the chip.

<br>
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/05da09e1-7498-47f6-a2c5-38820aee64b6" width="500" height="200">
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/3cbdaf95-9835-45f8-a9b9-7b96a7e36530" width="500" height="200">
<br>

The solution to this problem is the introduction of many other power lines in the form of a grid/mesh. Hence the capacitor closest to the power line can tap into whichever needed. VDD power lines are placed in vertically and horizontal layers with metal contacts. The GND lines are also placed similarly in the same level as VDD. However it is made sure that both these lines are isolated from each other. <br>
<p align="center">
	<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/3bd5141f-266c-4a4b-8731-1caf3ea5135e" width="600" height="500">
</p>

### Pin placement 
A chip will have input as well as outputs and to tap into these values I will require pin placement on the chip. Once the design is complete, all the inputs and outputs are placed in a region specifically reserved for pins. This is done by adding a blockage element to that area to restrict the tool from placing cells. This is called as __logical cell placement blockage__.

<p align="center">
	<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/0e51e84a-e244-4d0e-9482-fc7f6e40b9c1" width="550" height="400"><br>
	sample design
</p>

The pins are optimized by fanout from a common point and are placed in a random order in the reserved area. Many parameters are considered while placing the pins such as _connectivity, proximity, type of pins (eg i/o, clk, power/gnd),.. etc_. Clock signal is used to facilitate all the flops and sequential elements in the chip. Hence, the clk pin is larger than the i/o pins so that it offers least resistance to the path.

<p align="center">
	<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/ae81c5ed-1f6e-4700-8b38-13bfcb16a1e5" width="550" height="400"><br>
	floorplan of sample design
</p>

### LABS

Change switches/variables ( info under _configuration_) in the design __config.tcl__ to suit your needs. Then run the follwong command.

```run_floorplan```

to check the results go to the _runs/floorplan_ folder.
to view the floorplan we make use of magic. The command is as follows:-

```magic -T /home/pandabro/.volare/volare/sky130/versions/dd7771c384ed36b91a25e9f8b314355fc26561be/sky130A/libs.tech/magic/sky130A.tech lef read /home/pandabro/OpenLane/designs/picorv32a/runs/RUN_2023.11.17_06.16.24/tmp/merged.nom.lef def read picorv32a.def ```

floorplan results.

![Screenshot from 2023-11-21 17-15-18](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/b6e8a7b6-4c32-465d-ae1c-8cb6f750d7ef)

The decap capacitors and tap cells (prevent latchup) are placed on the layout by tool. The physical edges are labelled based of the number of rows (same on b/s) and edges on _Right_ and _Left_. Refer to the diagram below.
```

			    Left _2x+1_ ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| Right _x_
     					|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	  				|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
					.....							        |
					.								|
					.								|
			    Left _x+1_  .								| Right _0_
```

The image for reference.

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/e30ea154-b0f1-4f55-98ab-67710c0c5ac3)

Standard cells to be placed after placement.

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/60d57109-a144-4b91-9c37-6d7e80f5c8a9)


### Placement ([Reference](https://www.physicaldesign4u.com/2020/02/placement.html))

Placement involves the placing of standard cells onto the floorplan of the die/core. It occurs in 2 steps, that is, __Global Placement__ and __Detailed Placement__. <br>
Global Placement is a coarse placement of cells which will consider initial timing constraints, congestion and multi-voltage variants. However they are not legalised ( meaning the cells are placed such that they are not present on the standard cell rows, not appended with each other [incase of high frequency operations] and they overlap other cells --> in short they arent placed perfectly). Legalisation occurs in Detailed Placement. This will give rise to new timing violations as the postions of cells will be minutely changed and hence the wire lengths (capacitances) will also change. This will have to be optimised to progress forward. 
<br>
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/07c8573a-8323-443c-af6c-923d7d7ed204" width="300" height="300">
<br>
The above image depicts a physical view of logic cells.

These cells are placed onto the core space in the following manner. <!--insert image of placement here--> <br>

![image](https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/e8bb9ca8-a805-40ef-ab02-5c61b83ad9af)

To ensure that the timing is maintained we optimise the placement. The respective cells are placed as close as possible to the related derivatives. In case signal intergrity fails due to large distance between the cells, repeaters (buffers) are placed in the path to reproduce the signal and drive it to the respective cell. Hence Area is compromised for better timing and performance.

### Cell Design Flow

Library file contains information about the gate functionality, dimensions, capacitance rating, timing and delay values and much more. We build, characterise and model these cells so that the tool can understand it.

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/a3149f41-2958-411e-ae9b-76d7b71ce130" width="400" height="500">

It consists of 3 sections:- <br>
__Inputs__
1) PDKs --> files which contain information about the technology being used for yout design.
2) DRC & LVS --> Physical design rules that need to be met so that the foundry can fabricate the cell.
3) SPICE Models --> contains characteristics of the transistors that will be used to build the cell (threshold voltage, aspect ratio, capacitances, etc).
4) library and user-defined spec --> cell height (_space between Vcc and Gnd rails_), cell width (_delay constraints, drive strength_), supply voltage (_noise margin_), metal layer specs (_specific metal layer to be used_), pin location (_close to Vcc or Gnd_).

__Design steps__
1) Circuit design --> The circuit is designed by making use of the industry parameters and inputs. For instance, to model the aspect ratio of 2.5, the PMOS = 2.5 NMOS dimensions while keeping height constant based of the technology file. Similarly, Switching threshold is also model based off the requirement.
2) Layout design --> build the circuit with transistors to meet the required functionality, apply Euler's Path (unidirectional traverse only) and create the respective network graphs, implement the stick diagram of the circuit topology. Finally, it should pass all the DRC & LVS checks set by the foundry.
3) Characterization --> specific flow; Gives information on Timing, Power and Noise in the form of _.libs_ files along with functionality.

<br>
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/df2409dc-9c69-49b7-b4ff-d75c73ef04b2" width="500" height="400"> <img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/d92bbb95-d8af-44a2-b563-7ec8c89ef4bf" width="500" height="400"> <img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/c5d8ece1-08c4-4550-9cf8-1d415d4bf403" width="500" height="400"> <img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/545d4640-143e-4cd0-89de-2e9832588416" width="400" height="400">
<br>

__Outputs__
1) Circuit Description Language (CDL)
2) GSDII, LEF, extracted SPICE netlists (.cir)
3) Timing, noise, power .libs, function

#### Characterization Flow (GUNA)
1) Read the SPICE Model file
2) Read extracted SPICE netlist
3) Recognise the behavior of the circuit design*
4) Read sub-circuit of the design
5) Set the Power supply
6) Apply stimulus
7) Provide the load capacitance (NLDM --> range of capacitances)
8) Provide simultion constraints

Timing Characterisation --> Delays between input and output wave from (Propagation Delay), Rise time; Fall time delays (Transition delay). <br>
Solution --> Choosing the correct threshold points, Having proper circuit designs to reduce the wire delays. _Negative delays_ are _intolerable_. <br>

<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/72aa483e-7335-4b73-8bbc-3f7b29d1a988" width="250" height="250">
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/be38fd5a-345e-45ac-9caa-e3a535bd0f04" width="350" height="250">
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/896b1931-bd6e-4960-bf49-dfc6370ffa98" width="350" height="250">
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/2e2576f8-a4ca-4ac6-8376-3da66a12c8fd" width="400" height="400">
<img src="https://github.com/Visruat/Visruat-VSD-HDP/assets/125136551/cb2bed31-1219-4d27-b4be-4c1b22de43b6" width="400" height="400"> 

## DAY 19

## DAY 20

## DAY 21




