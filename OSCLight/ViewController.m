//
//  ViewController.m
//  OSCLight
//
//  Created by Andrew on 12/18/15.
//  Copyright © 2015 Digital Scenographic. All rights reserved.
//

#import "ViewController.h"
#import <DSCore/DSCore.h>
#import <VVOSC/VVOSC.h>
#import "AppDelegate.h"
#import "LightPanel.h"
@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    thisAppDelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];
    [thisAppDelegate setVc:self];
    
    NSCollectionViewItem *proto = [self.storyboard instantiateControllerWithIdentifier:@"collectionViewItem"];
    [collectionView setItemPrototype:proto];
    
    statusNone=[NSImage imageNamed:NSImageNameStatusNone];
    statusOK=[NSImage imageNamed:NSImageNameStatusAvailable];
    statusIncoming=[NSImage imageNamed:NSImageNameStatusPartiallyAvailable];
    
    [self oscToggle:nil];
    


}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

// Mute all the lights
- (IBAction)globalBlackout:(NSButton*)sender {
    [self blackoutAll:(sender.state==NSOnState)?YES:NO];
}
- (void)blackoutAll:(BOOL)makeBlack{
    for(LightPanel* panel in collectionView.content){
        if(makeBlack){
            [panel muteOn];
        }else{
            [panel muteOff];
        }
    }
    [_blackoutButton setState:makeBlack?NSOnState:NSOffState];
}

-(void)setChannel:(NSString*)channel
                r:(NSString*)red
                g:(NSString*)green
                b:(NSString*)blue
                w:(NSString*)white{

    for(LightPanel* panel in collectionView.content){
        if([panel.channel isEqualToString:channel]){
        
            if(! [red isEqualToString:@"_"]){
                [panel setLightColor_R:([red floatValue]/255.0)];
             }
            if(! [green isEqualToString:@"_"]){
                [panel setLightColor_G:([green floatValue]/255.0)];
            }
            if(! [blue isEqualToString:@"_"]){
                [panel setLightColor_B:([blue floatValue]/255.0)];
            }
            if(! [white isEqualToString:@"_"]){
                [panel setLightColor_W:([white floatValue]/255.0)];
            }
            
        }
    }


    
}

-(void)cancelOperation:(id)sender{
    [collectionView setSelectionIndexes:[NSIndexSet indexSet]];
}

-(void)deleteBackward:(id)sender{
    if(collectionView.selectionIndexes.firstIndex == NSNotFound){
        return;
    }
    NSInteger selectedIndex = collectionView.selectionIndexes.firstIndex;
    LightPanel* selectedPanel = collectionView.content[selectedIndex];
    [_arrayController removeObject:selectedPanel];
    [collectionView setSelectionIndexes:[NSIndexSet indexSet]];
}
- (IBAction)addPanel:(id)sender {
    LightPanel* newPanel = [[LightPanel alloc] init];
    [_arrayController addObject:newPanel];
    
}




-(void)oscError{
    [self setOscStatus:statusNone];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"oscListen"];
}
-(IBAction)oscToggle:(id)sender {
    
    BOOL senderState;
    if(!sender){
        senderState=[[NSUserDefaults standardUserDefaults] boolForKey:@"oscListen"];
    }else{
        senderState= [sender state]==NSOnState?YES:NO;
    }
    
    NSString *oscPort = [[NSUserDefaults standardUserDefaults] stringForKey:@"oscPort"];
    [self setOscStatus:statusNone];
    
    if([oscPort length] == 0){
        [sender setState:NSOffState];
        [self oscError];
    }
    
    // Turn on
    if(senderState){
        
        _oscManager = [[DSOSCMgr alloc] initWithIP:nil port:nil listenOn:oscPort];
        [_oscManager setDelegate:self];
        [self setOscStatus:statusOK];
        
        if(_oscManager.bindError){
            [self oscError];
        }
        
        // Turn off
    }else{
        [_oscManager shutdown];
        [self oscError];
    }
    
    
    
}

// Incoming OSC message callback
/*

 /osclight/blackout
 /osclight/unblackout
 
 /osclight/1 255 0 255 0 
 /osclight/1 _ 255 _ _
 /osclight/1 255 255
 /osclight/1 black
 
 
 
*/
-(void)receivedOSCMessage:(OSCMessage *)m	{

    // Blink the light
    [self oscBlinkStatus];

    
    // Parse the address, we're looking for /osclight/SOMETHING
    NSArray *parsedAddress = [m.address componentsSeparatedByString: @"/"];
    if([parsedAddress[1] isEqualToString:@"osclight"] && parsedAddress.count == 3){

        NSString* globalCommandOrChannel=parsedAddress[2];

        // Channel
        if([[NSScanner scannerWithString:globalCommandOrChannel] scanInt:nil]){
            NSString* channel = globalCommandOrChannel;
            
            NSString* r = @"_";
            NSString* g = @"_";
            NSString* b = @"_";
            NSString* w = @"_";
            OSCValue* val;
            
            NSArray *valueArray = [NSArray array];
            if(m.valueArray){
                valueArray =m.valueArray;
            }else{
                valueArray = [valueArray arrayByAddingObject:m.value];
            }

            if([valueArray count] >= 1){
                val = valueArray[0];
                if(val.type == OSCValInt){
                    r = [NSString stringWithFormat:@"%i",val.intValue];
                }
            }
            
            if([valueArray count] >= 2){
                val = valueArray[1];
                if(val.type == OSCValInt){
                    g = [NSString stringWithFormat:@"%i",val.intValue];
                }
            }
            
            if([valueArray count] >= 3){
                val = valueArray[2];
                if(val.type == OSCValInt){
                    b = [NSString stringWithFormat:@"%i",val.intValue];
                }
            }

            if([valueArray count] >= 4){
                val = valueArray[3];
                if(val.type == OSCValInt){
                    w = [NSString stringWithFormat:@"%i",val.intValue];
                }
            }

            [self setChannel:channel r:r g:g b:b w:w];

        // Global Blackout
        }else if([globalCommandOrChannel isEqualToString:@"blackout"]){
            [self blackoutAll:YES];
            
        // Global: Un Blackout
        }else if([globalCommandOrChannel isEqualToString:@"unblackout"]){
            [self blackoutAll:NO];
        
        // I have no idea...
        }else{
             NSLog(@"WARNING: Unknown OSC command - %@",m.address);
        }
       
    
    }
    
}

-(void)oscBlinkStatus{
    [self setOscStatus:statusIncoming];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self setOscStatus:statusOK];

    });
}


@end
