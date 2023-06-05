//
//  SummaryNodeObject.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummaryNodeObject.hpp"
#import <ranges>
#import <vector>

@interface SummaryNodeObject ()
@property (assign) std::shared_ptr<SummaryNode> summaryNodeRef;
@property (retain) NSArray<SummaryNodeObject *> *children;
@end

@implementation SummaryNodeObject

- (instancetype)initWithsummaryNodeRef:(std::shared_ptr<SummaryNode>)summaryNodeRef {
    if (self = [self init]) {
        self.summaryNodeRef = summaryNodeRef;
        
        auto childrenView = summaryNodeRef.get()->children() |
        std::views::transform([](std::shared_ptr<SummaryNode> childRef) -> SummaryNodeObject * __autoreleasing {
            SummaryNodeObject *childObject = [[SummaryNodeObject alloc] initWithsummaryNodeRef:childRef];
            return [childObject autorelease];
        });
        auto childrenVec = std::vector<SummaryNodeObject * __autoreleasing>(childrenView.begin(), childrenView.end());
        
        NSArray<SummaryNodeObject *> *children = [[NSArray alloc] initWithObjects:childrenVec.data() count:childrenVec.size()];
        self.children = children;
        [children release];
    }
    
    return self;
}

- (void)dealloc {
    [_children release];
    [super dealloc];
}

- (NSString *)title {
    return [NSString stringWithCString:self.summaryNodeRef.get()->title().data() encoding:NSUTF8StringEncoding];
}

- (NSString *)systemImageName {
    return [NSString stringWithCString:self.summaryNodeRef.get()->systemImageName().data() encoding:NSUTF8StringEncoding];
}

- (NSNumber *)count {
    return @(self.summaryNodeRef.get()->children().size());
}

- (BOOL)isLeaf {
    return self.summaryNodeRef.get()->isLeaf();
}

@end
