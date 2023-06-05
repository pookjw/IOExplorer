//
//  SummariesViewModel.h
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SummariesViewModel : NSObject
@property (readonly) NSTreeController *treeController;
- (void)loadDataSourceWithCompletionHandler:(void (^)(void))completionHandler;
@end

NS_ASSUME_NONNULL_END
