//
//  DetailViewModel.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "DetailViewModel.hpp"

DetailViewModel::DetailViewModel() {
    _ioObject = IO_OBJECT_NULL;
    setupQueue();
}

DetailViewModel::~DetailViewModel() {
    [_queue cancelAllOperations];
    [_queue release];
    IOObjectRelease(_ioObject);
}

void DetailViewModel::setIOObject(io_object_t ioObject) {
    [_queue addOperationWithBlock:^{
        IOObjectRelease(_ioObject);
        _ioObject = ioObject;
        IOObjectRetain(ioObject);
    }];
}

void DetailViewModel::setupQueue() {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.qualityOfService = NSQualityOfServiceUserInitiated;
    queue.maxConcurrentOperationCount = 1;
    _queue = [queue retain];
    [queue release];
}
