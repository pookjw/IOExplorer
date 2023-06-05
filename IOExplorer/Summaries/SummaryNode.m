//
//  SummaryNode.m
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummaryNode.h"

@interface SummaryNode ()
@property (copy) NSString *title;
@property (copy) NSString *systemImageName;
@property (copy) NSArray<SummaryNode *> *children;
@end

@implementation SummaryNode

- (instancetype)initWithTitle:(NSString *)title systemImageName:(NSString *)systemImageName children:(NSArray<SummaryNode *> *)children {
    if (self = [self init]) {
        self.title = title;
        self.systemImageName = systemImageName;
        self.children = children;
    }
    
    return self;
}

- (void)dealloc {
    [_title release];
    [_systemImageName release];
    [_children release];
    [super dealloc];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    SummaryNode *copy = [self.class new];
    
    if (copy) {
        copy.title = self.title;
        copy.systemImageName = self.systemImageName;
        copy.children = self.children;
    }
    
    return copy;
}

- (BOOL)isLeaf {
    return !self.children.count;
}

- (NSNumber *)count {
    return @(self.children.count);
}

@end
