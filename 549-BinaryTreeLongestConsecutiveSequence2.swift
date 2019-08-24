// Given a binary tree, you need to find the length of Longest Consecutive Path in Binary Tree.

// Especially, this path can be either increasing or decreasing. For example, [1,2,3,4] and [4,3,2,1] are both considered valid, but the path [1,2,4,3] is not valid. On the other hand, the path can be in the child-Parent-child order, where not necessarily be parent-child order.

// Example 1:

// Input:
//         1
//        / \
//       2   3
// Output: 2
// Explanation: The longest consecutive path is [1, 2] or [2, 1].

// Example 2:

// Input:
//         2
//        / \
//       1   3
// Output: 3
// Explanation: The longest consecutive path is [1, 2, 3] or [3, 2, 1].

// Longest consecutive seq at some node must equal to a decreasing seq (top down) on one side and an increasing seq (top down) on the other side. Calculate length of longest inc/dec seq at each node can get the solution.
// 递归求解以root为根节点向子节点方向（parent-child）的路径中，最大连续递增路径长度inc，以及最大连续递减路径长度dec. 最大连续路径长度=inc + dec + 1
// var (incL, decL) = dfs(root.left!)
// if root.left!.val - 1 == root.val { dec = max(dec, decL) }
// if root.left!.val + 1 == root.val { inc = max(inc, incL) }

// var (incR, decR) = dfs(root.right!)
// if root.right!.val - 1 == root.val { dec = max(dec, decR) }
// if root.right!.val + 1 == root.val { inc = max(inc, incR) }


var result = 0
func longestConsecutive(_ root: TreeNode?) -> Int {
    if root == nil { return 0 }
    _ = dfs(root!)
    return result
}

func dfs(_ root: TreeNode) -> (Int, Int) {
    var inc = 0, dec = 0
    if root.left != nil {
        var (incL, decL) = dfs(root.left!)
        if root.left!.val - 1 == root.val { dec = max(dec, decL) }
        if root.left!.val + 1 == root.val { inc = max(inc, incL) }
    }
    if root.right != nil {
        var (incR, decR) = dfs(root.right!)
        if root.right!.val - 1 == root.val { dec = max(dec, decR) }
        if root.right!.val + 1 == root.val { inc = max(inc, incR) }
    }

    result = max(result, inc + dec + 1)
    return (inc, dec)
}