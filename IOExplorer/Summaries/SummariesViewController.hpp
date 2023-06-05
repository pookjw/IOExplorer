//
//  SummariesViewController.hpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

static NSNotificationName const NSNotificationNameSummariesViewControllerSelectionDidChangeIOObject = @"NSNotificationNameSummariesViewControllerSelectionDidChangeIOObject";
static NSString * const SummariesViewControllerIOObjectKey = @"SummariesViewControllerIOObjectKey";

@interface SummariesViewController : NSViewController

@end

NS_ASSUME_NONNULL_END
