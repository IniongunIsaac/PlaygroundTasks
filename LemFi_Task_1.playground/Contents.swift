import UIKit

/// `WORKING SOLUTION`
/*public func solution(_ A: inout [Int], _ S: Int) -> Int {
    let n = A.count
    var count = 0
    var sum = 0
    var prefixSums = [0] // Cumulative sums
    
    // Calculate cumulative sums
    for num in A {
        sum += num
        prefixSums.append(sum)
    }
    
    // Iterate through the array and count fragments with arithmetic mean equal to S
    for i in 0..<n {
        for j in 0...i {
            let fragmentSum = prefixSums[i + 1] - prefixSums[j]
            let fragmentLength = i - j + 1
            if fragmentSum == S * fragmentLength {
                count += 1
            }
        }
    }
    
    return count > 1_000_000_000 ? 1_000_000_000 : count
}*/

/// `WORKING SOLUTION`
public func solution(_ A: inout [Int], _ S: Int) -> Int {
    var counter = 0
    var dpSum = Array(repeating: 0, count: A.count)
    
    for i in 0..<A.count {
        dpSum[i] = A[i]
        if A[i] == S {
            counter += 1
        }
        
        for j in (i + 1)..<A.count {
            let sum = dpSum[j - 1] + A[j]
            dpSum[j] = sum
            
            if Double(sum) / Double(j - i + 1) == Double(S) {
                counter += 1
            }
        }
    }
    
    // Ensure the result doesn't exceed 1,000,000,000
    return min(counter, 1_000_000_000)
}

// Test cases
var A = [2, 1, 3]
var S = 2
print(solution(&A, S)) // Output: 3

A = [0, 4, 3, -1]
S = 2
print(solution(&A, S)) // Output: 2

A = [2, 1, 4]
S = 3
print(solution(&A, S)) // Output: 0
