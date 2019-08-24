// Given a binary tree, find the length of the longest consecutive sequence path.

// The path refers to any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The longest consecutive path need to be from parent to child (cannot be the reverse).

// For example,

//    1
//     \
//      3
//     / \
//    2   4
//         \
//          5
// Longest consecutive sequence path is 3-4-5, so return 3.

//    2
//     \
//      3
//     / 
//    2    
//   / 
//  1
// Longest consecutive sequence path is 2-3,not3-2-1, so return 2.

var maxPath = 1

func longestConsecutive(_ root: TreeNode?) -> Int {
    findConsecutive(root, 1)
    return maxPath
}

func findConsecutive(_ root: TreeNode?, _ count: Int) {
    if root == nil { return }
    maxPath = max(maxPath, count)
    if let left = root!.left {
        if left.val == root.val + 1 { findConsecutive(left, count + 1) }
        else { findConsecutive(left, 1) }
    }
    if let right = root!.right {
        if right.val == root.val + 1 { findConsecutive(right, count + 1) }
        else { findConsecutive(right, 1) }
    }
}