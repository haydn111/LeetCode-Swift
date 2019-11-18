// Given two strings S and T, determine if they are both one edit distance apart.

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

func isOneEditDistance(_ s: String, _ t: String) -> Bool {
    if abs(s.count - t.count) > 1 { return false }
    var sPtr = 0, tPtr = 0 
    var hasDoneWorkaround = false
    while sPtr < s.count, tPtr < t.count {
        if s[sPtr] != t[tPtr] {
            if hasDoneWorkaround { return false }
            if s.count == t.count {
                sPtr += 1; tPtr += 1
            } else if s.count > t.count {
                sPtr += 1
            } else {    // t.count > s.count
                tPtr += 1
            }
            hasDoneWorkaround = true
        } else {
            sPtr += 1; tPtr += 1
        }
    }
    return true
}

print(isOneEditDistance("abab", "abba"))