//
//  AppDelegate.m
//  ErgoTyper
//
//  Created by Sebastian Ludwig on 12.03.13.
//  Copyright (c) 2013 Sebastian Ludwig. All rights reserved.
//

#import "AppDelegate.h"

#define LEFT -1
#define RIGHT 1

#define LEFT_SHIFT 131330
#define LEFT_CONTROL 262401
#define LEFT_OPTION 524576
#define FUNCTION_KEY 8388864
#define LEFT_COMMAND 1048840

#define RIGHT_SHIFT 131332
#define RIGHT_OPTION 524608
#define RIGHT_COMMAND 1048848


@implementation AppDelegate
{
	NSStatusItem* statusItem;
	
	id eventMonitor;
	int keys[128];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// left
	keys[0] = LEFT;
	keys[1] = LEFT;
	keys[2] = LEFT;
	keys[3] = LEFT;
	keys[5] = LEFT;
	keys[6] = LEFT;
	keys[7] = LEFT;
	keys[8] = LEFT;
	keys[9] = LEFT;
	keys[10] = LEFT;
	keys[12] = LEFT;
	keys[13] = LEFT;
	keys[14] = LEFT;
	keys[15] = LEFT;
	keys[17] = LEFT;
	keys[18] = LEFT;
	keys[19] = LEFT;
	keys[20] = LEFT;
	keys[21] = LEFT;
	keys[22] = LEFT;
	keys[23] = LEFT;
	keys[50] = LEFT;
	
	
	// right
	keys[4] = RIGHT;
	// keys[11] = RIGHT; // B is all right for both hands
	keys[16] = RIGHT;
	keys[24] = RIGHT;
	keys[25] = RIGHT;
	keys[26] = RIGHT;
	keys[27] = RIGHT;
	keys[28] = RIGHT;
	keys[29] = RIGHT;
	keys[30] = RIGHT;
	keys[31] = RIGHT;
	keys[32] = RIGHT;
	keys[33] = RIGHT;
	keys[34] = RIGHT;
	keys[35] = RIGHT;
	keys[36] = RIGHT;
	keys[37] = RIGHT;
	keys[38] = RIGHT;
	keys[39] = RIGHT;
	keys[40] = RIGHT;
	keys[41] = RIGHT;
	keys[42] = RIGHT;
	keys[43] = RIGHT;
	keys[44] = RIGHT;
	keys[45] = RIGHT;
	keys[46] = RIGHT;
	keys[47] = RIGHT;
	keys[51] = RIGHT;
	keys[123] = RIGHT;
	keys[124] = RIGHT;
	keys[125] = RIGHT;
	keys[126] = RIGHT;
	
	// Insert code here to initialize your application
	eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *event) {
		if ([self isLeftHandModifierKey:event.modifierFlags] && keys[event.keyCode] == LEFT) {
			[self flashScreen:20];
		}
		
		if ([self isRightHandModifierKey:event.modifierFlags] && keys[event.keyCode] == RIGHT) {
			[self flashScreen:20];
		}
	}];
	
	self.window.styleMask = NSBorderlessWindowMask;
	self.window.level = NSScreenSaverWindowLevel - 1;
	self.window.hasShadow = NO;
	self.window.animationBehavior = NSWindowAnimationBehaviorNone;
	self.window.backgroundColor = [NSColor redColor];
	
	NSStatusBar *bar = [NSStatusBar systemStatusBar];
	
    statusItem = [bar statusItemWithLength:NSVariableStatusItemLength];
	
    [statusItem setTitle:@"ET"];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:self.menu];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	[NSEvent removeMonitor:eventMonitor];
}

#pragma mark Actions

- (void)openFrontPreferencesWindow
{
//	NSWindow* preferences = [NSWindow ]
}

#pragma mark private methods

- (void)flashScreen:(CGFloat)duration
{
	NSScreen* screen = [[NSScreen screens] objectAtIndex:0];
	[self.window setFrame:screen.frame display:YES];
	[self.window orderFront:nil];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_MSEC), dispatch_get_current_queue(), ^{
		[self.window orderOut:nil];
	});
}

- (BOOL)isLeftHandModifierKey:(NSUInteger)modifier
{
	return ((modifier & LEFT_SHIFT) == LEFT_SHIFT
			|| (modifier & LEFT_CONTROL) == LEFT_CONTROL
			|| (modifier & LEFT_OPTION) == LEFT_OPTION
			// || (modifier & LEFT_COMMAND) == LEFT_COMMAND		// left command hotkeys are too common
			|| (modifier & FUNCTION_KEY) == FUNCTION_KEY);
}

- (BOOL)isRightHandModifierKey:(NSUInteger)modifier
{
	return ((modifier & RIGHT_SHIFT) == RIGHT_SHIFT
			|| (modifier & RIGHT_OPTION) == RIGHT_OPTION
			|| (modifier & RIGHT_COMMAND) == RIGHT_COMMAND);
}




@end
