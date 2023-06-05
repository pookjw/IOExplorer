//
//  SummariesViewModel.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummariesViewModel.hpp"
#import "IOKitWrapper.hpp"
#import <ranges>

SummariesViewModel::SummariesViewModel() {
    setupTreeController();
    setupQueue();
}

SummariesViewModel::~SummariesViewModel() {
    [_treeController release];
    [_queue cancelAllOperations];
    [_queue release];
}

NSTreeController *SummariesViewModel::treeController() {
    return [[_treeController retain] autorelease];
}

void SummariesViewModel::loadDataSource() {
    NSTreeController *treeController = _treeController;
    
    [_queue addOperationWithBlock:^{
        SummaryNodeObject *usbNodeObject = SummariesViewModel::usbNodeObject();
        
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:0];
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            [treeController insertObject:usbNodeObject atArrangedObjectIndexPath:indexPath];
        }];
    }];
}

void SummariesViewModel::setupTreeController() {
    NSTreeController *treeController = [NSTreeController new];
    treeController.objectClass = SummaryNodeObject.class;
    treeController.childrenKeyPath = @"children";
    treeController.countKeyPath = @"count";
    treeController.leafKeyPath = @"isLeaf";
    
    _treeController = [treeController retain];
    [treeController release];
}

void SummariesViewModel::setupQueue() {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.qualityOfService = NSQualityOfServiceUserInitiated;
    _queue = [queue retain];
    [queue release];
}

SummaryNodeObject *SummariesViewModel::usbNodeObject() {
    auto children = IOKitWrapper::usb::allObjects() |
    std::views::transform([](io_object_t ioObject) {
        auto productString = IOKitWrapper::usb::productString(ioObject).value_or("(null)");
        std::shared_ptr<SummaryNode> summaryNode = std::make_shared<SummaryNode>(ioObject, productString, std::vector<std::shared_ptr<SummaryNode>>());
        IOObjectRelease(ioObject);
        return summaryNode;
    });
    
    std::vector<std::shared_ptr<SummaryNode>> sortedChildren(children.begin(), children.end());
    
    std::ranges::sort(sortedChildren, [](auto lhs, auto rhs) {
        return lhs.get()->title() < rhs.get()->title();
    });
    
    std::shared_ptr<SummaryNode> summaryNodeRef = std::make_shared<SummaryNode>(IO_OBJECT_NULL, "USB", sortedChildren);
    SummaryNodeObject *result = [[SummaryNodeObject alloc] initWithsummaryNodeRef:summaryNodeRef];
    
    return [result autorelease];
}
