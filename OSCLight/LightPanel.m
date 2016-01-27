//
//  LightPanel.m
//  OSCLight
//
//  Created by Andrew on 1/25/16.
//  Copyright © 2016 Digital Scenographic. All rights reserved.
//

#import "LightPanel.h"
#import <DSCore/DSCore.h>
#include "AppDelegate.h"

@implementation LightPanel

- (id)init {
    
    self = [super init];
    if (self) {
        DSDMXBox* firstBox = [[[DSDMXManager sharedInstance] availableDevices] firstObject];
        _lamp = [[DSDMXLamp alloc] initChannel:1 onBox:firstBox];

    }
    
    return self;
}


-(NSColor*)lightColorW{
    return [NSColor colorWithCalibratedRed:((float)_lamp.white/255)
                                     green:((float)_lamp.white/255)
                                      blue:((float)_lamp.white/255)
                                     alpha:1.0];
}

-(void)setLightColorW:(NSColor *)lightColorW{
    [_lamp setWhite:lightColorW.redComponent*255];
}
-(NSColor*)lightColor{
    return _lightColor;
}
-(void)setLightColor:(NSColor*)color{
    [self willChangeValueForKey:@"lightColor"];
    [self willChangeValueForKey:@"lightColorW"];
    [self willChangeValueForKey:@"lightColor_R"];
    [self willChangeValueForKey:@"lightColor_G"];
    [self willChangeValueForKey:@"lightColor_B"];
    [self willChangeValueForKey:@"lightColor_W"];
    
        _lightColor=color;
        [_lamp setColor:color];
    
    [self didChangeValueForKey:@"lightColor_R"];
    [self didChangeValueForKey:@"lightColor_G"];
    [self didChangeValueForKey:@"lightColor_B"];
    [self didChangeValueForKey:@"lightColor_W"];
    [self didChangeValueForKey:@"lightColorW"];
    [self didChangeValueForKey:@"lightColor"];
}


-(float)lightColor_R{
    return _lightColor.redComponent;
}
-(void)setLightColor_R:(float)val{
    [self setLightColor:[NSColor colorWithCalibratedRed:val
                                                  green:_lightColor.greenComponent
                                                   blue:_lightColor.blueComponent
                                                  alpha:1.0]];
}
-(float)lightColor_G{
    return _lightColor.greenComponent;
}
-(void)setLightColor_G:(float)val{
    [self setLightColor:[NSColor colorWithCalibratedRed:_lightColor.redComponent
                                                  green:val
                                                   blue:_lightColor.blueComponent
                                                  alpha:1.0]];
    
}
-(float)lightColor_B{
    return _lightColor.blueComponent;
}
-(void)setLightColor_B:(float)val{
    [self setLightColor:[NSColor colorWithCalibratedRed:_lightColor.redComponent
                                                  green:_lightColor.greenComponent
                                                   blue:val
                                                  alpha:1.0]];
    
}
-(float)lightColor_W{
    return ((float)_lamp.white/255);

    
}
-(void)setLightColor_W:(float)val{
    
    if(!_lightColor){
        _lightColor=[[NSColor blackColor] colorUsingColorSpace:[NSColorSpace genericRGBColorSpace]];
    }
    [self willChangeValueForKey:@"lightColorW"];
        [_lamp setR:(_lightColor.redComponent*255)
                                 G:(_lightColor.greenComponent*255)
                                 B:(_lightColor.blueComponent*255)
                                 W:(val*255)];
    [self setLightColorW:[NSColor colorWithCalibratedRed:val green:val blue:val alpha:1.0]];
    [self didChangeValueForKey:@"lightColorW"];
}



-(BOOL)autoWhite{
    return _lamp.autoWhite;
}
-(void)setAutoWhite:(BOOL)autoWhiteVal{
    [self setLightColor_W:0];
    [_lamp setAutoWhite:autoWhiteVal];
    [self setLightColor:_lightColor];
}


- (void)resetLight:(id)sender {
    [self setLightColor:[[NSColor blackColor] colorUsingColorSpace:[NSColorSpace genericRGBColorSpace]]];
    [self setLightColor_W:0];
}

-(void)mute{
    if(_isMute){
        [self muteOn];
    }else{
        [self muteOff];
    }
}
-(void)muteOff{
    [self setLightColor:previousColor];
    [self setIsMute:NO];
}

-(void)muteOn{
    previousColor=_lightColor;
    [self resetLight:self];
    [self setIsMute:YES];
}



-(void) encodeWithCoder: (NSCoder *)coder{
    [coder encodeObject:_channel forKey:@"channel"];
    [coder encodeBool:_lamp.autoWhite forKey:@"autowhite"];
    
    [coder encodeFloat:_lightColor.redComponent forKey:@"lightcolor_r"];
    [coder encodeFloat:_lightColor.greenComponent forKey:@"lightcolor_g"];
    [coder encodeFloat:_lightColor.blueComponent forKey:@"lightcolor_b"];
    
    [coder encodeFloat:_lightColorW.redComponent forKey:@"lightcolor_w"];

    
}


- (id)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        
        
        _channel = [coder decodeObjectForKey:@"channel"];
        
        float r =[coder decodeFloatForKey:@"lightcolor_r"];
        
        _lightColor = [NSColor colorWithCalibratedRed:[coder decodeFloatForKey:@"lightcolor_r"]
                                                green:[coder decodeFloatForKey:@"lightcolor_g"]
                                                 blue:[coder decodeFloatForKey:@"lightcolor_b"]
                                                alpha:1.0];

        _lightColorW = [NSColor colorWithCalibratedRed:[coder decodeFloatForKey:@"lightcolor_w"]
                                                green:[coder decodeFloatForKey:@"lightcolor_w"]
                                                 blue:[coder decodeFloatForKey:@"lightcolor_w"]
                                                alpha:1.0];
        
        
        DSDMXBox* firstBox = [[[DSDMXManager sharedInstance] availableDevices] firstObject];
        _lamp = [[DSDMXLamp alloc] initChannel:(int)[_channel integerValue] onBox:firstBox];
        [_lamp setAutoWhite:[coder decodeBoolForKey:@"autowhite"]];
        
        
        
    }
    return self;
}
@end
