// Given a non-negative integer represented as non-empty a singly linked list of digits, plus one to the integer.
// You may assume the integer do not contain any leading zero, except the number 0 itself.
// The digits are stored such that the most significant digit is at the head of the list.
// Example:
// Input:
// 1->2->3

// Output:
// 1->2->4


// Use two pointer, j to travel the linkedlist, i to track the last non 9 digit position. Add 1 to i, and set the rest digits 0.

// Complexity：time O(N), space O(1)
func plusOne(_ head: ListNode) -> ListNode {
    var i: ListNode? = nil, j: ListNode? = head
    while j != nil {
        if j!.val < 9 { i = j }
        j = j!.next
    }
    var newHead = head
    if i == nil {   // all list are 9's. insert 1 to head and set every node to 0
        i = ListNode(1)
        i!.next = head
        newHead = i!
    }
    if i!.next == nil {
        i!.val += 1
    } else {
        while i!.next != nil {
            i = i!.next
            i!.val = 0
        }
    }
    return newHead
}
