//
//  DetailViewController.hpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <Cocoa/Cocoa.h>
#import <IOKit/IOKitLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : NSViewController
- (void)setIOObject:(io_object_t)ioObject;
@end

NS_ASSUME_NONNULL_END
