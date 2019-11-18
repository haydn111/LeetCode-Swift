// Clone an undirected graph. Each node in the graph contains a label and a list of its neighbors.


// OJ's undirected graph serialization:
// Nodes are labeled uniquely.

// We use # as a separator for each node, and , as a separator for node label and each neighbor of the node.
// As an example, consider the serialized graph {0,1,2#1,2#2,2}.

// The graph has a total of three nodes, and therefore contains three parts as separated by #.

// First node is labeled as 0. Connect node 0 to both nodes 1 and 2.
// Second node is labeled as 1. Connect node 1 to node 2.
// Third node is labeled as 2. Connect node 2 to node 2 (itself), thus forming a self-cycle.
// Visually, the graph looks like the following:

//        1
//       / \
//      /   \
//     0 --- 2
//          / \
//          \_/

class UndirectedGraphNode {
    var val: Int
    var neighbors: [UndirectedGraphNode]

    init(value: Int) {
        val = value
        neighbors = []
    }
}

func cloneGraph(_ node: UndirectedGraphNode?) -> UndirectedGraphNode? {
    if node == nil { return nil }

    var dict = [UndirectedGraphNode: UndirectedGraphNode]()

    // BFS to copy nodes
    var queue = [node!]
    while queue.count > 0 {
        let curr = queue.removeLast()
        dict[curr] = UndirectedGraphNode(value: curr.val)
        for node in curr.neighbors {
            if dict[node] == nil {
                queue.insert(node, at: 0)
            }
        }
    }

    // Build graph edges
    for (key, value) in dict {
        value.neighbors = [UndirectedGraphNode]()
        for node in key.neighbors {
            value.neighbors.append(dict[node])
        }
    }
    return dict[node!]
}

static var nodeDict = [UndirectedGraphNode: UndirectedGraphNode]()
func cloneGraph2(_ node: UndirectedGraphNode?) -> UndirectedGraphNode? {
    if node == nil { return nil }
    dfs[node!]
    return dict[node!]
}

func dfs(_ node: UndirectedGraphNode) {
    let clone = UndirectedGraphNode(node.val)
    clone.neighbors = [UndirectedGraphNode]()
    dict[node] = clone
    for n in node.neighbors {
        if dict[n] == nil {
            dfs(n)
        }
        clone.neighbors.append(dict[n])
    }
}