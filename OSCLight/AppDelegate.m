//
//  AppDelegate.m
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//
#import "AppDelegate.h"
#import <DSCore/DSCore.h>
#import "ViewController.h"

@class ViewController;
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setDmxMgr:[DSDMXManager sharedInstance]];
}


- (IBAction)newLight:(id)sender {
    [_vc addPanel:sender];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
    // Shutdown DMX
    [_dmxMgr shutDown];
    
    // Store lightPanels
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_vc.arrayController.arrangedObjects];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"lightPanels"];
    
}



@end
