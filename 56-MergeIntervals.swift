// Given a collection of intervals, merge all overlapping intervals.

// Example 1:

// Input: [[1,3],[2,6],[8,10],[15,18]]
// Output: [[1,6],[8,10],[15,18]]
// Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].
// Example 2:

// Input: [[1,4],[4,5]]
// Output: [[1,5]]
// Explanation: Intervals [1,4] and [4,5] are considerred overlapping.

/**
 * Definition for an interval.
 * public class Interval {
 *   public var start: Int
 *   public var end: Int
 *   public init(_ start: Int, _ end: Int) {
 *     self.start = start
 *     self.end = end
 *   }
 * }
 */
func merge(_ intervals: [Interval]) -> [Interval] {
    var sortedIntervals = intervals.sorted(by: { $0.start < $1.start })
    var i = 0
    while i < sortedIntervals.count - 1 {
        if (sortedIntervals[i].end >= sortedIntervals[i + 1].start) {
            if (sortedIntervals[i + 1].end > sortedIntervals[i].end) {
                sortedIntervals[i].end = sortedIntervals[i + 1].end
            }
            sortedIntervals.remove(at: i + 1)
        } else {
            i += 1
        }
    }
    return sortedIntervals
}
