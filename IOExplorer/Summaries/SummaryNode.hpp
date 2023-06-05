//
//  SummaryNode.hpp
//  IOExplorer
//
//  Created by Jinwoo Kim on 6/5/23.
//

#import <IOKit/IOKitLib.h>
#import <string>
#import <vector>
#import <memory>

class SummaryNode {
public:
    enum NodeType {
        USBRootType,
        USBType
    };
    
    io_object_t ioObject();
    std::string title();
    std::string systemImageName();
    std::vector<std::shared_ptr<SummaryNode>> children();
    bool isLeaf();
    NodeType nodeType();
    
    SummaryNode(io_object_t ioObject, std::string title, std::vector<std::shared_ptr<SummaryNode>> children, NodeType nodeType);
    ~SummaryNode();
    SummaryNode(const SummaryNode& other);
    SummaryNode& operator=(const SummaryNode& other);
protected:
    io_object_t _ioObject;
    std::string _title;
    std::vector<std::shared_ptr<SummaryNode>> _children;
    NodeType _nodeType;
};
