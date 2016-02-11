//
//  AppDelegate.h
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CollectionController.h"
@class DSDMXManager;
@class DSDMXLamp;
@class ViewController;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    
    
    NSColor* _lightColor;
    
}
@property CollectionController* cc;
@property ViewController* vc;
@property DSDMXManager* dmxMgr;
@property DSDMXLamp* lamp;


@end

