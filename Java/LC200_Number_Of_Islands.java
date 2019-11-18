package algorithms;

public class LC200_Number_Of_Islands {
//    Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water
//    and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of
//    the grid are all surrounded by water.
//
//    Example 1:
//            11110
//            11010
//            11000
//            00000
//    Answer: 1
//
//    Example 2:
//            11000
//            11000
//            00100
//            00011
//    Answer: 3
//    Similar Problem: LC 200

    // time: O(m)(n)
    public int numIslands(char[][] grid) {
        int numOfIslands = 0;
        if (grid.length == 0 || grid[0].length == 0) {
            return numOfIslands;
        }

        // For every '1' found, eat current island with dfs and increment the count.
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid.length; j++) {
                if (grid[i][j] == '1') {
                    numOfIslands++;
                    dfs(i, j, grid);
                }
            }
        }
        return numOfIslands;
    }

    void dfs(int x, int y, char[][] grid) {
        while (x >= 0 && x < grid.length &&
                y >= 0 && y < grid[0].length &&
                grid[x][y] == '1') {
            grid[x][y] = '0';
            dfs(x - 1, y, grid);
            dfs(x + 1, y, grid);
            dfs(x, y - 1, grid);
            dfs(x, y + 1, grid);
        }
    }
    
    // test case: [['1','1','1','1','0'],['1','1','0','1','0'],['1','1','0','0','0'],['0','0','0','0','0']]
}
