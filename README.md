# **Integer Square Root for 256-bit Integer Data**

## **Overview**
This document describes the computation of the integer square root for 256-bit integer data. The implementation processes input packets and generates corresponding output packets.

## **Applications**
The integer square root computation supports the following:
- **Integer square root** for a 256-bit integer.

## **Packet Format**

### **Input Packet Format**
![Image](https://github.com/user-attachments/assets/18a8ccdd-8918-4eed-a10e-be71639d8c7b)
- **4-Bit Header:** 3-Bit (packet number), 1-Bit (last packet flag)
- **44-Bit Data:** Integer Data

### **Output Packet Format**
![Image](https://github.com/user-attachments/assets/eaaa0a78-bb0d-46a2-9722-1ab54d291e5f)
- **4-Bit Header:** 3-Bit (packet number), 1-Bit (vout for value or rout for remainder)
- **44-Bit Data:** Vout or Rout data

## **Example**
### **Input Packets**

input for square root of integer 10 

```sh
Input  packet1: 20 00 00 00 00 00
Input  packet2: 40 00 00 00 00 00
Input  packet3: 60 00 00 00 00 00
Input  packet4: 80 00 00 00 00 00
Input  packet5: A0 00 00 00 00 00
Input  packet6: D0 00 00 00 0A 00
```
- The first 4 bits indicate the packet number and last packet flag.
- In the last packet, the last byte is reserved with 0.
- In the first packet, the first byte is `20`, which is `0010_0000` in binary. The first 3 bits represent packet number `1`, and the 4th bit is the last packet indicator (low in this case). The remaining bits contain data.
- In the last packet, the first byte is `D0`, which is `1101_0000` in binary. The first 3 bits represent packet number `6`, and the 4th bit is high, indicating it is the last packet.
- In the last packet, the last byte is reserved with `0` due to extra space.

### **Output Packets**
```sh
Output packet1:  20 00 00 00 00 00
Output packet2:  40 00 00 00 00 00
Output packet3:  60 00 00 00 00 30  
Output packet4:  90 00 00 00 00 00
Output packet5:  B0 00 00 00 00 00
Output packet6:  D0 00 00 00 00 08
```
- The first 4 bits indicate the packet number and whether it contains vout or rout data.
- The first 3 packets correspond to the value output (`vout`).
- In the first packet, the first byte is `20`, which is `0010_0000` in binary. The first 3 bits represent packet number `1`, and the 4th bit is indicating vout data (low in this case). The remaining bits contain data.
-In the first packet, the first byte is `90`, which is `1001_0000` in binary. The first 3 bits represent packet number `4`, and the 4th bit is indicating rout data (high in this case). The remaining bits contain data.
- The last 3 packets correspond to the remainder output (`rout`).
- In packet 3, the last 4 bits are reserved with `0`.
- In packet 6, the last 3 bits are reserved with `0`.


