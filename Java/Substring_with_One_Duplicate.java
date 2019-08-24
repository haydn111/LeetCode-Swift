package algorithms;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

// 给字符串， 找出里面长度为N的， 并且里面字符只有一次重复的字串。
// 例子：s: asdfaghjkjqoiiii;N=5.  返回asdfa ghjkj hjkjq jkjqo jqoii.

public class Substring_with_One_Duplicate {

	public Set<String> solution(String s, int N){
        Set<String> result = new HashSet<String>();
        if(s==null||N==0||N>s.length()){
        	return result;
        }
        for(int i=0;i<=s.length()-N;i++){
            String substring=s.substring(i,i+N);
        if(checkString(substring,N))
            result.add(substring);
        }
        return result;
}
public boolean checkString(String s,int N){
    HashSet<Character> set=new HashSet<>();
    for(int i=0;i<s.length();i++){
    	set.add(s.charAt(i));
    }
    if(set.size()==N-1){
    	return true;
    }else{
       	return false;
    } 
}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
