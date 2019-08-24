// One way to serialize a binary tree is to use pre-order traversal. When we encounter a non-null node, we record the node's value. If it is a null node, we record using a sentinel value such as #.

//      _9_
//     /   \
//    3     2
//   / \   / \
//  4   1  #  6
// / \ / \   / \
// # # # #   # #
// For example, the above binary tree can be serialized to the string "9,3,4,#,#,1,#,#,2,#,6,#,#", where # represents a null node.

// Given a string of comma separated values, verify whether it is a correct preorder traversal serialization of a binary tree. Find an algorithm without reconstructing the tree.

// Each comma separated value in the string must be either an integer or a character '#' representing null pointer.

// You may assume that the input format is always valid, for example it could never contain two consecutive commas such as "1,,3".

// Example 1:

// Input: "9,3,4,#,#,1,#,#,2,#,6,#,#"
// Output: true
// Example 2:

// Input: "1,#"
// Output: false
// Example 3:

// Input: "9,#,#,1"
// Output: false


// Idea: keep replacing leaf (num##) into #, until the entire tree becomes #
// E.g. 12456#####3## => 12456###### => 1245##### => 124#### => 12### => 1## => #
//      
// Optimize: Use a stack, puch from left to right, pop each num## when seen

func isValidSerialization(_ preorder: String) -> Bool {
    if preorder.count == 0 || (preorder.count == 1 && preorder.first! == "#") { return true }
    var stack = [Substring](), chars = preorder.split(separator:",")
    for char in chars {
        // need to do it in a loop, see example 1
        while stack.last == "#" && char == "#" {
            stack.removeLast()
            if stack.count == 0 { return false }
            stack.removeLast()
        }
        stack.append(char)
    }
    return stack.count == 1 && stack.first! == "#"
}
