// For a undirected graph with tree characteristics, we can choose any node as the root. The result graph is then a rooted tree. Among all possible rooted trees, those with minimum height are called minimum height trees (MHTs). Given such a graph, write a function to find all the MHTs and return a list of their root labels.

// Format
// The graph contains n nodes which are labeled from 0 to n - 1. You will be given the number n and a list of undirected edges (each edge is a pair of labels).

// You can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same as [1, 0] and thus will not appear together in edges.

// Example 1 :

// Input: n = 4, edges = [[1, 0], [1, 2], [1, 3]]

//         0
//         |
//         1
//        / \
//       2   3 

// Output: [1]

// Example 2 :

// Input: n = 6, edges = [[0, 3], [1, 3], [2, 3], [4, 3], [5, 4]]

//      0  1  2
//       \ | /
//         3
//         |
//         4
//         |
//         5 

// Output: [3, 4]


// Start from each leaves, keep remove leaves of the graph until there's one or two nodes left
func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
    if n == 0 { return [] }
    if edges.count == 0 { return [0] }
    var graph = [Int: Set<Int>]()
    for edge in edges {
        if graph[edge[0]] == nil { graph[edge[0]] = Set() }
        if graph[edge[1]] == nil { graph[edge[1]] = Set() }
        graph[edge[0]]!.insert(edge[1])
        graph[edge[1]]!.insert(edge[0])
    }
    
    var leaves = Set(graph.keys.filter { graph[$0]!.count == 1 })
    var nodes = Set(graph.keys)
    while nodes.count > 2 {
        print(leaves)
        var newLeaves = Set<Int>()
        for leaf in leaves {
            nodes.remove(leaf)
            let newLeaf = graph[leaf]!.first!
            graph[newLeaf]!.remove(leaf)
            if graph[newLeaf]!.count == 1 { newLeaves.insert(newLeaf) }
        }
        leaves = newLeaves
    }
    return [Int](nodes)
}
