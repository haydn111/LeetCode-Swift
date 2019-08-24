package algorithms;

// 水果题
// 抛开各种奇怪的名字不谈，本质上这个题是说，给出一个里面是字符串的二维List，比如
// [[elementA, elementA], [elementB, elementC]], 然后给你一个一维字符串List，
// 问你后者是否包含前者的pattern。举个例子，[A, A, D, B, C]就属于符合，但是
// [], [A, A], [A, A, B, D],  [B, C, A, A]就不符合。这个题具体到代码时仔细想会有很多坑，
// 注意不要踩。我不太同意这个属于Easy难度，对我来说更接近Medium。我对这种双指针for
// loop嵌套循环一直都想不清楚，更何况这种二维间隔顺序花式loop。。。

import java.util.List;

public class TwoD_Array_Pattern {
	public int checkWinner(List<List<String>> codeList,
            List<String> shoppingCart) {
		if(codeList == null || codeList.isEmpty()) return 1;
		    if(shoppingCart == null) return 0;
		    
		    int cartPointer = 0;
		    int result = 0;
		    //Iterate through the outer code list, chunk by chunk
		    for(int i = 0; i < codeList.size(); i++) 
		    {
	            //Iterate within each sub code list, checking String by String:-google 1point3acres
	            // While one sub list is finished successfully, go locate the next start of sub list within cart;
	            // If one sub list failed to match, go to next cart pointer and continue search current sub list.
	            for(int innerListItemPointer = 0; 
	          		innerListItemPointer < codeList.get(i).size();
	          		/* We don't want to increase pointer to all cases here so I will leave the handling of pointer++ operation to each case.*/) {
	                    // If the end of shoppingCart is met before we can iterate all code list, return false;
	                    //System.out.println("Lopping");
	                    if(cartPointer == shoppingCart.size()) 
	                    {
	                            //System.out.println("cart limit reached, breaking test.");
	                            result = 0;
	                            break;
	                    }
	                    // set the result to true, go to next sub list element (j++) and next cart element(cartPointer++);
	                    if(shoppingCart.get(cartPointer).equals(codeList.get(i).get(innerListItemPointer)) || codeList.get(i).get(innerListItemPointer).equals("anything")) 
	                    {
	                            result = 1;
	                            innerListItemPointer++;
	                            cartPointer++;
	                    }
	                    //The case when current cart element doesn't match the later patterns of sub code list, 
	                    //but equals to the start of sub code list. e.g.: Code list [[A, B]] cart:[A, A, B]
	                    else if(shoppingCart.get(cartPointer).equals(codeList.get(i).get(0))){
	                            cartPointer++;
	                            result = 1;
	                    } else {
	                            //When the given String does not meet the sub list's pattern, move to next cart item
	                            // and reset the current sub list pointer index.  
	                            innerListItemPointer = 0;
	                            result = 0;
	                            cartPointer++;
	                    }
	            }
	    }
	    return result;
	}

}
