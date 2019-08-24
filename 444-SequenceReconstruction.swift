// Check whether the original sequence org can be uniquely reconstructed from the sequences in seqs. The org sequence is a permutation of the integers from 1 to n, with 1 ≤ n ≤ 104. Reconstruction means building a shortest common supersequence of the sequences in seqs (i.e., a shortest sequence so that all sequences in seqs are subsequences of it). Determine whether there is only one sequence that can be reconstructed from seqs and it is the org sequence.

// Example 1:

// Input:
// org: [1,2,3], seqs: [[1,2],[1,3]]

// Output:
// false

// Explanation:
// [1,2,3] is not the only one sequence that can be reconstructed, because [1,3,2] is also a valid sequence that can be reconstructed.
// Example 2:

// Input:
// org: [1,2,3], seqs: [[1,2]]

// Output:
// false

// Explanation:
// The reconstructed sequence can only be [1,2].
// Example 3:

// Input:
// org: [1,2,3], seqs: [[1,2],[1,3],[2,3]]

// Output:
// true

// Explanation:
// The sequences [1,2], [1,3], and [2,3] can uniquely reconstruct the original sequence [1,2,3].
// Example 4:

// Input:
// org: [4,1,5,2,6,3], seqs: [[5,2,6,3],[4,1,5,2]]

// Output:
// true


// 问这些子序列能否唯一的重建出原序列。能唯一重建的意思就是任意两个数字的顺序必须是一致的，不能说在一个子序列中1在4的后面，但是在另一个子序列中1在4的前面，这样就不是唯一的了。
// 还有一点就是，子序列seqs中不能出现其他的数字，就是说必须都是原序列中的数字。
// 我们可以用了hash map来记录org中每个数字对应的位置，然后用verified来标记符合条件的当前数字和其后面一个数字和org中的顺序一致，避免重复验证
// 用count来标记还需要验证顺序的数字的个数，初始化count为n-1，因为n个数字只需要验证n-1对顺序即可，
// 我们先遍历一遍org，将每个数字的位置信息存入map中，
// 然后再遍历子序列中的每一个数字，还是要先判断数字是否越界，然后我们取出当前数字curr，和其后一位置上的数字next，如果在org中，curr在next之后，那么直接返回false。否则我们看如果curr的顺序没被验证过，而且next是在curr的后一个，那么标记curr已验证，且count减1，最后如果count为0了，说明所有顺序被成功验证了
func sequenceReconstruction(_ org: [Int], _ seqs: [[Int]]) -> Bool {
    var orgMap = [Int: Int]()   // num: index in org
    var n = org.count   // org is a permutation of # from 1 to n
    var count = n - 1   // only compare n - 1 consecutive pairs for n #s
    var verified = Set<Int>()   // the order of this # and this # + 1 has been verified
    for i in org {
        orgMap[org[i]] = i
    }

    for seq in seqs {
        for i in 0..<seq.count {
            if seq[i] < 0 || seq[i] > count { return false }    // out of 1...n
            if i == seq.count - 1 { continue }
            let curr = seq[i], next = seq[i + 1]
            if orgMap[curr] >= orgMap[next] { return false }    // out of order in org
            if orgMap[next] - orgMap[curr] == 1 && !verified.contains(seq[i]) {
                verified.insert(seq[i]); count -= 1
            }
        }
        return count == 0
    }
}