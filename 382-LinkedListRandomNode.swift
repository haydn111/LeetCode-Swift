// Given a singly linked list, return a random node's value from the linked list. Each node must have the same probability of being chosen.

// Follow up:
// What if the linked list is extremely large and its length is unknown to you? Could you solve this efficiently without using extra space?

// Example:

// Init a singly linked list [1,2,3].
// ListNode head = new ListNode(1);
// head.next = new ListNode(2);
// head.next.next = new ListNode(3);
// Solution solution = new Solution(head);

// getRandom() should return either 1, 2, or 3 randomly. Each element should have equal probability of returning.
// solution.getRandom();


// For every node, increase count by 1, then test random(count) == 0. If true then use curr node. Otherwise keep the old node. Both options has the chance of 1 / count
// For ith item, prob of choose i is 1/i, prob of keep old node is 1 - 1/i
func getRandom(_ head: ListNode) -> Int {
    var count = 1, result = head, curr = head
    while curr.next != nil {
        count += 1
        if arc4random_uniform(count) == 0 { result = curr }
        curr = curr.next
    }
    return result.val
}