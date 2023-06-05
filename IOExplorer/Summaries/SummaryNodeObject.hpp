//
//  SummaryNodeObject.hpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <Foundation/Foundation.h>
#import "SummaryNode.hpp"
#import <memory>

NS_ASSUME_NONNULL_BEGIN

@interface SummaryNodeObject : NSObject
@property (readonly, assign) std::shared_ptr<SummaryNode> summaryNodeRef;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *systemImageName;
@property (readonly, retain) NSArray<SummaryNodeObject *> *children;
@property (readonly, nonatomic) NSNumber *count;
@property (readonly, nonatomic) BOOL isLeaf;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithsummaryNodeRef:(std::shared_ptr<SummaryNode>)summaryNodeRef;
@end

NS_ASSUME_NONNULL_END
