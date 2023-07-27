#!/bin/bash

PLATFORM="virt"
KERNEL_IMG="../../tools/linux/arch/riscv/boot/Image"
DRIVE="../../storage/basic.img"
HDD1="../../storage/hdd.img"
MEM="2G"
SMP=1

qemu-system-riscv64 -machine ${PLATFORM} \
                    -smp ${SMP} \
                    -m ${MEM} \
		    -kernel ${KERNEL_IMG} \
                    -append "root=/dev/vda rw console=ttyS0" \
                    -drive file=${DRIVE},format=raw,id=hdd0 \
		    -device virtio-blk-device,drive=hdd0 \
                    -drive file=${HDD1},format=qcow2,id=hdd1 \
                    -device virtio-blk-device,drive=hdd1 \
		    -netdev user,id=eth0,hostfwd=tcp::8022-:22 \
            -device virtio-net-device,netdev=eth0 \
		    -nographic 
