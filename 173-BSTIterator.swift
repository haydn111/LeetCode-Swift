// Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.

// Calling next() will return the next smallest number in the BST.

// Note: next() and hasNext() should run in average O(1) time and uses O(h) memory, where h is the height of the tree.


// Create a pushLeft func that push the left subtree of current node into a stack so the smallest node will be on top of stack. Everytime after pop, check if the new top has a right child. Call pushLeft on the right child. Keep do this until stack is empty
struct BSTIterator: IteratorProtocol {
    private var root: TreeNode?
    private var stack = [TreeNode]()

    init(_ node: TreeNode?) { 
        self.root = node 
        if root != nil { pushLeft(root) }
    }

    mutating func next() -> TreeNode? {
        var result: TreeNode? = nil
        if stack.count > 0 { 
            result = stack.removeLast() 
            if result.right != nil {
                pushLeft(result.right)
            }
        }
        return result
    }

    func hasNext() -> Bool {
        return stack.count > 0
    }

    private func pushLeft(_ node: TreeNode) {
        var curr: TreeNode? = node
        while curr != nil {
            stack.append(curr)
            curr = curr.left
        }
    }
}