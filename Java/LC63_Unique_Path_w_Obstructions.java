package algorithms;

public class LC63_Unique_Path_w_Obstructions {

//    A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).
//    The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right
//    corner of the grid (marked 'Finish' in the diagram below).
//
//    consider if some obstacles are added to the grids. How many unique paths would there be?
//    An obstacle and empty space is marked as 1 and 0 respectively in the grid.
//
//    For example,
//    There is one obstacle in the middle of a 3x3 grid as illustrated below.
//      [
//        [0,0,0],
//        [0,1,0],
//        [0,0,0]
//      ]
//    How many possible unique paths are there?


    // DP
    // 1. State variable: a m x n matrix. [i][j] contains # of path to [i][j]
    // 2. Initialization: first row and column
    // 3. Progress function: dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
    // 4. Result: bottom-right of state matrix
    static int path(int[][] obstructions) {
        int m = obstructions.length;    // if (m == 0) return 0;
        int n = obstructions[0].length;
        int[][] dp = new int[m][n];

        // init top row and left column
        for (int i = 0; i < m; i++) {
            if (obstructions[i][0] == 1) {
                break;
            } else {
                dp[i][0] = 1;
            }
        }
        for (int j = 0; j < n; j++) {
            if (obstructions[0][j] == 1) {
                break;
            } else {
                dp[0][j] = 1;
            }
        }

        // progress: dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                if (obstructions[i][j] == 1) {
                    dp[i][j] = 0;
                } else {
                    dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
                }
            }
        }
        return dp[m - 1][n - 1];
    }

}
