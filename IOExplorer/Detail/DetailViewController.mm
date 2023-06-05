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
    [super dealloc];
}

- (io_object_t)ioObject {
    return self.viewModel.get()->ioObject();
}

- (void)setIoObject:(io_object_t)ioObject {
    self.viewModel.get()->setIOObject(ioObject);
}

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

- (void)setupViewModel {
    std::shared_ptr<DetailViewModel> viewModel = std::make_shared<DetailViewModel>();
    self.viewModel = viewModel;
}

@end
