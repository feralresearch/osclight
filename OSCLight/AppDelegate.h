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
@class ViewController;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    
    
    NSColor* _lightColor;
    
}
@property ViewController* vc;
@property DSDMXManager* dmxMgr;
@property DSDMXLamp* lamp;


@end

