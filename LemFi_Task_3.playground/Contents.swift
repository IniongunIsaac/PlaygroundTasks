import Foundation

/// `WORKING SOLUTION`
public func solution(_ A: inout [Int]) -> Int {
    let count = A.count
    if count < 2 {
        return count
    }
    
    A.sort()
    
    var maxCount = 0
    
    for i in 0..<count {
        for j in (i + 1)..<count {
            var currentCount = 2 // At least two elements can be chosen
            let difference = A[j] - A[i]
            var previousNum = A[j]
            var k = j + 1
            
            // Check subsequent elements
            while k < count {
                if A[k] - previousNum == difference {
                    currentCount += 1
                    previousNum = A[k]
                }
                k += 1
            }
            
            // Update maxCount if necessary
            maxCount = max(maxCount, currentCount)
        }
    }
    
    return maxCount
}

// Test cases
var A1 = [4, 7, 1, 5, 3]
var A2 = [12, 12, 12, 15, 10]
var A3 = [18, 26, 18, 24, 24, 20, 22]

print(solution(&A1)) // Output: 4
print(solution(&A2)) // Output: 3
print(solution(&A3)) // Output: 5

