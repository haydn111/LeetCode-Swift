// Given the running logs of n functions that are executed in a nonpreemptive single threaded CPU, find the exclusive time of these functions.

// Each function has a unique id, start from 0 to n-1. A function may be called recursively or by another function.

// A log is a string has this format : function_id:start_or_end:timestamp. For example, "0:start:0" means function 0 starts from the very beginning of time 0. "0:end:0" means function 0 ends to the very end of time 0.

// Exclusive time of a function is defined as the time spent within this function, the time spent by calling other functions should not be considered as this function's exclusive time. You should return the exclusive time of each function sorted by their function id.

// Example 1:
// Input:
// n = 2
// logs = 
// ["0:start:0",
//  "1:start:2",
//  "1:end:5",
//  "0:end:6"]
// Output:[3, 4]
// Explanation:
// Function 0 starts at time 0, then it executes 2 units of time and reaches the end of time 1. 
// Now function 0 calls function 1, function 1 starts at time 2, executes 4 units of time and end at time 5.
// Function 0 is running again at time 6, and also end at the time 6, thus executes 1 unit of time. 
// So function 0 totally execute 2 + 1 = 3 units of time, and function 1 totally execute 4 units of time.
// Note:
// Input logs will be sorted by timestamp, NOT log id.
// Your output should be sorted by function id, which means the 0th element of your output corresponds to the exclusive time of function 0.
// Two functions won't start or end at the same time.
// Functions could be called recursively, and will always end.
// 1 <= n <= 100

func exclusiveTime(_ n: Int, _ logs: [String]) -> [Int] {
    if n == 0 { return [] }
    var times = Array(repeating: 0, count: n)
    var myLogs = logs
    var stack = [Int]() // stack of func number
    var prevTime = 0, prevState = "end"
    while myLogs.count > 0 {
        var line = myLogs.removeFirst().split(separator: ":")   // [func #, start/end, time]
        if let funcNum = stack.last {
            // a function's running time inclues both start and end. 
            // E.g. start at 2 end at 5 => run time is 4
            times[funcNum] += Int(line[2])! - prevTime
            if prevState == "start" && line[1] == "end" {   // end - start => time + 1
                times[funcNum] += 1
            } else if prevState == "end" && line[1] == "start" {    // start - end => time - 1
                times[funcNum] -= 1
            }
        }

        if line[1] == "start" {
            stack.append(Int(line[0])!) // push func #
        } else {    // func ends
            stack.removeLast()    // pop func #
        }
        
        prevTime = Int(line[2])!            
        prevState = String(line[1])
        // print(times)
        // print(stack)
        // print(prevTime)
        // print("")
    }

    return times
}

print(exclusiveTime(2, ["0:start:0","1:start:2","1:end:5","0:end:6"]))
print(exclusiveTime(1, ["0:start:0","0:start:2","0:end:5","0:start:6","0:end:6","0:end:7"]))
