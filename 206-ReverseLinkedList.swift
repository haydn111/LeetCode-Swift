// Reverse a singly linked list.

// Example:

// Input: 1->2->3->4->5->NULL
// Output: 5->4->3->2->1->NULL
// Follow up:

// A linked list can be reversed either iteratively or recursively. Could you implement both?

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func reverseList(_ head: ListNode?) -> ListNode? {
    return reverseListIterative(head)
}    

func reverseListIterative(_ head: ListNode?) -> ListNode? {
    if head == nil { return nil }
    var prev: ListNode? = nil
    var curr = head
    while curr != nil {
        var next = curr!.next
        curr!.next = prev
        prev = curr
        curr = next
    }
    return prev
}

func reverseListRecurisive(_ curr: ListNode?, _ prev: ListNode?) -> ListNode? {
    if curr == nil { return prev }
    var next = curr!.next
    curr!.next = prev
    return reverseListRecurisive(next, curr)
}
