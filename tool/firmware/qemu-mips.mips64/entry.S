STACK_BASE_ADDRESS = 0xa001

.global bootloader_entry
.global flag_address

	.data
	.align	8

flag_address:
	.quad	__bootloader_end
	
	.text
	.align	4

firmware_entry:
	.set noat
	.set noreorder

	move $gp, $0

	# initialize the stack pointer register
	
	lui $sp, STACK_BASE_ADDRESS
	move $fp, $0
	move $ra, $0

	# initialize the general pointer register

	lui $gp, 0xbfc0
	daddiu $gp, $gp, __offset

	# save the stack pointer in the fp register and in the stack
	
	daddiu $sp, $sp, -8
	move $fp, $sp
	sd $fp, 0($sp)
	jal firmware
	nop
