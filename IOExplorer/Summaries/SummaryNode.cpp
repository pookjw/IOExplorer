//
//  SummaryNode.cpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import "SummaryNode.hpp"

SummaryNode::SummaryNode(io_object_t ioObject, std::string title, std::vector<std::shared_ptr<SummaryNode>> children, SummaryNode::NodeType nodeType) : _ioObject(ioObject), _title(title), _children(children), _nodeType(nodeType) {
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
    switch (_nodeType) {
        case SummaryNode::NodeType::USBRootType:
            return "heart.fill";
        case SummaryNode::NodeType::USBType:
            return "heart";
        default:
            return "questionmark";
    }
}

std::vector<std::shared_ptr<SummaryNode>> SummaryNode::children() {
    return _children;
}

bool SummaryNode::isLeaf() {
    return _children.empty();
}

SummaryNode::NodeType SummaryNode::nodeType() {
    return _nodeType;
}

SummaryNode::SummaryNode(const SummaryNode& other) : _ioObject(other._ioObject), _title(other._title), _children(other._children), _nodeType(other._nodeType) {
    IOObjectRetain(_ioObject);
}

SummaryNode& SummaryNode::operator=(const SummaryNode &other) {
    if (this != &other) {
        _ioObject = other._ioObject;
        _title = other._title;
        _children = other._children;
        _nodeType = other._nodeType;
        IOObjectRetain(_ioObject);
    }
    
    return *this;
}
