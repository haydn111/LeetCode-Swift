// Sort a linked list in O(n log n) time using constant space complexity.

// Example 1:

// Input: 4->2->1->3
// Output: 1->2->3->4

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func sortList(_ head: ListNode?) -> ListNode? {
    if head == nil || head?.next == nil { return head }
    return merge(sortList(findMid(head)), sortList(head))
}

func findMid(_ head: ListNode?) -> ListNode? {  // "fast and slow pointers"
    if head == nil { return nil }
    var pFast = head, pSlow = head
    while pFast?.next?.next != nil {
        pFast = pFast?.next?.next
        pSlow = pSlow?.next
    }
    pFast = pSlow?.next
    pSlow?.next = nil
    return pFast
}

func merge(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    if l1 == nil { return l2 }
    if l2 == nil { return l1 }
    if l1!.val < l2!.val {
        l1!.next = merge(l1!.next, l2)
        return l1
    }
    else {
        l2!.next = merge(l1, l2!.next)
        return l2
    }
}

var n4 = ListNode(4), n3 = ListNode(3), n1 = ListNode(1)
n4.next = n1
n1.next = n3
print(sortList(n4))