// Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

// Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

// For example, you may serialize the following tree

//     1
//    / \
//   2   3
//      / \
//     4   5
// as "[1,2,3,null,null,4,5]", just the same as how LeetCode OJ serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.



// Note: Do not use class member/global/static variables to store states. Your serialize and deserialize algorithms should be stateless.

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    public init(_ val: Int) { self.val = val }
}

class Queue<T> {
    var q = [T]()
    var count: Int { return q.count }
    
    func enqueue(_ item: T) {
        q.append(item)
    }
    
    func dequeue() -> T? {
        if q.count > 0 { return q.remove(at: 0) }
        return nil
    }
}

func serialize(_ root: TreeNode?) -> String {
    guard let r = root else { return "[]" }
    let q = Queue<TreeNode?>()
    var result = [String]()
    q.enqueue(r)
    while q.count > 0 {
        if let n = q.dequeue(), let node = n {
            result.append(String(node.val))
            q.enqueue(node.left)
            q.enqueue(node.right)
        } else {
            result.append("null")
        }
    }
    while (result.last == "null") {     // trim nulls at the end
        result.removeLast()
    }
    return "[" + result.joined(separator: ",") + "]"
}

func deserialize(_ data: String) -> TreeNode? {
    if data.count <= 2 { return nil }
    var s = data
    s.removeFirst()
    s.removeLast()
    var nodes = s.split(separator: ",").map { String($0) }
    if nodes.count == 0 || nodes[0] == "null" { return nil }
    let root = buildNode(nodes[0])
    buildTree(root, nodes, 0)
    return root
}

func buildTree(_ root: TreeNode?, _ nodes: [String], _ i: Int) {
    guard let r = root else { return }
    let left = 2 * i + 1, right = 2 * i + 2
    if left < nodes.count {
        r.left = buildNode(nodes[left])
        buildTree(r.left, nodes, left)
    }
    if right < nodes.count {
        r.right = buildNode(nodes[right])
        buildTree(r.right, nodes, right)
    }
}

func buildNode(_ s: String) -> TreeNode? {
    guard let val = Int(s) else { return nil }
    return TreeNode(val)
}

print(serialize(deserialize("[3,2,5,1,null,4,6]")))
