/*
Given n nodes labeled from 0 to n - 1 and a list of undirected edges (each edge is a pair of nodes), write a function to check whether these edges make up a valid tree.

For example:

Given n = 5 and edges = [[0, 1], [0, 2], [0, 3], [1, 4]], return true.

Given n = 5 and edges = [[0, 1], [1, 2], [2, 3], [1, 3], [1, 4]], return false.

Hint:

Given n = 5 and edges = [[0, 1], [1, 2], [3, 4]], what should your return? Is this case a valid tree?
According to the definition of tree on Wikipedia: “a tree is an undirected graph in which any two vertices are connected by exactly one path. In other words, any connected graph without simple cycles is a tree.”
Note: you can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same as [1, 0] and thus will not appear together in edges.
*/

// Graph Tree Validation Problem:
// Definition: Any acyclic connected graph is a tree
// Important tree attribute: connected -> # of edge = # of nodes - 1
// Solution:
//     Directed graph:
//         1. (Build graph and) Find root (outgoing only edge). If there is more than one root, fail.
//         2. Cycle detection with DFS. If there is cycle, fail.
//         3. After traversal if there is any unvisited nodes (not connected), fail.

//     Undirected graph: (Identify root is generally impossible)
//         1. Cycle detection with DFS and the "from" side of the edge, or disjoint set
//         2. Check if all nodes are visited

var n = 5
var edges1 = [[0, 1], [0, 2], [0, 3], [1, 4]]
var edges2 = [[0, 1], [1, 2], [2, 3], [1, 3], [1, 4]]

class UndirectedGraph {
    var visited = Set<Int>()
    var graph = [Int: Set<Int>]()

    func buildUndirectedGraph(with edges: [[Int]]) {
        graph = [Int: Set<Int>]()  // node: edges
        for edge in edges {
            if graph[edge[0]] == nil { graph[edge[0]] = Set<Int>() }
            graph[edge[0]]!.insert(edge[1])
            if graph[edge[1]] == nil { graph[edge[1]] = Set<Int>() }
            graph[edge[1]]!.insert(edge[0])
        }
    }

    func undirectedValidTree(_ n: Int, _ edges: [[Int]]) -> Bool {
        graph = [Int: Set<Int>]()
        visited = Set<Int>()
        if edges.count == 0 || edges.count != n - 1 { return false }
        buildUndirectedGraph(with: edges)
        return dfsValidate(edges[0][0], from: Int.min) && n == visited.count
    }

    func dfsValidate(_ node: Int, from: Int) -> Bool {  // false = has cycle
        visited.insert(node)
        for n in graph[node]! {
            if n != from { 
                if visited.contains(n) { return false }
                dfsValidate(n, from: node) 
            }
        }
        return true
    }

    // This method use Disjoint Set
    func disjointSetValidTree(_ edges: [[Int]]) -> Bool {
        let ds = DisjointSet()
        for edge in edges {
            if !ds.contains(edge[0]) { ds.insert(edge[0]) }
            if !ds.contains(edge[1]) { ds.insert(edge[1]) }
            let p0 = find(edge[0]), p1 = find(edge[1])
            if p0 == p1 { return false }
            ds.union(p0, p1)
        }
        return ds.treeCount == 1
    }
}

print(UndirectedGraph().undirectedValidTree(n, edges1))

// ========================================================================== //

class DirectedGraphNode {
    var value: Int
    var from = [Int]()
    var to = [Int]()
    
    init(value: Int) {
        self.value = value
    }
}

class DirectedGraph {
    var visited = Set<Int>()
    var directedGraph = [Int: DirectedGraphNode]()

    func buildDirectedGraph(with edges: [[Int]]) {
        for edge in edges {
            if directedGraph[edge[0]] == nil { directedGraph[edge[0]] = DirectedGraphNode(value: edge[0]) }
            directedGraph[edge[0]]!.to.append(edge[1])
            if directedGraph[edge[1]] == nil { directedGraph[edge[1]] = DirectedGraphNode(value: edge[1]) }
            directedGraph[edge[1]]!.from.append(edge[0])
        }
    }

    func directedValidTree(_ n: Int, _ edges: [[Int]]) -> Bool {
        if edges.count == 0 || edges.count != n - 1 { return false }
        directedGraph = [Int: DirectedGraphNode]()
        buildDirectedGraph(with: edges)
        var root: Int? = nil
        for node in directedGraph.values {
            if node.from.count == 0 {
                if root != nil { return false } // more than one root found
                root = node.value
            }
        }
        guard let r = root else { return false }     // cannot find a root
        return dfsValidate(r) && visited.count == n
    }

    func dfsValidate(_ node: Int) -> Bool {
        visited.insert(node)
        for to in directedGraph[node]!.to {
            if visited.contains(to) { return false }
            dfsValidate(to)
        }
        visited.remove(node)
        return true
    }
}
