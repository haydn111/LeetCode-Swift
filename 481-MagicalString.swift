// A magical string S consists of only '1' and '2' and obeys the following rules:

// The string S is magical because concatenating the number of contiguous occurrences of characters '1' and '2' generates the string S itself.

// The first few elements of string S is the following: S = "1221121221221121122……"

// If we group the consecutive '1's and '2's in S, it will be:

// 1 22 11 2 1 22 1 22 11 2 11 22 ......

// and the occurrences of '1's or '2's in each group are:

// 1 2	2 1 1 2 1 2 2 1 2 2 ......

// You can see that the occurrence sequence above is the S itself.

// Given an integer N as input, return the number of '1's in the first N number in the magical string S.

// Note: N will not exceed 100,000.

// Example 1:
// Input: 6
// Output: 3
// Explanation: The first 6 elements of magical string S is "12211" and it contains three 1's, so return 3.


/*
Init s = "122", occ = "12", charToAdd = "1"
To generate s, first append a digit to occ. Then append 1 or 2 charToAdd to s. Toggle charToAdd for next round
To optimize, make all of the above global variables. Only generate s when going forward. If n < s.count then just use s[0..<n] to give the answer.
*/

var s = "122", occ = "12", result = 1
var char = "1", sCount = 3, occCount = 2
func magicalString(_ n: Int) -> Int {
    if n == 0 { return 0 }
    if n <= sCount { return s[0..<n].filter{ $0 == "1" }.count }
    while sCount < n {
        var nextCount = Int(String(s[occCount]))!
        occ.append(s[occCount])
        occCount += 1
        while sCount < n && nextCount > 0 {
            s.append(char); nextCount -= 1
            sCount += 1
            if char == "1" { result += 1 }
        }
        char = char == "1" ? "2" : "1"
    }
    return result
}
