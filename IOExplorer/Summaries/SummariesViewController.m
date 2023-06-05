//
//  SummariesViewController.m
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummariesViewController.h"
#import "SummariesViewModel.h"
#import "SummaryNode.h"
#import "SummaryTableCellView.h"

#define kSummariesViewControllerTableColumnIdentifier @""

@interface SummariesViewController () <NSOutlineViewDelegate, NSOutlineViewDataSource>
@property (retain) NSScrollView *scrollView;
@property (retain) NSOutlineView *outlineView;
@property (retain) SummariesViewModel *viewModel;
@property NSArray *content;
@end

@implementation SummariesViewController

- (void)dealloc {
    [_scrollView release];
    [_outlineView release];
    [_viewModel release];
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
    [self.viewModel loadDataSourceWithCompletionHandler:^{
        
    }];
}

- (void)setupScrollView {
    NSScrollView *scrollView = [NSScrollView new];
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
    SummariesViewModel *viewModel = [SummariesViewModel new];
    NSTreeController *treeController = viewModel.treeController;
    
    [self.outlineView bind:NSContentBinding toObject:treeController withKeyPath:@"arrangedObjects" options:nil];
    [self.outlineView bind:NSSelectionIndexPathsBinding toObject:treeController withKeyPath:NSSelectionIndexPathsBinding options:nil];
    [self.outlineView bind:NSSortDescriptorsBinding toObject:treeController withKeyPath:NSSortDescriptorsBinding options:nil];
    
    self.outlineView.dataSource = self;
    
    self.viewModel = viewModel;
    [viewModel release];
}

#pragma mark - NSOutlineViewDelegate

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    SummaryTableCellView *view = [outlineView makeViewWithIdentifier:@"SummaryTableCellView" owner:nil];
    NSTreeNode *treeNode = (NSTreeNode *)item;
    SummaryNode *representedObject = [treeNode representedObject];
    
    view.imageView.image = [NSImage imageWithSystemSymbolName:representedObject.systemImageName accessibilityDescription:nil];
    view.textField.stringValue = representedObject.title;
    
    return view;
}

#pragma mark - NSOutlineViewDataSource

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    // NSTreeControllerTreeNode
    NSTreeNode *treeNode = (NSTreeNode *)item;
    SummaryNode *representedObject = [treeNode representedObject];
    return representedObject;
}

@end
