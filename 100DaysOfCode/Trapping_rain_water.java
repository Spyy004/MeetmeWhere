// Trapping Rain Water Leetcode solution

class Trapping_rain_water {
    public int trap(int[] height) 
	{
        int L = 0, R = height.length - 1;
        int ans = 0; 
        int maxnow = 0; // keeps the track of max trappable height 
        int left = 1; // left=1 means that L was incremented in the last loop
        while(L < R)
		{
			// subtracting the invalid area for the latest move
            if(left == 1) 
                ans -= Math.min(height[L], maxnow); 
            else
                ans -= Math.min(height[R], maxnow); 
            
            int minnow = Math.min(height[L], height[R]); 
            if (minnow > maxnow) // this tells us that now we can add more water between L and R 
			{  
                ans += ((minnow - maxnow) * (R - L - 1)); // adding only the area which wasn't included earlier
                maxnow = minnow; 
            }
            
			// move the index of smaller of height[L] and height[R] and update left
            if(height[L] <= height[R]) {L++; left = 1;} 
            else {R--; left = 0;}
        }
        return ans;
    }
}