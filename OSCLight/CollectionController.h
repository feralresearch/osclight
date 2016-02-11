//
//  CollectionController.h
//  OSCLight
//
//  Created by Andrew on 1/25/16.
//  Copyright © 2016 Digital Scenographic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class AppDelegate;
@class LightPanel;
@interface CollectionController : NSObject{
    IBOutlet NSArrayController* arrayController;
    AppDelegate* thisAppDelegate;
}

@property NSMutableArray* lightPanels;


-(void)reloadFromSettings;

@end
