//
//  SummariesViewModel.m
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummariesViewModel.h"
#import "SummaryNodeFactory.hpp"

@interface SummariesViewModel ()
@property (retain) NSTreeController *treeController;
@property (retain) NSOperationQueue *queue;
@end

@implementation SummariesViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setupTreeController];
        [self setupQueue];
    }
    
    return self;
}

- (void)dealloc {
    [_treeController release];
    [_queue cancelAllOperations];
    [_queue release];
    [super dealloc];
}

- (void)loadDataSourceWithCompletionHandler:(void (^)(void))completionHandler {
    NSTreeController *treeController = self.treeController;
    
    [self.queue addOperationWithBlock:^{
        SummaryNode *usbNode = SummaryNodeFactory::usbNode();
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:0];
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            [treeController insertObject:usbNode atArrangedObjectIndexPath:indexPath];
        }];

        completionHandler();
    }];
}

- (void)setupTreeController {
    NSTreeController *treeController = [NSTreeController new];
    treeController.objectClass = SummaryNode.class;
    treeController.childrenKeyPath = @"children";
    treeController.countKeyPath = @"count";
    treeController.leafKeyPath = @"isLeaf";
    
    self.treeController = treeController;
    [treeController release];
}

- (void)setupQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.qualityOfService = NSQualityOfServiceBackground;
    self.queue = queue;
    [queue release];
}

@end
