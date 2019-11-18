package algorithms;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.Set;

//电影题
//每个电影都有个rate，然后还有一个list是和这个电影类似的电影
//就比如电影a有bcd和他类似，b还有ckl类似的，。。。然后这些类似的组成了一个network，给一个电影的号，让给出它network里排名前k类似的电影
//
//我用的dfs把所有和这个movie的network存下来，然后放到一个priorityqueue里，拿出前k个

//现在要求找到 k个和movie最相似 的movies。
//
//函数的signature大概是这样的：
//public static List<Movie> getNearest(Movie movie, int numSimilar)。
//
//举个栗子：
//m0 <-->m1, similarity 2
//m0 <--> m2, similarity 3
//m1 <--> m3, similarity 4
//m2 <--> m5, similaity 5
//
//如果要返回和m0最相似的movie, 那么应该返回 m5 (只要有一条路径从 m1到 m5, 并且 5是最大的）； 如果返回3个最相似的就返回 m2, m3， m5
// （顺序不重要）； 如果需要返回10个，但是相似的只有9个，那么就返回9个。source movie本身不能在返回结果里面。
//
//
//可以的一个做法是 dfs + min-Heap(PriorityQueue)， 我们一直做dfs， 每次碰到一个新的movie，如果现在queue的size比 k小的话，
// 直接加到queue里面； 如果新movie的rating比queue top movie的rating高的话， 把顶部movie踢出队列，加上这个新的。


//题目让设计成api的样式，可以反复call这个function,大家有什么想法吗？我的想法就是每次call一次，就更新一次这个movie的similar movies,
// 把不是directly相联系的也加到network里。
public class Movie_Network_Problem {

	// BFS + minheap 
	public List<Integer> find(int id, int k, Movie movie) {
        Queue<Movie> q = new LinkedList<>();
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        List<Integer> res = new ArrayList<>();
        Set<Integer> visited = new HashSet<>();

        q.offer(movie);

        while (!q.isEmpty()) {
            Movie cur = q.poll();

            for (Movie neighbor : cur.neighbors) {
                if (visited.add(neighbor.id)) {
                    minHeap.offer(neighbor.id);

                    if (minHeap.size() > k) {
                        minHeap.poll();
                    }

                    q.offer(neighbor);
                }
            }
        }

        while (!minHeap.isEmpty()) {
            res.add(minHeap.poll());
        }

        return res;
    }

    class Movie {
        int id;
        int rate;
        List<Movie> neighbors;

        public Movie(int id, int rate, List<Movie> neighbors) {
            this.id = id;
            this.rate = rate;
            this.neighbors = neighbors;
        }
    }

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
