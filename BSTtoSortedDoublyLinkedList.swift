public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
    }
}

func BSTtoSortedDLL(_ root: TreeNode?) -> TreeNode? {
    if root == nil { return nil }
    let (head, _) = buildList(root!)
    return head
}

func buildList(_ root: TreeNode) -> (TreeNode, TreeNode) {
    print(root.val, root.left?.val, root.right?.val)
    var head = root, tail = root
    if root.left != nil {
        let (lHead, lTail) = buildList(root.left!)
        lTail.right = root
        root.left = lTail
        head = lHead
    }
    if root.right != nil { 
        let (rHead, rTail) = buildList(root.right!)
        root.right = rHead
        rHead.left = root
        tail = rTail
    }
    head.left = tail
    tail.right = head
    print(head.val, tail.val)
    return (head, tail)
}

// Test
func validDLL(_ n: Int, _ head: TreeNode) -> Bool {
    var curr = head
    for _ in 0..<n {
        print(curr.val)
        if curr.right?.left == nil || (curr.right!.left!) != curr { return false }
        if curr.left?.right == nil || (curr.left!.right!) != curr { return false }
        curr = curr.right!
    }
    return true
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

var tree = deserialize("[3,2,5,1,null,4,6]")
var list = BSTtoSortedDLL(tree)
print(validDLL(6, list))