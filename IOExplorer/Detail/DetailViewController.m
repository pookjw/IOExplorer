//
//  DetailViewController.m
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)loadView {
    NSView *view = [NSView new];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.purpleColor.CGColor;
}

@end
