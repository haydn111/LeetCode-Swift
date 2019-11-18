// Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei), find the minimum number of conference rooms required.

// For example,
// Given [[0, 30],[5, 10],[15, 20]],
// return 2.

func meetingRooms2(_ meetings: [[Int]]) -> Int {
    var sortedMettings = meetings.sorted(by: {
        $0[0] < $1[0]
    })
    
    var i = 0
    while i < sortedMettings.count - 1 {
        if sortedMettings[i][1] < sortedMettings[i + 1][0] {
            sortedMettings.remove(at: i)
        } else {
            i += 1
        }
    }
    
    return sortedMettings.count
}

print(meetingRooms2([[0, 30],[5, 10],[15, 20]]))