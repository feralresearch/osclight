//
//  CollectionController.m
//  OSCLight
//
//  Created by Andrew on 1/25/16.
//  Copyright © 2016 Digital Scenographic. All rights reserved.
//

#import "CollectionController.h"
#import "LightPanel.h"
#import <DSCore/DSCore.h>
#import "AppDelegate.h"
@implementation CollectionController




-(void)awakeFromNib{
    [self reloadFromSettings];
     thisAppDelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];
    [thisAppDelegate setCc:self];
}

-(void)reloadFromSettings{
    if([arrayController.arrangedObjects count]>0){
        [arrayController removeObjects:arrayController.arrangedObjects];
    }
    _lightPanels = [[NSMutableArray alloc] init];
    
    // Load stored panels
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"lightPanels"];
    NSArray *lightPanelArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // Unpack the archived array into the array controller and init
    for(LightPanel *panel in lightPanelArray){
        [arrayController addObject:panel];
        
        // On load, set lights to their own color (inits the lamps basically)
        [panel setLightColor:panel.lightColor];
    }
    [arrayController rearrangeObjects];
}


@end
