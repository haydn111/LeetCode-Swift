package algorithms;

import java.util.Comparator;
import java.util.PriorityQueue;

public class LC23_Merge_K_Sorted_List {
    // Merge k sorted linked lists and return it as one sorted list. 
    // Analyze and describe its complexity.

    public class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }

    class NodeComparator implements Comparator<ListNode> {
        @Override
        public int compare(ListNode a, ListNode b) {
            return a.val - b.val;
        }
    }

    // Use a min heap (PriorityQueue). 
    // 1. Push head of lists into the heap
    // 2. Pop smallest node from heap. Push next of the popped out node into heap.
    // 3. Repeat 2 until all k lists are empty. All nodes should already be popped out in ascending order

    // time: O(nklogk), n is avg number of list items. space: O(k), PQ has k elements at most.
    public ListNode mergeKLists(ListNode[] lists) {
        if (lists == null || lists.length == 0) {
            return null;
        }
        
        ListNode head = new ListNode(Integer.MIN_VALUE);    // pre-head of result list
        ListNode current = head;    // current node inserting into result list.
        NodeComparator comparator = new NodeComparator();
        PriorityQueue<ListNode> minHeap = new PriorityQueue(comparator);

        for (int i = 0; i < lists.length; i++) {    // add head of all lists into heap
            if (lists[i] != null) {
                minHeap.add(lists[i]);
            }
        }

        while (minHeap.size() > 0) {
            ListNode node = minHeap.poll();
            current.next = node;
            current = current.next;
            if (node.next != null) {
                minHeap.add(node.next);
            }
        }

        return head.next;
    }
}