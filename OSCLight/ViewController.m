//
//  ViewController.m
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DSDMXLamp.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(NSColor*)lightColor{
    return _lightColor;
}
-(void)setLightColor:(NSColor*)color{
    [self willChangeValueForKey:@"lightColor"];
    
    _lightColor=color;
    
    AppDelegate* thisAppDelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];

    [thisAppDelegate.lamp setNSColor:color];
    [self didChangeValueForKey:@"lightColor"];
}

@end
