// Given n nodes labeled from 0 to n - 1 and a list of undirected edges (each edge is a pair of nodes), write a function to find the number of connected components in an undirected graph.
// Example 1:
//      0          3
//      |          |
//      1 --- 2    4
// Given n = 5 and edges = [[0, 1], [1, 2], [3, 4]], return 2.
// Example 2:
//      0           4
//      |           |
//      1 --- 2 --- 3
// Given n = 5 and edges = [[0, 1], [1, 2], [2, 3], [3, 4]], return 1.
// Note:
// You can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same as [1, 0] and thus will not appear together in edges.


// dfs for each node and mark them as visited. # of components + 1 for each dfs
var graph = [Int: Set<Int>]()
func countComponents(_ n: Int, _ edges: [[Int]]) -> Int {
    for edge in edges {
        if graph[edge[0]] == nil { graph[edge[0]] = Set() }
        if graph[edge[1]] == nil { graph[edge[1]] = Set() }
        graph[edge[0]]!.insert(edge[1])
        graph[edge[1]]!.insert(edge[0])
    }

    var visited = Set<Int>(), count = 0
    for n in graph.keys {
        if !visited.contains(n) {
            dfs(n, &visited)
            count += 1
        }
    }
    return count
}

func dfs(_ curr: Int, _ visited: inout Set<Int>) {
    visited.insert(curr)
    for neighbor in graph[curr]! {
        if !visited.cotains(neighbor) {
            dfs(neighbor, &visited)
        }
    }
}