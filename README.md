# LINKS-RISC-V-Cloud-Computing-Ecosystem

This reporsitory is intended to keep track of the activities of porting and deploying tools to create a working and production-ready RISC-V based Cloud computing Ecosystem.
As such, these activities include the generation of basic development tools (i.e., compilers, libraries) supporting different programming languages (e.g., Golang, Rust, C/C++, etc.), virtualization tools (i.e., Qemu --for emulation of a 
computing platform, Gem5 simulator, etc.), Cloud tools (Kubernetes, OpenStack, etc.) and virtualization images (Linux).  

## Installing Golang compiler

A large fraction of the tools and frameworks used to run applications and emulate RISC-V processors are written in Golang (shortly Go). As such, the installation of the proper Go toolchain is a prerequisite for the correct compilation and installation of all the other frameworks and tools. 

Since the version of Go 1.4, the compiler is written in Go and thus is not possible to directly cross-compile the compiler (e.g., using GCC to compile the go sources and get the Go compiler. Rather it is required to use a **bootstrap toolchain**, i.e., basically a precompiled version of the tool(s) that can be used to build from scratch them by targeting a different architecture and version.

Let's assume the target architecture is **arch=riscv64** and the host machine is running Linux (Ubuntu) on a x86\_64 processor. The following steps apply to have the toolchain correctly installed.
1. Download the Golang archive (go<version>.linux-amd64.tar.gzip)
2. Untar the archive in the '/usr/local' folder
3. Add to the path to the binaries to the `$PATH` environmental variable:
	`
	$ vim ~/.bashrc
	export PATH="/usr/local/go/bin:$PATH" 
	source ~/.bashrc
	`
4. Testing that the compiler is correctly installed:
	`
	$ go version
	`
Once done, a bootstrap compilation toolchain should be available on the system. At this point, a building folder should be create in the system, and the bootstrap script invoked. To this end, let's assume that the `/home/<user>/workspace/` folder is created on the system. Then the following steps apply:
	
1. Create the target building folder:
	`
	$ mkdir go
	$ cd go/
	`
2. Download the **bootstrap.bash** script. Open and copy on a file named `bootstrap.bash` the code locate at [bootstrap script](https://go.dev/src/bootstrap.bash?m=text)
