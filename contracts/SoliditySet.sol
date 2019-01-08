pragma solidity ^0.4.24;

contract SoliditySet {

    struct Node {
        uint prevIndex;
        uint nextIndex;
        uint index;
        bool exists;
    }

    //TODO map to byte array cuz it's and awesome idea
    mapping (uint => Node) public elements;
    uint length;    
    uint firstExistingElementIndex;
    uint lastExistingElementIndex;
   
    function contains(uint element) public view returns (bool) {
        //TODO NPE issue
        //TODO check that this returns false instead of 0
        return !elements[element].exists;
    }

    function isEmpty() public view returns (bool) {
        return length == 0;
    }

    function size() public view returns (uint) {
        return length;
    }

    function add(uint element) public view {
        //check that it's not in the set already
        //TODO check that we don't need to a NPE check
        require(!elements[element].exists, "element already exists in set");
        Node memory newNode;
        newNode.prevIndex = lastExistingElementIndex;
        if (size() > 0) {
            Node memory prevIndex = elements[lastExistingElementIndex];
            prevIndex.nextIndex = newNode.index;
        }
        lastExistingElementIndex = newNode.index;
        newNode.exists = true;
        elements[element] = newNode;
        //TODO maybe use safemath
        length = length + 1;
    }

    function remove(uint element) public view {
         //check that it exists in the set
        require(elements[element].exists, "element does not exist in set");
        Node memory removeNode = elements[element];
        removeNode.exists = false;
        elements[element] = removeNode;

        Node memory prevNode = elements[removeNode.prevIndex];
        
        if (removeNode.index = lastExistingElementIndex) {
            lastExistingElementIndex = removeNode.prevIndex;
        } else {
            prevNode.nextIndex = removeNode.nextIndex;
            Node memory nextNode = elements[removeNode.nextIndex];
            nextNode.prevIndex = removeNode.prevIndex;
        }

        //TODO maybe use safemath
        length = length - 1;
    }

    function getFirstN(uint total, uint limit) public view {
        
    }

    function getLastN(uint total, uint limit) public view {
        
    }

    function getFromOffset(uint offset, uint limit) public view {
        //TODO should we put in a hard limit size
        //can we limit to max gas amount?]
        uint[] results;
        uint currentNodeIndex;
        while (results.length < total + offset) {
            results.push(elements[i]);
        }
    }


}

