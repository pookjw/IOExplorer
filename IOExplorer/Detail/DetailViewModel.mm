//
//  DetailViewModel.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "DetailViewModel.hpp"

DetailViewModel::DetailViewModel() {
    _ioObject = IO_OBJECT_NULL;
}

DetailViewModel::~DetailViewModel() {
    IOObjectRelease(_ioObject);
}

io_object_t DetailViewModel::ioObject() {
    return _ioObject;
}

void DetailViewModel::setIOObject(io_object_t ioObject) {
    IOObjectRelease(_ioObject);
    _ioObject = ioObject;
    IOObjectRetain(ioObject);
}
