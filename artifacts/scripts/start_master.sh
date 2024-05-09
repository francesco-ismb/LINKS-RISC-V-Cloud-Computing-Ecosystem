#!/bin/bash
qemu-system-riscv64 -machine virt -nographic -m 32G -smp 8 \
-bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.bin \
-kernel /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf \
-device virtio-net-device,netdev=net0 -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8082-:8080 \
-device virtio-rng-pci \
-drive file=master.img,format=raw,if=virtio
