



class Solution {
    public static int minPartitions(String n) {
        int max = Integer.MIN_VALUE;
        char charr[] = n.toCharArray();
        for(int i=0; i<charr.length; i++){
            if(max < charr[i]-'0')  max = charr[i]-'0';
        }
        return max;
    }
    
    public static void main(String[] args) {
        System.out.println(minPartitions("1456470658"));
    }
}