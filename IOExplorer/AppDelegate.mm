//
//  AppDelegate.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/4/23.
//

#import "AppDelegate.hpp"
#import "MainSplitViewController.hpp"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (void)dealloc {
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    MainSplitViewController *contentViewController = [MainSplitViewController new];
    NSWindow *window = [NSWindow new];
    window.styleMask = NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskFullSizeContentView | NSWindowStyleMaskResizable | NSWindowStyleMaskTitled;
    window.movableByWindowBackground = YES;
    window.title = NSProcessInfo.processInfo.processName;
    window.releasedWhenClosed = NO;
    window.titlebarAppearsTransparent = YES;
    window.minSize = window.contentMinSize;
    window.contentViewController = contentViewController;
    [contentViewController release];
    [window makeKeyAndOrderFront:nil];
    [window release];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

@end
