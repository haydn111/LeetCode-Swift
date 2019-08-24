// Implement a MyCalendar class to store your events. A new event can be added if adding the event will not cause a double booking.

// Your class will have the method, book(int start, int end). Formally, this represents a booking on the half open interval [start, end), the range of real numbers x such that start <= x < end.

// A double booking happens when two events have some non-empty intersection (ie., there is some time that is common to both events.)

// For each call to the method MyCalendar.book, return true if the event can be added to the calendar successfully without causing a double booking. Otherwise, return false and do not add the event to the calendar.

// Your class will be called like this: MyCalendar cal = new MyCalendar(); MyCalendar.book(start, end)

// Example 1:
// MyCalendar();
// MyCalendar.book(10, 20); // returns true
// MyCalendar.book(15, 25); // returns false
// MyCalendar.book(20, 30); // returns true

// Explanation: 
// The first event can be booked.  The second can't because time 15 is already booked by another event.
// The third event can be booked, as the first event takes every time less than 20, but not including 20.

// Note:
// The number of calls to MyCalendar.book per test case will be at most 1000.
// In calls to MyCalendar.book(start, end), start and end are integers in the range [0, 10^9].


// The following solution can be shortened because the chronological order of array doesn't have to be maintained.
// Maintain the existing events as an array ranges sorted by start time. Since none of them should overlap, for each two consecutive ranges, end1 <= start2 must be true
//     - if start == end, range has 0 length, it's not overlap with any other range
//     - if end <= start of first range, it's the new first event
//     - if start >= end of last range, it's the new last event
//     - else loop thru the ranges and find if the new range can be fitted into the middle of any two consecutive ranges.
class MyCalendar {
    var calendar = [(Int, Int)]()   // should be sorted by start time
    
    func book(_ start: Int, _ end: Int) -> Bool {
        if calendar.count == 0 {
            calendar.append((start, end))
            return true
        }
        if start == end {   // range has 0 length, does not intersect with anyone
            return true
        }
        
        var (s, e) = calendar.first!
        if s >= end {   // before first one ? 
            calendar.insert((start, end), at: 0)
            return true
        }

        var i = 0
        while i + 1 < calendar.count {
            let (s1, e1) = calendar[i], (s2, e2) = calendar[i + 1]
            if e1 <= start && s2 >= end {   // there exist two ranges that the new range can fit in the middle
                calendar.insert((start, end), at: i + 1)
                return true
            }
            i += 1
        }
        
        (s, e) = calendar.last!
        if start >= e { // after last one ?
            calendar.append((start, end))
            return true
        }
        return false
    }
}

print(book(10, 20)) // t
print(book(15, 25)) // f
print(book(20, 30)) // t
print(book(0, 9))   // t
print(book(9, 9))   // t
print(book(9, 10))  // t
