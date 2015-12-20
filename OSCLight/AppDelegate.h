//
//  AppDelegate.h
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DSDMXManager;
@class DSDMXLamp;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    
    
    NSColor* _lightColor;
    
}

@property DSDMXManager* dmxMgr;
@property DSDMXLamp* lamp;


@end

