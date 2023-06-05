//
//  SummaryNode.cpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummaryNode.hpp"
#import <IOKit/usb/IOUSBLib.h>

SummaryNode::SummaryNode(io_object_t ioObject, std::string title, std::vector<std::shared_ptr<SummaryNode>> children) : _ioObject(ioObject), _title(title), _children(children) {
    IOObjectRetain(ioObject);
}

SummaryNode::~SummaryNode() {
    IOObjectRelease(_ioObject);
}

io_object_t SummaryNode::ioObject() {
    return _ioObject;
}

std::string SummaryNode::title() {
    return _title;
}

std::string SummaryNode::systemImageName() {
    if (_ioObject == IO_OBJECT_NULL) {
        return "questionmark";
    }
    
    CFStringRef classNameRef = IOObjectCopyClass(_ioObject);
    
    if (CFStringCompare(classNameRef, CFSTR(kIOUSBHostDeviceClassName), 0) == kCFCompareEqualTo) {
        return "heart";
    } else {
        return "questionmark";
    }
}

std::vector<std::shared_ptr<SummaryNode>> SummaryNode::children() {
    return _children;
}

bool SummaryNode::isLeaf() {
    return _children.empty();
}

SummaryNode::SummaryNode(const SummaryNode& other) : _ioObject(other._ioObject), _title(other._title), _children(other._children) {
    IOObjectRetain(_ioObject);
}

SummaryNode& SummaryNode::operator=(const SummaryNode &other) {
    if (this != &other) {
        _ioObject = other._ioObject;
        _title = other._title;
        _children = other._children;
        IOObjectRetain(_ioObject);
    }
    
    return *this;
}
