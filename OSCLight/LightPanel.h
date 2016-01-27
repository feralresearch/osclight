//
//  LightPanel.h
//  OSCLight
//
//  Created by Andrew on 1/25/16.
//  Copyright © 2016 Digital Scenographic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class AppDelegate;
@class DSDMXLamp;

@interface LightPanel : NSObject{
    NSColor* _lightColor;
    NSColor* _lightColorW;
    NSColor* previousColor;
}

@property BOOL isMute;
@property NSString* channel;
@property DSDMXLamp* lamp;

-(NSColor*)lightColor;
-(void)setLightColor:(NSColor*)color;


-(float)lightColor_R;
-(void)setLightColor_R:(float)val;
-(float)lightColor_G;
-(void)setLightColor_G:(float)val;
-(float)lightColor_B;
-(void)setLightColor_B:(float)val;
-(float)lightColor_W;
-(void)setLightColor_W:(float)val;


-(void)mute;
-(void)muteOn;
-(void)muteOff;
-(BOOL)autoWhite;
-(void)setAutoWhite:(BOOL)autoWhiteVal;

@end
