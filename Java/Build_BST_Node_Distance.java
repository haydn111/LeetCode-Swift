package algorithms;

// 无序数组要构建二叉搜索树，找两node距离
/*
 * 1. 构建BST
 * 2. 检查给定的两个node是否存在
 * 3. 求两个点在BST中的LCA (Lowest common ancestor)
 * 4. 求每个点到LCA的距离
 * 5. 把两个点到LCA的距离相加即他们的距离
 */

public class Build_BST_Node_Distance {

	static class BinarySearchTree {

		/* Class containing left and right child of current node and key value*/
		class Node {
			int key;
			Node left, right;

			public Node(int item) {
				key = item;
				left = right = null;
			}
		}

		// Root of BST
		Node root;

		// Constructor
		BinarySearchTree() {
			root = null;
		}

		// This method mainly calls insertRec()
		void insert(int key) {
			root = insertRec(root, key);
		}

		/* A recursive function to insert a new key in BST */
		Node insertRec(Node root, int key) {

			/* If the tree is empty, return a new node */
			if (root == null) {
				root = new Node(key);
				return root;
			}

			/* Otherwise, recur down the tree */
			if (key < root.key)
				root.left = insertRec(root.left, key);
			else if (key > root.key)
				root.right = insertRec(root.right, key);

			/* return the (unchanged) node pointer */
			return root;
		}

		/* inorder traversal */
		void inorderRec(Node root) {
			if (root != null) {
				inorderRec(root.left);
				System.out.println(root.key);
				inorderRec(root.right);
			}
		}

		/* Find LCA. Assume n1 and n2 are both present in the tree */
		// time: O(n)
        Node findLCA(Node node, int n1, int n2)
        {
            // Base case
            if (node == null)
                return null;

            // If either n1 or n2 matches with root's key, report
            // the presence by returning root (Note that if a key is
            // ancestor of other, then the ancestor key becomes LCA
            if (node.key == n1 || node.key == n2)
                return node;

            // Look for keys in left and right subtrees
            Node left_lca = findLCA(node.left, n1, n2);
            Node right_lca = findLCA(node.right, n1, n2);

            // If both of the above calls return Non-NULL, then one key
            // is present in once subtree and other is present in other,
            // So this node is the LCA
            if (left_lca!=null && right_lca!=null)
                return node;

            // Otherwise check if left subtree or right subtree is LCA
            return (left_lca != null) ? left_lca : right_lca;
        }

        /* distance between lca and n */
        int distance(Node lca, int n) {
            if (lca == null) {  // n does not exist in subtree with root lca
                return Integer.MIN_VALUE;
            }

            if (lca.key == n) {
                return 0;
            }

            int leftHeight = distance(lca.left, n);
            int rightHeight = distance(lca.right, n);

            if (leftHeight > rightHeight) {
                return leftHeight + 1;
            }
            else {
                return rightHeight + 1;
            }
        }
	}

	public static void main(String[] args) {
		BinarySearchTree tree = new BinarySearchTree();

        /* Let us create following BST
              50
            /    \
          30      70
         /  \    /  \
       20   40  60   80
       /
      10 */
		tree.insert(50);
		tree.insert(30);
		tree.insert(20);
		tree.insert(40);
		tree.insert(70);
		tree.insert(60);
		tree.insert(80);
		tree.insert(10);

		int n1 = 10,  n2 = 70;
        BinarySearchTree.Node lca = tree.findLCA(tree.root, n1, n2);
        int d1 = tree.distance(lca, n1);
        int d2 = tree.distance(lca, n2);
        System.out.println(lca.key);
        System.out.println(d1);
        System.out.println(d2);
        System.out.println("distance = " + (d1 + d2));
    }

}
