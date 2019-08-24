// You are playing the following Flip Game with your friend: Given a string that contains only these two characters: + and -, you and your friend take turns to flip twoconsecutive "++" into "--". The game ends when a person can no longer make a move and therefore the other person will be the winner.

// Write a function to determine if the starting player can guarantee a win.

// For example, given s = "++++", return true. The starting player can guarantee a win by flipping the middle "++" to become "+--+".

// Follow up:
// Derive your algorithm's runtime complexity.

// Time O(n^n)
func canWin(_ s: String, _ isStarter: Bool) -> Bool {
    if s.range(of: "++") == nil { return !isStarter }
    var i = s.startIndex, result = false
    while s.index(after: i) < s.endIndex {
        let next = s.index(after: i)
        if s[i] == "+" && s[next] == "+" {
            var nextS = s; nextS.replaceSubrange(i...next, with: "--")
            result = result || canWin(nextS, !isStarter)
        }
        i = next
    }
    return result
}
