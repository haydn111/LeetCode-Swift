// Given a binary search tree and a node in it, find the in-order successor of that node in the BST.

// Note: If the given node has no in-order successor in the tree, return null.

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
}

var bst = BST(array: [3, 9, 20, 4, 5, 2, 7, 1, 3])
var found = false
var succ:Int? = nil

func inorder(_ r: BST?, _ p: Int) { // O(n) using inorder traversal
    if r == nil { return }
    inorder(r?.left, p)
    if found { succ = r?.value; found = false; return }
    if r?.value == p { found = true }
    inorder(r?.right, p)
}

// inorder(bst, 7)
// print(succ)

func inorder2(_ r: BST?, _ p: Int) { // O(logn) using inorder traversal and bst property
    if r == nil { return }
    if p < r!.value {
        inorder(r?.left, p)
    }
    if found { succ = r?.value; found = false; return }
    if r?.value == p { found = true }
    if p >= r!.value {
        inorder(r?.right, p)
    }
}
inorder2(bst, 7)
print(succ)
