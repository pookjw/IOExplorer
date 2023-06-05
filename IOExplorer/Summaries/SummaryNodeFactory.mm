//
//  SummaryNodeFactory.mm
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummaryNodeFactory.hpp"
#import <CoreFoundation/CoreFoundation.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/usb/IOUSBLib.h>
#import <string>

SummaryNode *SummaryNodeFactory::usbNode() {
    NSMutableArray<SummaryNode *> *children = [NSMutableArray<SummaryNode *> new];
    
    mach_port_t mainPort;
    IOMainPort(MACH_PORT_NULL, &mainPort);
    
    io_iterator_t iterator = IO_OBJECT_NULL;
    CFMutableDictionaryRef matchingDict = IOServiceMatching(kIOUSBDeviceClassName);
    kern_return_t result = IOServiceGetMatchingServices(mainPort, matchingDict, &iterator);
    assert(result == KERN_SUCCESS);
    
    io_object_t usbCurrentObject;
    while ((usbCurrentObject = IOIteratorNext(iterator))) {
        CFTypeRef name = IORegistryEntrySearchCFProperty(usbCurrentObject, kIOServicePlane, CFSTR(kUSBProductString), kCFAllocatorDefault, kIORegistryIterateParents);
        
        if (name) {
            char string[256];
            CFStringGetCString((CFStringRef)name, string, 256, kCFStringEncodingUTF8);
            CFRelease(name);
            
            NSAutoreleasePool *pool = [NSAutoreleasePool new];
            
            SummaryNode *node = [[SummaryNode alloc] initWithTitle:[NSString stringWithCString:string encoding:NSUTF8StringEncoding]
                                                   systemImageName:@"heart"
                                                          children:@[]];
            [children addObject:node];
            [node release];
            
            [pool release];
        }
    }
    
    IOObjectRelease(iterator);
    
    SummaryNode *usbNode = [[SummaryNode alloc] initWithTitle:@"USB"
                                              systemImageName:@"heart.fill"
                                                     children:children];
    
    [children release];
    
    return [usbNode autorelease];
}
