// Given a list of strings, you need to find the longest uncommon subsequence among them. The longest uncommon subsequence is defined as the longest subsequence of one of these strings and this subsequence should not be any subsequence of the other strings.

// A subsequence is a sequence that can be derived from one sequence by deleting some characters without changing the order of the remaining elements. Trivially, any string is a subsequence of itself and an empty string is a subsequence of any string.

// The input will be a list of strings, and the output needs to be the length of the longest uncommon subsequence. If the longest uncommon subsequence doesn't exist, return -1.


// The optimal length subsequence (if it exists) is always going to be the length of some string in the array. 
// Sort the strings in the reverse order. 
// For each non-duplicate string, check if the string is a subsequence of all the strings longer than (before) itself. If it's not, that is the answer.

extension String {
    func isSubsequence(of str: String) {
        var i = startIndex
        for char in str {
            if self[i] == char {
                i = index(after: i)
                if i == endIndex { return true }
            }
        }
        return false
    }
}

func findLUSlength(_ strs: [String]) -> Int {
    if strs.count == 0 { return -1 }

    var strSet = Set<String>(), dupSet = Set<String>()
    for str in strs {
        if strSet.contains(str) {
            dupSet.insert(str)
        }
        strSet.insert(str)
    }

    var sortedStrs = strs.sorted(by: {
        $0.count > $1.count
    })

    for i in 0..<sortedStrs.count {
        if dupSet.contains(sortedStrs[i]) { continue }
        var isSubseq = false
        for j in 0..<i {
            if sortedStrs[i].isSubsequence(of: sortedStrs[j]) { 
                isSubseq = true
                break
            }
        }
        if !isSubseq { return sortedStrs[i].count }
    }
    return -1
}
