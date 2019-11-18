// Given an directed graph, it's known that it has one extra edge. Upon the removal of this extra edge, this graph becomes a n-ary tree.

// In this problem, a rooted tree is a directed graph such that, there is exactly one node (the root) for which all other nodes are descendants of this node, plus every node has exactly one parent, except for the root node which has no parents.

// The given input is a directed graph that started as a rooted tree with N nodes (with distinct values 1, 2, ..., N), with one additional directed edge added. The added edge has two different vertices chosen from 1 to N, and was not an edge that already existed.

// The resulting graph is given as a 2D-array of edges. Each element of edges is a pair [u, v] that represents a directed edge connecting nodes u and v, where u is a parent of child v.

// Return an edge that can be removed so that the resulting graph is a rooted tree of N nodes. If there are multiple answers, return the answer that occurs last in the given 2D-array.

// Example 1:
// Input: [[1,2], [1,3], [2,3]]
// Output: [2,3]
// Explanation: The given directed graph will be like this:
//   1
//  / \
// v   v
// 2-->3
// Example 2:
// Input: [[1,2], [2,3], [3,4], [4,1], [1,5]]
// Output: [4,1]
// Explanation: The given directed graph will be like this:
// 5 <- 1 -> 2
//      ^    |
//      |    v
//      4 <- 3

// Note:
// The size of the input 2D-array will be between 3 and 1000.
// Every integer represented in the 2D-array will be between 1 and N, where N is the size of the input array.

// Try input:
// 5 -> 1 -> 3 -> 2
// |    ^
// |    |
//   -> 4 -> 6
// [[5, 4], [5, 1], [4, 1], [1, 3], [3, 2]]

/*
Two cases to consider:
1. If the graph has cycle then remove the last edge that form the cycle
2. If the graph does not have cycle, there must be a node have to inbound edges. Remove one of them in the specified order.

- To find candidate edges in case 2, keep track # of parent for each node.
- Use dfs to detect cycle in directed graph. Pay attention to push/pop visited set.
- To determine the start node of dfs, if there's a node with outbound edges only (true root) then use it. Otherwise, choose the node that has most # of outbound edges (possible root)
*/
func findRedundantDirectedConnection(_ edges: [[Int]]) -> [Int] {
    var graph = [Int: [Int]](), parent = [Int: Int]()
    var candidates = [[Int]]()  // candidate edges to be removed. There's either 0 or 2
    var rootCandidate = 1   // root candidate is the node has the most outgoing edges
    var roots = Set(1...edges.count)    // root has not inbound edges
    for edge in edges {
        let v1 = edge[0], v2 = edge[1]
        if graph[v1] == nil { graph[v1] = [] }
        graph[v1]!.append(v2)
        
        if graph[rootCandidate] == nil || graph[rootCandidate]!.count < graph[v1]!.count {
            rootCandidate = v1
        }
        
        roots.remove(v2)
        
        if parent[v2] == nil { parent[v2] = v1 }
        else { // v2 have two parents
            candidates = [edge, [parent[v2]!, v2]]
        }
    }
    
    let root = roots.count > 0 ? roots.first! : rootCandidate   // if have a root, use it, otherwise choose a node with most outgoing edges to start.
    var visited = Set<Int>(), result = [Int]()
    dfs(root, &visited, &graph, &candidates, &result)   // find the solution if there's cycle
    if result.count == 0 {  // if there's no cycle simply remove last candidate edge in edges
        for i in stride(from: edges.count - 1, through: 0, by: -1) {
            for edge in candidates {    // should only have 2 edges
                if edge.elementsEqual(edges[i]) { return edge }
            }
        }
    }
    return result
}

func dfs(_ curr: Int, _ visited: inout Set<Int>, _ graph: inout [Int: [Int]], _ candidates: inout [[Int]], _ result: inout [Int]) {
    if result.count > 0 { return }
    visited.insert(curr)
    for next in graph[curr] ?? [] {
        if visited.contains(next) { result = [curr, next]; return }
        else { dfs(next, &visited, &graph, &candidates, &result) }
    }
    visited.remove(curr)
}

