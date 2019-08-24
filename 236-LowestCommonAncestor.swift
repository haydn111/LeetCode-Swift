
// Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

// According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes v and w as the lowest node in T that has both v and w as descendants (where we allow a node to be a descendant of itself).”

// Given the following binary search tree:  root = [3,5,1,6,2,0,8,null,null,7,4]

//         _______3______
//        /              \
//     ___5__          ___1__
//    /      \        /      \
//    6      _2       0       8
//          /  \
//          7   4

// Example 1:
// Input: root, p = 5, q = 1
// Output: 3
// Explanation: The LCA of of nodes 5 and 1 is 3.

// Example 2:
// Input: root, p = 5, q = 4
// Output: 5
// Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself
//              according to the LCA definition.

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    if root == nil || root === p || root === q { return root }
    var left = lowestCommonAncestor(root?.left, p, q)
    var right = lowestCommonAncestor(root?.right, p, q)
    if left != nil && right != nil { return root }
    else if left == nil { return right }
    else if right == nil { return left }
    else { return nil }
}