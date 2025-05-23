/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"

#include "xparameters.h"
#include "xgpio.h"

void uint8_to_hexstr(uint8_t byte, char* out) {
    const char hex_chars[] = "0123456789ABCDEF";
    out[0] = '0';
    out[1] = 'x';
    out[2] = hex_chars[(byte >> 4) & 0x0F];  // High nibble
    out[3] = hex_chars[byte & 0x0F];         // Low nibble
    out[4] = '\0';                           // Null terminator
}

int main()
{
    init_platform();
    print("Test for Bendlab sensors hdl data read\n\r");
    //    print("Successfully ran Hello World application");
    XGpio bl_rx_0, bl_rx_1, bl_rx_2, bl_rx_3, bl_rx_4;
    XGpio_Initialize(&bl_rx_0, XPAR_AXI_GPIO_BL_0_DEVICE_ID);
    XGpio_SetDataDirection(&bl_rx_0, 1, 0xffffffff);

    XGpio_Initialize(&bl_rx_1, XPAR_AXI_GPIO_BL_1_DEVICE_ID);
    XGpio_SetDataDirection(&bl_rx_1, 1, 0xffffffff);

    XGpio_Initialize(&bl_rx_2, XPAR_AXI_GPIO_BL_2_DEVICE_ID);
    XGpio_SetDataDirection(&bl_rx_2, 1, 0xffffffff);

    XGpio_Initialize(&bl_rx_3, XPAR_AXI_GPIO_BL_3_DEVICE_ID);
    XGpio_SetDataDirection(&bl_rx_3, 1, 0xffffffff);

    XGpio_Initialize(&bl_rx_4, XPAR_AXI_GPIO_BL_4_DEVICE_ID);
    XGpio_SetDataDirection(&bl_rx_4, 1, 0xffffffff);


    print("Five GPIO for Bendlab Sensor Setup Success\n\r");




//    uint32_t value;
//    uint8_t byte0, byte1, byte2;
//    char byte0_str[5];
//    char byte1_str[5];
//    char byte2_str[5];
//
//    while(1) {
//    	value = XGpio_DiscreteRead(&bl_rx, 1);
//
//
//    	byte0 = (value >> 0) & 0xFF;   // Least significant byte
//    	byte1 = (value >> 8) & 0xFF;
//    	byte2 = (value >> 16) & 0xFF;
//
//    	uint8_to_hexstr(byte0, byte0_str);
//    	uint8_to_hexstr(byte1, byte1_str);
//    	uint8_to_hexstr(byte2, byte2_str);
//
//
//    	print("Byte 0 is ");
//    	print(byte0_str);
//    	print("\t");
//    	print("Byte 1 is ");
//    	print(byte1_str);
//    	print("\t");
//    	print("Byte 2 is ");
//    	print(byte2_str);
//    	print("\t");
//    	print("\n\r");
//    	usleep(10000);
//    }
    uint32_t value0, value1, value2, value3, value4;
    while(1){
    	value0 = XGpio_DiscreteRead(&bl_rx_0, 1);
    	value1 = XGpio_DiscreteRead(&bl_rx_1, 1);
    	value2 = XGpio_DiscreteRead(&bl_rx_2, 1);
    	value3 = XGpio_DiscreteRead(&bl_rx_3, 1);
    	value4 = XGpio_DiscreteRead(&bl_rx_4, 1);
    	xil_printf("Sensor 0: %08x \t Sensor 1: %08x \t Sensor 2: %08x \t Sensor 3: %08x \t Sensor 4: %08x \t \n\r", value0, value1, value2, value3, value4);
    }

    cleanup_platform(); // Delay for 10 milliseconds
    return 0;
}
