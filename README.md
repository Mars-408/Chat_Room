## 使用X86-64汇编语言实现UDP程序
### 运行方法：
```
nasm -f elf64 UDP.asm -o main.o
gcc main.o 
./a.out
```

### 实现细节
* 汇编环境：X86-64汇编
* 系统调用：

| %rax | System call | %rdi            | %rsi       | %rdx         | %r10           | %r8                   | %r9          |
| ---- | ----------- | --------------- | ---------- | ------------ | -------------- | --------------------- | ------------ |
| 3    | sys_close   | unsigned int fd |            |              |                |                       |              |
| 41   | sys_socket  | int family      | int type   | int protocol |                |                       |              |
| 44   | sys_sendto  | int fd          | void *buff | size_t len   | unsigned flags | struct sockaddr *addr | int addr_len |