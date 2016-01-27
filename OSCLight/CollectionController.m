//
//  CollectionController.m
//  OSCLight
//
//  Created by Andrew on 1/25/16.
//  Copyright © 2016 Digital Scenographic. All rights reserved.
//

#import "CollectionController.h"
#import "LightPanel.h"
@implementation CollectionController



-(void)awakeFromNib{
    _lightPanels = [[NSMutableArray alloc] init];

    // Load stored panels
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"lightPanels"];
    NSArray *lightPanelArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    for(LightPanel *panel in lightPanelArray){
        [arrayController addObject:panel];
    }
}


@end
