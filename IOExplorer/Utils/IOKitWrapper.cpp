//
//  IOKitWrapper.cpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "IOKitWrapper.hpp"

std::unordered_set<io_object_t> IOKitWrapper::usb::allObjects() {
    mach_port_t mainPort = MACH_PORT_NULL;
    IOMainPort(MACH_PORT_NULL, &mainPort);
    
    io_iterator_t iterator = IO_OBJECT_NULL;
    CFMutableDictionaryRef matchingDict = IOServiceMatching(kIOUSBHostDeviceClassName);
    kern_return_t result = IOServiceGetMatchingServices(mainPort, matchingDict, &iterator);
    assert(result == KERN_SUCCESS);
    assert(IOIteratorIsValid(iterator));
    
    std::unordered_set<io_object_t> results;
    io_object_t usbCurrentObject = IO_OBJECT_NULL;
    
    while ((usbCurrentObject = IOIteratorNext(iterator))) {
        results.insert(usbCurrentObject);
    }
    
    IOObjectRelease(iterator);
    
    return results;
}

std::optional<std::string> IOKitWrapper::usb::productString(io_object_t object) {
    CFTypeRef name = IORegistryEntrySearchCFProperty(object, kIOServicePlane, CFSTR(kUSBProductString), kCFAllocatorDefault, kIORegistryIterateParents);
    
    if (name) {
        std::string string;
        string.resize(256);
        CFStringGetCString((CFStringRef)name, string.data(), 256, kCFStringEncodingUTF8);
        CFRelease(name);
        
        string.shrink_to_fit();
        return string;
    } else {
        return std::nullopt;
    }
}
