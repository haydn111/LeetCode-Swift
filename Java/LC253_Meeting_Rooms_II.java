package algorithms;

import java.util.Arrays;
public class LC253_Meeting_Rooms_II {

    // Given an 2d array of meeting times [[s1, e1], [s2, e2], ...]. Find minimum number of rooms required.

    class Interval {
        int start;
        int end;
        Interval(int s, int e) {
            start = s;
            end = e;
        }
    }

    // Remarks:
    // swap start/end time of meetings does not affect # of rooms required. i.e. solution of [[s1, e2], [s2, e1]] and
    // [s1, e1], [s2, e2]] are the same.

    int meetingRooms(Interval[] intervals) {
        if (intervals == null || intervals.length == 0) {
            return 0;
        }
        int[] start = new int[intervals.length];
        int[] end = new int[intervals.length];
        for (int i = 0; i < intervals.length; i++) {
            start[i] = intervals[i].start;
            end[i] = intervals[i].end;
        }
        Arrays.sort(start);
        Arrays.sort(end);

        int numberOfRooms = 0;
        int endPtr = 0;
        for (int i = 0; i < start.length; i++) {
            if (start[i] < end[endPtr]) {
                numberOfRooms++;
            }
            else {
                endPtr++;
            }
        }
        return numberOfRooms;
    }
}
