//
//  AppDelegate.m
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//

#import "AppDelegate.h"
#import "DSDMXManager.h"
#import "DSDMXLamp.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [self setDmxMgr:[DSDMXManager sharedInstance]];
    DSDMXBox* firstBox = [[_dmxMgr availableDevices] firstObject];
    
     _lamp = [[DSDMXLamp alloc] initChannel:1 onBox:firstBox];
    
    /*
    if(firstBox){
         _lamp = [[DSDMXLamp alloc] initChannel:1 onBox:firstBox];
        
        
        [_lamp setR:64 G:0 B:0 W:0];
        
        float delay=1*NSEC_PER_SEC;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{
            [_lamp setR:0 G:64 B:0 W:0];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{
                [_lamp setR:0 G:0 B:64 W:0];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{
                    [_lamp setR:0 G:0 B:0 W:64];
                });
                
            });
        });
        
    }
     */

}




/*
-(void)deletethis{
    
    
    // declare all needed variables
    uint8_t Num_Devices =0;
    uint16_t device_connected =0;
    uint32_t length =dmxMgr.DMX_DATA_LENGTH;
    int device_num=0;
    BOOL res = 0;
    
    // startup message for example
    printf("\nEnttec Pro - C - Windows - FTDI Test\n");
    printf("\nLooking for a PRO's connected to PC ... ");
    Num_Devices = [dmxMgr FTDI_ListDevices];
    
    // Number of Found Devices
    if (Num_Devices == 0){
        printf("\n Looking for Devices  - 0 Found");
    }else{
        printf("\n Looking for Devices  - %d Found",Num_Devices);
        // Just to make sure the Device is correct
        printf("\n Press Enter to Intialize 1st Device :");
        // we'll open the first one only
        device_num = 0;
        device_connected = [dmxMgr FTDI_OpenDevice:device_num];
        
        // If you want to open all; use for loop ; uncomment the folllowing
         for (i=0;i<Num_Devices;i++)
         {
         if (device_connected)
         break;
         device_num = i;
         device_connected = FTDI_OpenDevice(device_num);
         }
        
        // Send DMX Code
        if (device_connected){
            unsigned char myDmx[dmxMgr.DMX_DATA_LENGTH];
            printf("\n Press Enter to Send DMX data :");
            
            // Looping to Send DMX data
            for (int i = 0; i < 1000 ; i++){
                // initialize with data to send
                memset(myDmx,i,dmxMgr.DMX_DATA_LENGTH);
                // Start Code = 0
                myDmx[0] = 0;
                // actual send function called
                res = [dmxMgr FTDI_SendData:SET_DMX_TX_MODE data:myDmx length:dmxMgr.DMX_DATA_LENGTH];
                // check response from Send function
                if (res < 0)
                {
                    printf("FAILED: Sending DMX to PRO \n");
                    [dmxMgr FTDI_ClosePort];
                    break;
                }
                // output debug
                printf("Iteration: %d\n", i);
                printf("DMX Data SENT from 0 to 10: ");
                for (int j = 0; j <= 8; j++)
                    printf (" %d ",myDmx[j]);
            }
        }
        
        // DMX Receive Code in a loop
        if (device_connected)
        {
            unsigned char myDmxIn[dmxMgr.DMX_DATA_LENGTH];
            // Looping to receiving DMX data
            printf("\n Press Enter to receive DMX data :");
            for (int i = 0; i < 1000 ; i++)
            {
                // re-initailize before each read
                memset(myDmxIn,0,dmxMgr.DMX_DATA_LENGTH);
                // actual recieve function called
                res = [dmxMgr FTDI_RxDMX:SET_DMX_RX_MODE data:myDmxIn expected_length:&length];
                // check response from Receive function
                if (res < 0){
                    printf("FAILED: Reading DMX from PRO \n");
                    [dmxMgr FTDI_ClosePort];
                    break;
                }
                // output debug
                printf("Length Recieved: %d\n", length);
                printf("DMX Data from 0 to 10: ");
                for (int j = 0; j <= 20; j++)
                    printf (" %d",myDmxIn[j]);
            }
        }
    }
}
*/

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [_dmxMgr shutDown];
}



@end
