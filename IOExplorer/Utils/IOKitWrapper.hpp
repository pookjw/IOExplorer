//
//  IOKitWrapper.hpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <IOKit/IOKitLib.h>
#import <IOKit/usb/IOUSBLib.h>
#import <unordered_set>
#import <string>
#import <optional>

namespace IOKitWrapper {

namespace usb {
std::unordered_set<io_object_t> allObjects(); // You must call IOObjectRelease.
std::optional<std::string> productString(io_object_t object);
};

};
