#  RV32I RISC-V CPU Design Using VHDL

This repository contains the source code for an **RV32I instruction set architecture RISC-V CPU** implemented in **VHDL**.  
The design is based on Chapter 7 of *Digital Design and Computer Architecture: RISC-V Edition* by **David Harris** and **Sarah Harris**.

The project follows the basic architecture from the book but includes several extensions to support additional instructions.  
It uses a **single-cycle processor architecture**, and the **ALU component** was designed completely from scratch.  
The CPU supports most of the RV32I instructions, with only a few exceptions.

---

##  Overview of the CPU Architecture
<img width="1867" height="1052" alt="image" src="https://github.com/user-attachments/assets/fcf9194a-274c-4b8b-9298-226d57802fa4" />


---

##  Microarchitecture (Based on the Book’s Design)
<img width="1038" height="598" alt="image" src="https://github.com/user-attachments/assets/be2237cb-57ee-412a-9137-7f6316f67967" />


---

##  Test Program Used from the Book
<img width="1061" height="785" alt="image" src="https://github.com/user-attachments/assets/ef87ddcc-be85-4b5c-b396-01ac2d32017f" />


---

##  Testbench Outputs

As shown in the waveform, the CPU performs correctly on the testbench program.  
(For more details, see the full waveform file.)

The test program from the book executes successfully in simulation.  
Implementation and bitstream generation were also completed without any errors.  
However, due to the lack of FPGA hardware, the design has not yet been tested on a physical board.

<img width="1555" height="675" alt="image" src="https://github.com/user-attachments/assets/0e5d4c13-b3e1-40ab-8d1d-7a5439c4b994" />


---

##  Next Steps & Improvements

- Extend the microarchitecture to support **all RV32I instructions**
- Add **output peripherals** (7-segment display, LEDs)
- Test the design on a real FPGA board (preferably **Nexys A7-100T** if available)

---

##  Tools & Environment

- **Language:** VHDL  
- **Simulator:** Vivado Simulator  
- **Synthesis & Implementation:** Xilinx Vivado  
- **Target FPGA (planned):** Nexys A7-100T  

---

##  Reference

*Digital Design and Computer Architecture: RISC-V Edition*  
by David Harris & Sarah Harris




