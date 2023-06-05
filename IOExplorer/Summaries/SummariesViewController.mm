//
//  SummariesViewController.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummariesViewController.hpp"
#import "SummariesViewModel.hpp"
#import "SummaryNodeObject.hpp"
#import "SummaryTableCellView.hpp"
#import <memory>

#define kSummariesViewControllerTableColumnIdentifier @""

@interface SummariesViewController () <NSOutlineViewDelegate, NSOutlineViewDataSource>
@property (retain) NSScrollView *scrollView;
@property (retain) NSOutlineView *outlineView;
@property (assign) std::shared_ptr<SummariesViewModel> viewModel;
@end

@implementation SummariesViewController

- (void)dealloc {
    [_scrollView release];
    [_outlineView release];
    [super dealloc];
}

- (void)loadView {
    NSView *view = [NSView new];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupOutlineView];
    [self setupViewModel];
    self.viewModel.get()->loadDataSource();
}

- (void)setupScrollView {
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.drawsBackground = NO;
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView release];
}

- (void)setupOutlineView {
    NSOutlineView *outlineView = [NSOutlineView new];
    outlineView.delegate = self;
    outlineView.style = NSTableViewStyleSourceList;
    outlineView.headerView = nil;
    
    NSTableColumn *tableColumn = [[NSTableColumn alloc] initWithIdentifier:kSummariesViewControllerTableColumnIdentifier];
    tableColumn.title = @"Test";
    [outlineView addTableColumn:tableColumn];
    [tableColumn release];
    
    NSNib *summaryTableCellViewNib = [[NSNib alloc] initWithNibNamed:NSStringFromClass(SummaryTableCellView.class) bundle:NSBundle.mainBundle];
    [outlineView registerNib:summaryTableCellViewNib forIdentifier:@"SummaryTableCellView"];
    [summaryTableCellViewNib release];
    
    self.scrollView.documentView = outlineView;
    self.outlineView = outlineView;
    [outlineView release];
}

- (void)setupViewModel {
    std::shared_ptr<SummariesViewModel> viewModel = std::make_shared<SummariesViewModel>();
    NSTreeController *treeController = viewModel.get()->treeController();
    
    [self.outlineView bind:NSContentBinding toObject:treeController withKeyPath:@"arrangedObjects" options:nil];
    [self.outlineView bind:NSSelectionIndexPathsBinding toObject:treeController withKeyPath:NSSelectionIndexPathsBinding options:nil];
    [self.outlineView bind:NSSortDescriptorsBinding toObject:treeController withKeyPath:NSSortDescriptorsBinding options:nil];
    
    self.outlineView.dataSource = self;
    
    self.viewModel = viewModel;
}

#pragma mark - NSOutlineViewDelegate

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    SummaryTableCellView *view = [outlineView makeViewWithIdentifier:@"SummaryTableCellView" owner:nil];
    NSTreeNode *treeNode = (NSTreeNode *)item;
    SummaryNodeObject *representedObject = [treeNode representedObject];
    
    view.imageView.image = [NSImage imageWithSystemSymbolName:representedObject.systemImageName accessibilityDescription:nil];
    view.textField.stringValue = representedObject.title;
    
    return view;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    SummaryNodeObject * _Nullable selectedNodeObject = self.viewModel.get()->treeController().selectedObjects.firstObject;
    
    NSNumber * __autoreleasing ioObject;
    if (selectedNodeObject) {
        ioObject = @(selectedNodeObject.summaryNodeRef.get()->ioObject());
    } else {
        ioObject = @(IO_OBJECT_NULL);
    }
    
    [NSNotificationCenter.defaultCenter postNotificationName:NSNotificationNameSummariesViewControllerSelectionDidChangeIOObject
                                                      object:self
                                                    userInfo:@{SummariesViewControllerIOObjectKey: ioObject}];
}

#pragma mark - NSOutlineViewDataSource

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    // NSTreeControllerTreeNode
    NSTreeNode *treeNode = (NSTreeNode *)item;
    SummaryNodeObject *representedObject = [treeNode representedObject];
    return representedObject;
}

@end
