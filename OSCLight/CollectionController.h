//
//  CollectionController.h
//  OSCLight
//
//  Created by Andrew on 1/25/16.
//  Copyright © 2016 Digital Scenographic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class LightPanel;
@interface CollectionController : NSObject{
    IBOutlet NSArrayController* arrayController;
}

@property NSMutableArray* lightPanels;

@end
