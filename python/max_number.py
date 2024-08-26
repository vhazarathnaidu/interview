
# Example usage:
#n = 82734



class Solution: 
    def minPartitions(n): 
        n_str = str(n)
        # Find the maximum digit in the string representation of the number
        max_digit = max(int(digit) for digit in n_str)
        return max_digit
        

        minPartitions('245695')
        print(f"The minimum number of deci-binary numbers required to partition {n} is {min_partitions(12345)}")