# LINKS-RISC-V-Cloud-Computing-Ecosystem

This reporsitory is intended to keep track of the activities of porting and deploying tools to create a working and production-ready RISC-V based Cloud computing Ecosystem.
As such, these activities include the generation of basic development tools (i.e., compilers, libraries) supporting different programming languages (e.g., Golang, Rust, C/C++, etc.), virtualization tools (i.e., Qemu --for emulation of a 
computing platform, Gem5 simulator, etc.), Cloud tools (Kubernetes, OpenStack, etc.) and virtualization images (Linux).  

## Table of Content

- [CHAPTER 1](https://github.com/francesco-ismb/LINKS-RISC-V-Cloud-Computing-Ecosystem/blob/main/C01.md) 
	- Installing Golang compiler
	- Qemu for RISCV-64
		- SLIRP module
		- Qemu binaries creation
		- Example -- Creating a small virtual disk
- [CHAPTER 2](https://github.com/francesco-ismb/LINKS-RISC-V-Cloud-Computing-Ecosystem/blob/main/C02.md)
	- Building the Gnu GCC toolchain
	- Building Busybox
	- Building the Linux kernel
	- Emulating a small RISCV-64 machine
		- Running the emulated RISCV64 machine
		- Mounting virtual disk with Golang on the emulated RISCV64 machine

- [CHAPTER 3](https://github.com/francesco-ismb/LINKS-RISC-V-Cloud-Computing-Ecosystem/blob/main/C03.md)
	- Running a full-fledged Linux machine 
	- xxx