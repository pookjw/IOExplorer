//
//  DetailViewController.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "DetailViewController.hpp"
#import "DetailViewModel.hpp"
#import <memory>

@interface DetailViewController ()
@property (retain) NSScrollView *scrollView;
@property (retain) NSCollectionView *collectionView;
@property (assign) std::shared_ptr<DetailViewModel> viewModel;
@end

@implementation DetailViewController

- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setupViewModel];
    }
    
    return self;
}

- (void)dealloc {
    [_scrollView release];
    [_collectionView release];
    [super dealloc];
}

- (void)setIOObject:(io_object_t)ioObject {
    self.viewModel.get()->setIOObject(ioObject);
}

- (void)loadView {
    NSView *view = [NSView new];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupCollectionView];
}

- (void)setupViewModel {
    std::shared_ptr<DetailViewModel> viewModel = std::make_shared<DetailViewModel>();
    self.viewModel = viewModel;
}

- (void)setupScrollView {
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.drawsBackground = NO;
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView release];
}

- (void)setupCollectionView {
    NSCollectionView *collectionView = [NSCollectionView new];
    
    self.collectionView = collectionView;
    [collectionView release];
}

@end
