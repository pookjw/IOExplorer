//
//  SummaryNode.h
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SummaryNode : NSObject <NSCopying>
@property (readonly, copy) NSString *title;
@property (readonly, copy) NSString *systemImageName;
@property (readonly, copy) NSArray<SummaryNode *> *children;
@property (readonly, nonatomic) BOOL isLeaf;
@property (readonly, nonatomic) NSNumber *count;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title systemImageName:(NSString *)systemImageName children:(NSArray<SummaryNode *> *)children;
@end

NS_ASSUME_NONNULL_END
