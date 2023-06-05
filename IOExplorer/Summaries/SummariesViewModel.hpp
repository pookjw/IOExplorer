//
//  SummariesViewModel.hpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <AppKit/AppKit.h>
#import <functional>
#import "SummaryNodeObject.hpp"

NS_ASSUME_NONNULL_BEGIN

class SummariesViewModel {
public:
    NSTreeController *treeController();
    
    SummariesViewModel();
    ~SummariesViewModel();
    void loadDataSource();
private:
    NSTreeController *_treeController;
    NSOperationQueue *_queue;
    void setupTreeController();
    void setupQueue();
    
    static SummaryNodeObject *usbNodeObject();
};

NS_ASSUME_NONNULL_END
