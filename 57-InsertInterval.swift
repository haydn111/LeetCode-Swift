// Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary).

// You may assume that the intervals were initially sorted according to their start times.

// Example 1:

// Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
// Output: [[1,5],[6,9]]

// Example 2:

// Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
// Output: [[1,2],[3,10],[12,16]]
// Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].

public class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
      self.start = start
      self.end = end
    }
}

func insert(_ intervals: [Interval], _ newInterval: Interval) -> [Interval] {
    if intervals.count == 0 { return [newInterval] }
    var myIntervals = intervals
    var i = 0
    while i < myIntervals.count && myIntervals[i].start < newInterval.start { i += 1 }
    myIntervals.insert(newInterval, at: i)
    
    var j = i == 0 ? 1 : i
    while j < myIntervals.count - 1 {
        if myIntervals[j].end >= myIntervals[j + 1].start { 
            if myIntervals[j].end < myIntervals[j + 1].end { 
                myIntervals[j].end = myIntervals[j + 1].end 
            }
            myIntervals.remove(at: j + 1)
        } else if j > i + 1 {
            break
        } else {
            j += 1
        }
    }
    return myIntervals
}