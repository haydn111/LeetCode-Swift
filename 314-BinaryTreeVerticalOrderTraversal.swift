import Foundation

// Given a binary tree, return the vertical order traversal of its nodes' values. (ie, from top to bottom, column by column).

// If two nodes are in the same row and column, the order should be from left to right.

// Examples:
// Given binary tree [3,9,20,null,null,15,7],

//     3
//    / \
//   9  20
//     /  \
//    15   7
 

// return its vertical order traversal as:

// [
//   [9],
//   [3,15],
//   [20],
//   [7]
// ]
 
// Given a binary tree, return the vertical order traversal of its nodes' values. (ie, from top to bottom, column by column).

// If two nodes are in the same row and column, the order should be from left to right.

// Given binary tree [3,9,20,4,5,2,7],

//     _3_
//    /   \
//   9    20
//  / \   / \
// 4   5 2   7
 

// return its vertical order traversal as:

// [
//   [4],
//   [9],
//   [3,5,2],
//   [20],
//   [7]
// ]

public class TreeNode: NSObject {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
    }
}

var minLevel = Int.max, maxLevel = Int.min
var dict = [Int: [Int]]()  // level: nodes in level

// BFS(level order) + Dictionary
func verticalOrder(_ root: TreeNode?) {
    if root == nil { return }
    var queue: [(TreeNode, Int)] = [(root!, 0)]
    while queue.count > 0 {
        let (node, level) = queue.removeFirst()
        if dict[level] == nil { dict[level] = [Int]() }
        dict[level]!.append(node.val)
        minLevel = min(minLevel, level)
        maxLevel = max(maxLevel, level)

        if node.left != nil { queue.append((node.left!, level - 1)) }
        if node.right != nil { queue.append((node.right!, level + 1)) }
    }

    for l in minLevel...maxLevel {
        print(dict[l]!)
    }
}

class BST {
    var left: BST?
    var right: BST?
    var value: Int
    
    init(value: Int) {
        self.value = value
        left = nil
        right = nil
    }
    
    init(array: [Int]) {
        if array.count == 0 { fatalError("Empty Tree") }
        self.value = array.first!
        let rest = array[1...array.count - 1]
        for item in rest {
            insert(item)
        }
    }
    
    func insert(_ item: Int) {
        if item <= value {
            if left == nil { left = BST(value: item) }
            else { left!.insert(item) }
        }
        else {
            if right == nil { right = BST(value: item) }
            else { right!.insert(item) }
        }
    }
    
    func preOrder() {
        print(value)
        left?.preOrder()
        right?.preOrder()
    }
    
    func verticalOrder() {
        var verticalDict = [Int: [Int]]()
        var minLevel = 0
        var maxLevel = 0

        verticalOrder(level: 0, &minLevel, &maxLevel, &verticalDict)
        for i in minLevel...maxLevel {
            print(verticalDict[i]!)
        }
    }
    
    func verticalOrder(level: Int, _ minLevel: inout Int, _ maxLevel: inout Int, _ verticalDict: inout [Int: [Int]]) {
        if level < minLevel { minLevel = level }
        if level > maxLevel { maxLevel = level }
        if verticalDict[level] == nil { verticalDict[level] = [value] }
        else { verticalDict[level]!.append(value) }

        left?.verticalOrder(level: level - 1, &minLevel, &maxLevel, &verticalDict)
        right?.verticalOrder(level: level + 1, &minLevel, &maxLevel, &verticalDict)
    }
}

var bst = BST(array: [3, 9, 20, 4, 5, 2, 7, 1, 3])
bst.verticalOrder()

