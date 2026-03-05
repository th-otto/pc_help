AES_GLOBMAX		equ		80
AES_ADDRINMAX	equ		128
AES_ADDROUTMAX	equ		6

VDI_CNTRLMAX    equ		15
VDI_INTINMAX    equ		128
VDI_INTOUTMAX   equ		45
VDI_PTSINMAX    equ		128
VDI_PTSOUTMAX   equ		128

				OFFSET	0

control:		ds.w	VDI_CNTRLMAX
global:			ds.w	AES_GLOBMAX
intin:			ds.w	VDI_INTINMAX
intout:			ds.w	VDI_INTOUTMAX
ptsout:			ds.w	VDI_PTSOUTMAX
addrin:			ds.l	AES_ADDRINMAX
addrout:		ds.l	AES_ADDROUTMAX
ptsin:			ds.w	VDI_PTSINMAX
_GemParBSize	equ		(*)

				OFFSET	0

vdi_pb:			ds.l	5
vdi_control:	ds.w	VDI_CNTRLMAX
vdi_intin:		ds.w	VDI_INTINMAX
vdi_intout:		ds.w	VDI_INTOUTMAX
vdi_ptsout:		ds.w	VDI_PTSOUTMAX
vdi_ptsin:		ds.w	VDI_PTSINMAX

; offsets of VDI control array
				OFFSET	control
v_opcode:		ds.w	1
v_nptsin:		ds.w	1
v_nptsout:		ds.w	1
v_nintin:		ds.w	1
v_nintout:		ds.w	1
v_opcode2:		ds.w	1
v_handle:		ds.w	1
v_param:		ds.l	4

; offsets of VDI parameter block
				OFFSET	0
v_control:		ds.l	1
v_intin:		ds.l	1
v_ptsin:		ds.l	1
v_intout:		ds.l	1
v_ptsout:		ds.l	1


; offsets of AES control array
				OFFSET	control
a_opcode:		ds.w	1
a_nintin:		ds.w	1
a_nintout:		ds.w	1
a_naddrin:		ds.w	1
a_naddrout:		ds.w	1

; offsets of AES parameter block
				OFFSET	0
a_control:		ds.l	1
a_global:		ds.l	1
a_intin:		ds.l	1
a_intout:		ds.l	1
a_addrin:		ds.l	1
a_addrout:		ds.l	1

	.xref _GemParBlk

			.text
