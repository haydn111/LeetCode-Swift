// Design a data structure that supports all following operations in average O(1) time.

// insert(val): Inserts an item val to the set if not already present.
// remove(val): Removes an item val from the set if present.
// getRandom: Returns a random element from current set of elements. Each element must have the same probability of being returned.

// Example:

// // Init an empty set.
// RandomizedSet randomSet = new RandomizedSet();

// // Inserts 1 to the set. Returns true as 1 was inserted successfully.
// randomSet.insert(1);

// // Returns false as 2 does not exist in the set.
// randomSet.remove(2);

// // Inserts 2 to the set, returns true. Set now contains [1,2].
// randomSet.insert(2);

// // getRandom should return either 1 or 2 randomly.
// randomSet.getRandom();

// // Removes 1 from the set, returns true. Set now contains [2].
// randomSet.remove(1);

// // 2 was already in the set, so return false.
// randomSet.insert(2);

// // Since 2 is the only number in the set, getRandom always return 2.
// randomSet.getRandom();

class DoublelyLinkedNode {
    var val: Int
    weak var left: DoublelyLinkedNode
    weak var right: DoublelyLinkedNode

    init(_ val: Int) {
        self.val = val
        left = self
        right = self
    }
}

class RandomizedSet {
    var head = DoublelyLinkedNode(Int.min)  // dummy head
    var dict = [Int: DoublelyLinkedNode]()

    func insert(_ val: Int) -> Bool {
        if dict[val] != nil { return false }
        let node = DoublelyLinkedNode(val)
        let next = head.right
        head.right = node   // insert the node right to head
        node.left = head
        node.right = next
        next.left = node
        dict[val] = node
        return true
    }

    func remove(_ val: Int) -> Bool {
        guard let node = dict[val] else { return false }
        let left = node.left, right = node.right
        left.right = right
        right.left = left
        dict[val] = nil
        return true
    }

    func getRandom() -> Int {
        let random = arc4random_uniform(dict.count)
        return Int(dict.allKeys()[random])
        
    }
}