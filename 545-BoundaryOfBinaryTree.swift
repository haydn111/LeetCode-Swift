// Given a binary tree, return the values of its boundary in anti-clockwise direction starting from root. Boundary includes left boundary, leaves, and right boundary in order without duplicate nodes.

// Left boundary is defined as the path from root to the left-most node. Right boundary is defined as the path from root to the right-most node. If the root doesn't have left subtree or right subtree, then the root itself is left boundary or right boundary. Note this definition only applies to the input binary tree, and not applies to any subtrees.

// The left-most node is defined as a leaf node you could reach when you always firstly travel to the left subtree if exists. If not, travel to the right subtree. Repeat until you reach a leaf node.

// The right-most node is also defined by the same way with left and right exchanged.

// Example 1

// Input:
//   1
//    \
//     2
//    / \
//   3   4

// Ouput:
// [1, 3, 4, 2]

// Explanation:
// The root doesn't have left subtree, so the root itself is left boundary.
// The leaves are node 3 and 4.
// The right boundary are node 1,2,4. Note the anti-clockwise direction means you should output reversed right boundary.
// So order them in anti-clockwise without duplicates and we have [1,3,4,2].
 

// Example 2

// Input:
//     ____1_____
//    /          \
//   2            3
//  / \          / 
// 4   5        6   
//    / \      / \
//   7   8    9  10  
       
// Ouput:
// [1,2,4,7,8,9,10,6,3]

// Explanation:
// The left boundary are node 1,2,4. (4 is the left-most node according to definition)
// The leaves are node 4,7,8,9,10.
// The right boundary are node 1,3,6,10. (10 is the right-most node).
// So order them in anti-clockwise without duplicate nodes we have [1,2,4,7,8,9,10,6,3].
 

// 这道题给了我们一棵二叉树，让我们以逆时针的顺序来输出树的边界，按顺序分别为左边界，叶结点和右边界。题目中给的例子也能让我们很清晰的明白哪些算是边界上的结点。那么最直接的方法就是分别按顺序求出左边界结点，叶结点，和右边界结点。那么如何求的，对于树的操作肯定是用递归最简洁啊，所以我们可以写分别三个递归函数来分别求左边界结点，叶结点，和右边界结点。
// 根据题目条件, 首先判断root是否有左/右child, 如果没有那么左/右边界即是root自身.

func boundaryOfBinaryTree(_ root: TreeNode) -> [Int] {
    var leaves = [Int]()
    self.leaves(root, &leaves)
    let left = root.left == nil ? [] : leftBoundary(root.left!)
    let right = root.right == nil ? [] : rightBoundary(root.right!)
    return [root.val] + left + leaves + right
}

func leftBoundary(_ root: TreeNode) -> [Int] {
    if root.left == nil && root.right == nil { return [] }  // root is a leaf node, do not add to avoid duplication
    if root.left != nil { return [root.val] + leftBoundary(root.left!) }
    return [root.val] + leftBoundary(root.right!)
}

func rightBoundary(_ root: TreeNode) -> [Int] {
    if root.left == nil && root.right == nil { return [] }  // root is a leaf node, do not add to avoid duplication
    if root.right != nil { return rightBoundary(root.right!) + [root.val] }
    return rightBoundary(root.left!) + [root.val]
}

func leaves(_ root: TreeNode, _ result: inout [Int]) {
    if root.left == nil && root.right == nil { result.append(root.val) }
    if root.left != nil { leaves(root.left!, &result) }
    if root.right != nil { leaves(root.right!, &result) }
}
