//
//  ViewController.h
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController{
    NSColor* _lightColor;
}

-(NSColor*)lightColor;
-(void)setLightColor:(NSColor*)color;


@end

