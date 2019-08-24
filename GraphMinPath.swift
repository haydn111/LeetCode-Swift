// Min path between two nodes in graph = BFS or Dijkstra
// BFS is O(V), Dijkstra is O(E+VlogV), E is # of edges and V is # of vertices
// BFS only work with unweighted graph. Dijkstra works for weighted and unweighted graph

// for unweighted graph Edge class is not need
class Edge {
    var start: Int
    var end: Int
    var weight: Int

    init(start: Int, end: Int, weight: Int) {
        self.start = start
        self.end = end
        self.weight = weight
    }
}

class Vertex {
    var val: Int
    var outgoingEdges: [Edge]
    var incomingEdges: [Edge]

    init(_ value: Int) {
        val = value
        outgoingEdges = []
        incomingEdges = []
    }
}

// assume graph is given as list of edges
// edge = [start, end, weight]

func buildGraph(_ edges: [[Int]]) -> [Int: Vertex] {
    var graph = [Int: Vertex]()
    for edge in edges {
        let edge = Edge(start: edge[0], end: edge[1], weight: edge[2])
        if graph[edge.start] == nil { graph[edge.start] = Vertex(edge.start) }
        if graph[edge.end] == nil { graph[edge.end] = Vertex(edge.end) }
        graph[edge.start]!.outgoingEdges.append(edge)
        graph[edge.end]!.incomingEdges.append(edge)
    }
    return graph
}

var edges = [[1, 2, 7], [1, 3, 9], [1, 6, 14], [2, 3, 10], [2, 4, 15], [3, 4, 11], [3, 6, 2], [4, 5, 6], [5, 6, 9]]
var directedWeightedGraph = buildGraph(edges)

// This is for acyclic graph    O(n)
func dijkstra(_ v1: Int, _ v2: Int) -> [Int] {  // /ˈdaɪkstrə/
    var shortestedDistance = [Int: Int]()   // [Node: Distance]
    for node in directedWeightedGraph.keys {
        shortestedDistance[node] = Int.max
    }
    shortestedDistance[v1] = 0

    var prevNode = [Int: Int]()    // [Node: Its prev node in shortested path]
    var queue = [v1]
    var visited = [Int]()

    while queue.count > 0 {
        let curr = queue.removeLast()
        visited.append(curr)
        for edge in directedWeightedGraph[curr]!.outgoingEdges {
            let next = edge.end
            if !visited.contains(next) {
                queue.insert(next, at: 0)
                if shortestedDistance[curr]! + edge.weight < shortestedDistance[next]! {
                    shortestedDistance[next] = shortestedDistance[curr]! + edge.weight
                    prevNode[next] = curr
                }

                if next == v2 { break }
            }
        }
    }

    var shortestedPath = [Int]()
    var curr: Int? = v2
    while curr != nil {
        shortestedPath.insert(curr!, at: 0)
        curr = prevNode[curr!]
    }
    print(shortestedDistance[v2])
    return shortestedPath
}

print(dijkstra(1, 6))