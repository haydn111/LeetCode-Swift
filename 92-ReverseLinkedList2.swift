// Reverse a linked list from position m to n. Do it in one-pass.

// Note: 1 ≤ m ≤ n ≤ length of list.

// Example:

// Input: 1->2->3->4->5->NULL, m = 2, n = 4
// Output: 1->4->3->2->5->NULL

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        if head == nil || m == n { return head }
        
        var beforeM: ListNode? = nil
        var nodeM = head
        var curr = head
        var prev: ListNode? = nil
        var next = head?.next
        var count = 0
        for i in 1...m {
            prev = curr
            curr = curr?.next
            next = curr?.next
            if i == m - 1 {
                nodeM = curr
                beforeM = prev
            }
        }
        for i in m + 1...n {
            curr?.next = prev
            prev = curr
            curr = next
            next = curr?.next
        }
        beforeM?.next = prev
        nodeM?.next = curr
        if m == 1 { return prev }
        return head
    }
}