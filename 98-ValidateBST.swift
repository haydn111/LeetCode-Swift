// Given a binary tree, determine if it is a valid binary search tree (BST).

// Assume a BST is defined as follows:

// The left subtree of a node contains only nodes with keys less than the node's key.
// The right subtree of a node contains only nodes with keys greater than the node's key.
// Both the left and right subtrees must also be binary search trees.
// Example 1:

// Input:
//     2
//    / \
//   1   3
// Output: true

// Example 2:

//     5
//    / \
//   1   4
//      / \
//     3   6
// Output: false
// Explanation: The input is: [5,1,4,null,null,3,6]. The root node's value
//              is 5 but its right child's value is 4.

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
    var valid = true

    func isValidBST(_ root: TreeNode?) -> Bool {
        findMinMax(root)
        return valid
    }
    
    func findMinMax(_ root: TreeNode?) -> (Int, Int) {  // (min, max)
        if root == nil { return (Int.max, Int.min) }
        if root!.left == nil && root!.right == nil {
            return (root!.val, root!.val) 
        }
        if root!.left == nil {
            let (rMin, rMax) = findMinMax(root!.right!)
            if rMin <= root!.val { valid = false }
            return (min(root!.val, rMin), max(root!.val, rMax))
        }
        if root!.right == nil {
            let (lMin, lMax) = findMinMax(root!.left!)
            if lMax >= root!.val { valid = false }
            return (min(root!.val, lMin), max(root!.val, lMax))
        }
        
        let (lMin, lMax) = findMinMax(root!.left!)
        let (rMin, rMax) = findMinMax(root!.right!)
        if root!.val <= lMax || root!.val >= rMin { valid = false }

        return (min(root!.val, min(lMin, rMin)),
                max(root!.val, max(lMax, rMax)))
    }
}