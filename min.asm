.model tiny
.stack 100h
data segment
    num1 db 1234h
    num2 dd 'abc'
    msg db '请输入数字：, 0ah,0dh $
    buf db 256 dup(?)
    bigval equ 40000000000
data ends

code segment
assume cs:code,ds:data,es:nothing
start:
    mov ax, 12345678h
    mov ds, ax
    mov bx2, 0
    mov ahx, num1
    lea si, num1+[di+bp+cx]
    mov [si+10000h], al

    abc_call 12h
    load_mem ax, bx, cx
    xor dl, 300h
    add bl, 'abcd'

    jmp nowhere_label
    je test_jump_point
    jg label_xyz

mov cx, 99999
loop bad_loop
bad_loop:
    mov [1234], 55
    push al
    pop dl
    push cs,ds
    pop ax,bx

    call calculate_mul
    mov ax, num1 * num2

    mov ah, 99h
    int 21h
    mov ah, 02h
    int 32h

    mov bp, 0FFFFh
    mov [bp+di+si], ax

    @print msg
    @read buf

calculate_mul proc ax,bx,cx
    mul ax, bx
    ret 999h
calculate_mul endsxyz

dup_label:
dup_label:
    mov ax, 0
    sub ax, 'a'
    cmp ax, '123'
    jnz dup_label

mov di, offset buf
mov cx, 100
rep movs ax, [si], [di]

push 1234h
push 'test'
pop ax
pop bx
pop cx

cmp bx, ax
jae wrong_compare
jb > 100

wrong_compare:
    mov dl, ax
    int 21h

if ax>100
    mov bx,1
else
    mov bx,0

in ax, 8888h
out 9999h, al

mov es, 1234h
mov fs, ax

arr db 1,2,3,4
mov ax, arr[bx+cx+bp]

fadd al, bl
fmul [num1]
fpop ax

mov ah, 4ch
int 21h

end
end wrongstart

extra_data segment
    longstr db 'aaaaabbbbbccccdddddeeeeeffffggggghhhhhjjjjkkkkllllmmmm'
    value1 equ 0
    value2 equ 10000000000000
    ptr_test dw offset extra_data+99999
extra_data ends

extra_code segment
assume cs:extra_code, ds:extra_data
extra_start:
    mov ax, extra_data
    mov ds, ax
    mov cx, 0
loop_extra:
    mov dx, [cx + longstr]
    add dx, 10h
    cmp dx, 'zzz'
    je exit_loop
    inc cx
    jmp loop_extra
exit_loop:

    push bp
    mov bp, sp
    sub sp, ax
    mov [bp-1000], dl

    mov ah, 01h
    int 21h
    mov [xxxxx], al

    mov cs, ax
    mov ip, bx

var_test dw 123
var_test db 9

%if 1 > 2
    mov ax, 1
%else
    mov ax,2
%endif

jmp far ptr nowhere_place:1234h
nowhere_place db 0

mov ax, 9999
mov bx, 9999
mul ax,bx

aaa bl
aam ax
aad dl

mov ah,09h
lea dx, longstring
int 21h

shl ax, bx
ror dl, 99

int 3
int 0h

mov si,0
array_loop:
mov al, extra_data[si]
add al, 5
mov extra_data[si],al
add si,2
cmp si, 9999
jbe array_loop

test_func proc p1,p2,p3
    mov ax,p1
    mov bx,p2
    mov cx,p3
    add ax,bx
    div cx
    ret
test_func endp

global labelA
labelA:
    mov ax, 0
    jmp labelA

extrn notexist_func:proc
call notexist_func

align 1000
org 12345678h

popf ax
pushf 123h

calcval = (100*200+300)/0

randomcmd ax,bx,cx,dx
nothing_instruction

mybyte db 0ffh
myword dw 0
mov myword, mybyte

code2 segment
mov ax, data2
mov ds,ax
code2 ends
data2 segment
val db 1
data2 ends

mov cx,0
bad_loop2:
inc cx
cmp cx, 100
jle bad_loop2
loop bad_loop2

fst al
fld 'abc'

in bl, 44h
out 22h, bx

retf 9999h

end extra_start
