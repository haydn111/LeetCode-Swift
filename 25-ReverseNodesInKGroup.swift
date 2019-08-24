// Given a linked list, reverse the nodes of a linked list k at a time and return its modified list.

// k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes in the end should remain as it is.

// Example:

// Given this linked list: 1->2->3->4->5

// For k = 2, you should return: 2->1->4->3->5

// For k = 3, you should return: 3->2->1->4->5

// Note:

// Only constant extra memory is allowed.
// You may not alter the values in the list's nodes, only nodes itself may be changed.

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    var curr = head
    var newHead = ListNode(Int.max) // dummy head
    var newTail = newHead   // track the last of reversed list
    while curr != nil {
        let (subHead, subTail) = findSublist(from: curr, size: k)
        if subHead != nil && subTail != nil {
            curr = subTail!.next
            subTail!.next = nil
            let (revSubHead, revSubTail) = reverseList(subHead)
            newTail.next = revSubHead
            newTail = revSubTail!
        } else {
            newTail.next = curr
            return newHead.next
        }
    }
    return newHead.next
}

func findSublist(from: ListNode?, size k: Int) -> (ListNode?, ListNode?) {    // (head, tail)  
    if from == nil { return (nil, nil) }
    var curr = from
    for i in 1..<k {
        if curr == nil { return (from, nil) }
        curr = curr!.next
    }
    return (from, curr)
}

func reverseList(_ head: ListNode?) -> (ListNode?, ListNode?) { // (head, tail)
    if head == nil { return (nil, nil) }
    var tail = head
    var prev: ListNode? = nil
    var curr = head
    while curr != nil {
        var next = curr!.next
        curr!.next = prev
        prev = curr
        curr = next
    }
    return (prev, tail)
}
