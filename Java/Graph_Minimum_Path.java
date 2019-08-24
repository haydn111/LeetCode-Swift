package algorithms;

// 给person class和getFreinds()函数能返回set of persons. 朋友可以相互指向, 也可能不会.  包装过得find minimum path for two nodes
// in a graph. 图有环.  BFS加步数计算.

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Graph_Minimum_Path {
    class Node {
        int key;
        List<Node> neighbors;

        boolean visited;
        int shortestDistance;
        Node prevNodeInShortestPath;

        public Node(int item) {
            key = item;
            visited = false;
            shortestDistance = Integer.MAX_VALUE;
            prevNodeInShortestPath = null;
        }
    }

    List<Node> dijkstra(Node n1, Node n2) {
        Queue<Node> queue = new LinkedList<>();
        queue.offer(n1);
        n1.shortestDistance = 0;
        n1.visited = true;
        while (!queue.isEmpty()) {
            Node current = queue.poll();
            if (current != n2) {
                for (Node n : current.neighbors) {
                    if (!n.visited) {
                        queue.offer(n);
                        n.visited = true;

                        if (n.shortestDistance > current.shortestDistance + 1) {
                            n.shortestDistance = current.shortestDistance + 1;
                            n.prevNodeInShortestPath = current;
                        }
                    }
                }
            }
        }

        Node n = n2;
        List<Node> solution = new ArrayList<>();
        while (n != null) {
            solution.add(0, n);
            n = n.prevNodeInShortestPath;
        }
        return solution;
    }

    void test() {
        Node n1 = new Node(1);
        Node n2 = new Node(2);
        Node n3 = new Node(3);
        Node n4 = new Node(4);
        Node n5 = new Node(5);
        Node n6 = new Node(6);

        n1.neighbors = List.of(n2, n5, n3);
        n2.neighbors = List.of(n1, n5, n6, n3);
        n3.neighbors = List.of(n1, n2, n4);
        n4.neighbors = List.of(n3, n6);
        n5.neighbors = List.of(n1, n6, n2);
        n6.neighbors = List.of(n2, n4, n5);

        List<Node> path = dijkstra(n1, n4);
        for (Node n: path) {
            System.out.println(n.key);
        }
    }

    public static void main(String[] args) {
        Graph_Minimum_Path testInstance = new Graph_Minimum_Path();
        testInstance.test();
    }
}
