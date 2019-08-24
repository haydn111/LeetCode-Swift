// Given a list of airline tickets represented by pairs of departure and arrival airports [from, to], reconstruct the itinerary in order. All of the tickets belong to a man who departs from JFK. Thus, the itinerary must begin with JFK.

// Note:

// If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
// All airports are represented by three capital letters (IATA code).
// You may assume all tickets form at least one valid itinerary.
// Example 1:

// Input: tickets = [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
// Output: ["JFK", "MUC", "LHR", "SFO", "SJC"]
// Example 2:

// Input: tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
// Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
// Explanation: Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"]. But it is larger in lexical order.


// Problem is equivalent to find the Eulerian path with Hierholzer's algorithm. First keep going forward until you get stuck (i.e. there's not availabe outgoing edge at some node). Then backoff and visit other edges of the second last node in the current path. Writing down the path backwards when retreating from recursion.
// To achieve the lexical order, use a heap to store the destination of each flight for each departure
// O(nlogn), Memorize the recursive dfs part.
class Solution {
    var graph = [String: MinHeap]()
    var result = [String]()
    func findItinerary(_ tickets: [[String]]) -> [String] {
        // build the graph
        for tkt in tickets {
            if graph[tkt[0]] == nil { graph[tkt[0]] = MinHeap() }
            graph[tkt[0]]!.insert(HeapNode(tkt[1]))
        }
        visit("JFK")
        return result
    }

    func visit(_ airport: String) {
        while let heap = graph[airport], heap.count > 0 {
            visit(heap.removeMin()!.val)
        }
        result.insert(airport, at: 0)
    }
}

class HeapNode {
    var val: String
    init(_ val: String) {
        self.val = val
    }
}

class MinHeap {
    var nums = [HeapNode]()
    var count: Int {
        return nums.count
    }
    
    func insert(_ n: HeapNode) {
        nums.append(n)
        // shift up
        var i = nums.count - 1
        while let parent = parent(of: i), nums[parent].val > n.val {
            nums.swapAt(i, parent)
            i = parent
        }
    }
    
    func removeMin() -> HeapNode? {
        if nums.count == 0 { return nil }
        nums.swapAt(0, nums.count - 1)
        let min = nums.removeLast()
        // shift down
        var i = 0
        var left = leftChild(of: i)
        var right = rightChild(of: i)
        while (left != nil && nums[i].val > nums[left!].val) || 
                (right != nil && nums[i].val > nums[right!].val) {
            var min = minChild(left, right)!
            nums.swapAt(i, min) 
            i = min
            left = leftChild(of: i)
            right = rightChild(of: i)
        }
        return min
    }
    
    private func parent(of i: Int) -> Int? {
        return (i - 1) / 2 >= 0 ? (i - 1) / 2 : nil
    }
    
    private func leftChild(of i: Int) -> Int? {
        return 2 * i + 1 < nums.count ? 2 * i + 1 : nil
    }
    
    private func rightChild(of i: Int) -> Int? {
        return 2 * i + 2 < nums.count ? 2 * i + 2 : nil
    }  
    
    private func minChild(_ i1: Int?, _ i2: Int?) -> Int? {
        if i1 == nil { return i2 }
        if i2 == nil { return i1 }
        return nums[i1!].val < nums[i2!].val ? i1! : i2!
    }
}