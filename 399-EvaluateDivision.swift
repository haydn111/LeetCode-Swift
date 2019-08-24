// Equations are given in the format A / B = k, where A and B are variables represented as strings, and k is a real number (floating point number). Given some queries, return the answers. If the answer does not exist, return -1.0.

// Example:
// Given a / b = 2.0, b / c = 3.0. 
// queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ? . 
// return [6.0, 0.5, -1.0, 1.0, -1.0 ].

// The input is: vector<pair<string, string>> equations, vector<double>& values, vector<pair<string, string>> queries , where equations.size() == values.size(), and the values are positive. This represents the equations. Return vector<double>.

// According to the example above:

// equations = [ ["a", "b"], ["b", "c"] ],
// values = [2.0, 3.0],
// queries = [ ["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"] ]. 
// The input is always valid. You may assume that evaluating the queries will result in no division by zero and there is no contradiction.

// For each A / B = k, insert edges A - k -> B and B - (1/k) -> A into graph. 
// For each query, do dfs from A see if can find B in graph.
class Solution {
    class Edge {
        var from: String
        var to: String
        var value: Double
        init(_ from: String, _ to: String, _ value: Double) {
            self.from = from
            self.to = to
            self.value = value
        }
    }
    
    var graph = [String: [Edge]]()  // [variable: [outgoing_edges]]
    
    func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        parseGraph(equations, values)
        return parseQueries(queries)
    }
    
    func parseGraph(_ equations: [[String]], _ values: [Double]) {
        graph = [String: [Edge]]()
        var i = 0
        while i < equations.count {
            let op1 = equations[i][0], op2 = equations[i][1], res = values[i]
            // insert op1 / op2 = value
            let edge1 = Edge(op1, op2, res)
            if graph[op1] == nil { graph[op1] = [Edge]() }
            graph[op1]!.append(edge1)
            
            // insert op2 / op1 = (1 / value)
            let edge2 = Edge(op2, op1, 1 / res)
            if graph[op2] == nil { graph[op2] = [Edge]() }
            graph[op2]!.append(edge2)
            i += 1
        }
    }
    
    func parseQueries(_ queries: [[String]]) -> [Double] {
        var results = [Double](), i = 0
        while i < queries.count {
            var result = -1.0
            if graph[queries[i][0]] != nil && graph[queries[i][1]] != nil {
                var visited = Set<String>()
                dfs(queries[i][0], queries[i][1], &visited, 1, &result)
            }
            results.append(result)
            i += 1
        }
        return results
    }
    
    func dfs(_ start: String, _ end: String, _ visited: inout Set<String>, _ product: Double, _ result: inout Double) {
        if start == end { result = product; return }
        visited.insert(start)
        for edge in graph[start]! {
            if !visited.contains(edge.to) {
                dfs(edge.to, end, &visited, product * edge.value, &result)
            }
        }
        visited.remove(start)
    }
}