package algorithms;

public class LC4_Median_Of_Two_Sorted_Array {

//    There are two sorted arrays nums1 and nums2 of size m and n respectively.
//    Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
//
//    Example 1:
//    nums1 = [1, 3, 5]
//    nums2 = [2, 4]
//    The median is 3

//    Example 2:
//    nums1 = [1, 2]
//    nums2 = [3, 4]
//
//    The median is (2 + 3)/2 = 2.5

    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        // n1, n2 are length of two arrays
        int n1 = nums1.length;
        int n2 = nums2.length;
        if (n1 > n2) {  // make sure nums1 is shorter than nums 2
            return findMedianSortedArrays(nums2, nums1);
        }

        int k = (n1 + n2 + 1) / 2;  // first half of the merged array.
                                    // [k - 1] is the left median, k is the right median
        int l = 0, r = n1;  // left and right ends of nums1 array
        while (l < r) {
            // m1, m2 are how many elements we select from nums1 and nums2 to construct the first k elements (half)
            // of the merged array.
            // Keep doing binary search on first array to find m1 elements taken from first array to construct the first
            // half of the merged array
            int m1 = l + (r - l) / 2;   // (l + r) / 2 prevent overflow
            int m2 = k - m1;
            if (nums1[m1] < nums2[m2 - 1]) { // needs more elements from first array
                l = m1 + 1; // right half
            }
            else {  // less elements from first array
                r = m1;     // left half
            }
        }

        int m1 = l, m2 = k - l;
        // select larger one for left median
        int c1 = Math.max(m1 <= 0 ? Integer.MIN_VALUE : nums1[m1 - 1],      // do we use anything from first array?
                            m2 <= 0 ? Integer.MIN_VALUE : nums2[m2 - 1]);   // do we use anything from right array?
        if ((n1 + n2) % 2 == 1) {   // if total # of elements is odd then left median is the median
            return c1;
        }

        int c2 = Math.min(m1 >= n1 ? Integer.MAX_VALUE : nums1[m1],         // do we use all of fist array?
                            m2 >= n2 ? Integer.MAX_VALUE : nums2[m2]);      // do we use all of second array?
        return (c1 + c2) * 0.5;     // if total # of elements is even then average of left & right medians is the median
    }
}
