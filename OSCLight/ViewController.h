//
//  ViewController.h
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <DSCore/DSCore.h>
@class DSOSCMgr;
@class AppDelegate;
@interface ViewController : NSViewController <DSOSCMgrDelegate>{
    NSColor* _lightColor;
    AppDelegate* thisAppDelegate;
    IBOutlet NSCollectionView *collectionView;
    
    NSImage* statusNone;
    NSImage* statusIncoming;
    NSImage* statusOK;
}
@property IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet NSButton *blackoutButton;
- (IBAction)addPanel:(id)sender;

@property (readonly) DSOSCMgr* oscManager;
@property NSImage *oscStatus;

@end

