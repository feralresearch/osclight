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

- (IBAction)saveDocument:(id)sender {
    NSWindow*       window = [_vc.view window];

    // Set the default name for the file and show the panel.
    NSSavePanel*    panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:@"settings.osclightsettings"];
    [panel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL*  theFile = [panel URL];
            
            // Record it all
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_vc.arrayController.arrangedObjects];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"lightPanels"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
            [dict writeToFile:theFile.path atomically:NO];
            
        
        }
    }];
}

-(BOOL)application:(NSApplication *)sender openFile:(NSString *)filename{
    NSLog(@"Open: %@",filename);
    NSMutableDictionary* settings = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
    for(NSString* key in settings){
        [[NSUserDefaults standardUserDefaults] setValue:[settings valueForKey:key] forKey:key];
    }
    [_cc reloadFromSettings];
    return YES;
}

- (IBAction)openDocument:(id)sender {
     NSWindow*       window = [_vc.view window];
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    
    // This method displays the panel and returns immediately.
    // The completion handler is called when the user selects an
    // item or cancels the panel.
    
    [panel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL*  theDoc = [[panel URLs] objectAtIndex:0];
            [self application:[NSApplication sharedApplication] openFile:[theDoc path]];
        }
        
       
        

    }];

    
    
}

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
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



@end
