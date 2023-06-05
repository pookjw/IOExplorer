//
//  DetailViewModel.hpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>

NS_ASSUME_NONNULL_BEGIN

class DetailViewModel {
public:
    io_object_t ioObject();
    void setIOObject(io_object_t ioObject);
    DetailViewModel();
    ~DetailViewModel();
private:
    io_object_t _ioObject;
};

NS_ASSUME_NONNULL_END
