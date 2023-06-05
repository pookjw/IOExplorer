//
//  main.m
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/4/23.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    AppDelegate *delegate = [AppDelegate new];
    NSApplication.sharedApplication.delegate = delegate;
    [delegate release];
    [NSApplication.sharedApplication run];
    return NSApplicationMain(argc, argv);
}
