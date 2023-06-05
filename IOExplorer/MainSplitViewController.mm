//
//  MainSplitViewController.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "MainSplitViewController.hpp"
#import "SummariesViewController.hpp"
#import "DetailViewController.hpp"

@interface MainSplitViewController ()
@property (retain) SummariesViewController *summariesViewController;
@property (retain) DetailViewController *detailViewController;
@end

@implementation MainSplitViewController

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:NSNotificationNameSummariesViewControllerSelectionDidChangeIOObject object:_summariesViewController];
    [_summariesViewController release];
    [_detailViewController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSummariesViewController];
    [self setupDetailViewController];
    [self addObservers];
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

- (void)addObservers {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(summariesViewControllerIOObjectSelectionDidChange:)
                                               name:NSNotificationNameSummariesViewControllerSelectionDidChangeIOObject
                                             object:self.summariesViewController];
}

- (void)summariesViewControllerIOObjectSelectionDidChange:(NSNotification *)notification {
    NSNumber * _Nullable ioObjectNumber = notification.userInfo[SummariesViewControllerIOObjectKey];
    if (ioObjectNumber == nil) return;
    
    io_object_t ioObject = ioObjectNumber.unsignedIntValue;
    [self.detailViewController setIOObject:ioObject];
}

@end
