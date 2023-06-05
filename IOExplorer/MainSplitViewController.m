//
//  MainSplitViewController.m
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "MainSplitViewController.h"
#import "SummariesViewController.h"
#import "DetailViewController.h"

@interface MainSplitViewController ()
@property (retain) SummariesViewController *summariesViewController;
@property (retain) DetailViewController *detailViewController;
@end

@implementation MainSplitViewController

- (void)dealloc {
    [_summariesViewController release];
    [_detailViewController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSummariesViewController];
    [self setupDetailViewController];
}

- (void)setupSummariesViewController {
    SummariesViewController *summariesViewController = [SummariesViewController new];
    NSSplitViewItem *splitViewItem = [NSSplitViewItem sidebarWithViewController:summariesViewController];
    [self addSplitViewItem:splitViewItem];
    self.summariesViewController = summariesViewController;
    [summariesViewController release];
}

- (void)setupDetailViewController {
    DetailViewController *detailViewController = [DetailViewController new];
    NSSplitViewItem *splitViewItem = [NSSplitViewItem contentListWithViewController:detailViewController];
    [self addSplitViewItem:splitViewItem];
    self.detailViewController = detailViewController;
    [detailViewController release];
}

@end
