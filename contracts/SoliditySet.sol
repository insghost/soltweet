pragma solidity ^0.4.24;

contract SoliditySet {

    struct SuperIndex {
        uint prevIndex;
        uint nextIndex;
        uint index;
        bool exists;
    }

    //TODO map to byte array cuz it's and awesome idea
    mapping (uint => SuperIndex) public elements;
    uint[] public elementsKeys;
    uint length;
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
        SuperIndex memory newIndex;
        newIndex.index = elementsKeys.push(element); 
        newIndex.prevIndex = lastExistingElementIndex;
        if (size() > 0) {
            SuperIndex memory prevIndex = elements[lastExistingElementIndex];
            prevIndex.nextIndex = newIndex.index;
        }
        lastExistingElementIndex = newIndex.index;
        newIndex.exists = true;
        elements[element] = newIndex;
        //TODO maybe use safemath
        length = length + 1;
    }

    function remove(uint element) public view {
         //check that it exists in the set
        require(elements[element].exists, "element does not exist in set");
        SuperIndex memory removeNode = elements[element];
        elementsKeys[removeNode.index] = 0; 
        removeNode.exists = false;
        elements[element] = removeNode;

        SuperIndex memory prevNode = elements[removeNode.prevIndex];
        
        if (removeNode.index = lastExistingElementIndex) {
            lastExistingElementIndex = removeNode.prevIndex;
        } else {
            prevNode.nextIndex = removeNode.nextIndex;
            SuperIndex memory nextNode = elements[removeNode.nextIndex];
            nextNode.prevIndex = removeNode.prevIndex;
        }

        //TODO maybe use safemath
        length = length - 1;
    }

    function getFirstN(uint total, uint limit) public view {
        
    }

    function getLastN(uint total, uint limit) public view {
        
    }

    function getFromOffset(uint offset, uint total, uint limit) public view {
        //TODO should we but in a hard limit size
        //can we limit to max gas amount?
        for (uint i = offset; i < total + offset; i++) {
            elementKeys
        }
    }


}

