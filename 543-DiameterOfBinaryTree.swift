// Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

// Example:
// Given a binary tree 
//           1
//          / \
//         2   3
//        / \     
//       4   5    
// Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].

// Note: The length of path between two nodes is represented by the number of edges between them.

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    var maxDiameter = 0
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        distanceToLeaf(from: root)
        return maxDiameter
    }
    
    @discardableResult func distanceToLeaf(from root: TreeNode?) -> Int {
        if root == nil { return 0 }
        if root!.left == nil && root!.right == nil { return 0 }
        let left = distanceToLeaf(from: root!.left)
        let right = distanceToLeaf(from: root!.right)
        let diameter = (root!.left == nil ? 0 : 1 + left) + (root!.right == nil ? 0 : 1 + right)
        maxDiameter = max(maxDiameter, diameter)
        return 1 + max(left, right)
    }
}