// There are a total of n courses you have to take, labeled from 0 to n-1.

// Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]

// Given the total number of courses and a list of prerequisite pairs, return the ordering of courses you should take to finish all courses.

// There may be multiple correct orders, you just need to return one of them. If it is impossible to finish all courses, return an empty array.

// Example 1:

// Input: 2, [[1,0]] 
// Output: [0,1]
// Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1] .

// Example 2:

// Input: 4, [[1,0],[2,0],[3,1],[3,2]]
// Output: [0,1,2,3] or [0,2,1,3]
// Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0. So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].


class Solution {
    var allVisited = Set<Int>()
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        // build graph [course: [prereqs]] and find roots (final courses)
        var roots = Set<Int>(0...numCourses - 1)
        var graph = [Int: Set<Int>]()
        for p in prerequisites {
            if graph[p[0]] == nil { graph[p[0]] = Set() }
            graph[p[0]]!.insert(p[1])
            roots.remove(p[1])
        }
                
        // dfs for each course dependency tree
        // cycle detected => deadlock, cannot finish course
        var result = [Int]()
        for root in roots {
            var visited = Set<Int>()
            if dfs(graph, root, &visited, &result) { return [] }
        }
        return allVisited.count == numCourses ? result : []
    }
    
    func dfs(_ graph: [Int: Set<Int>], _ root: Int, _ visited: inout Set<Int>, _ result: inout [Int]) -> Bool {
        var hasCycle = false
        allVisited.insert(root)
        if let prereqs = graph[root] {
            visited.insert(root)
            for prereq in prereqs {
                if !visited.contains(prereq) { 
                    hasCycle = hasCycle || dfs(graph, prereq, &visited, &result)
                } else {
                    return true
                }
            }
            visited.remove(root)
        }
        if !result.contains(root) { result.append(root) }
        return hasCycle
    }
}