class SetNode {
    var val: Int
    var parent: SetNode   // value of parent
    var treeSize: Int    // size of the tree rooted by this node "union by weight"

    init(_ value: Int) {
        val = value
        parent = self
        treeSize = 1
    }
}

class DisjointSet { // assume the set element is Int
    var nodes = [Int: SetNode]()    // value: node
    var treeCount = 0
    var nodeCount: Int {
        return nodes.values.count
    }

    func contains(_ i: Int) -> Bool {
        return nodes[i] != nil
    }

    func insert(_ i: Int) {     // O(1)
        nodes[i] = SetNode(i)
        treeCount += 1
    }

    func find(_ i: Int) -> Int? {   // find the root of i, worst O(n), best O(1)
        if let node = nodes[i] {
            if node.parent != node {
                node.parent = find(node.parent.val) // path compression
            } else {
                return node.val
            }
        } else {
            return nil
        }
    }

    func union(_ a: Int, _ b: Int) {    // union the sets that a and b are in, complexity same as find(_:)
        guard let parentA = find(a), let parentB = find(b),
                let rootA = nodes[parentA], let rootB = nodes[parentB] else { 
            return 
        }
        if rootA.size < rootB.size {
            rootA.parent = rootB
            rootB.size += rootAq.size
        } else {
            rootB.parent = rootA
            rootA.size += rootB.size
        }
        treeCount -= 1
    }
}