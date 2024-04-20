import Foundation

/// `WORKING SOLUTION`
public func solution(_ A: inout [Int], _ B: inout [Int]) -> Int {
    let n = A.count
    var candyTypes = Set<Int>()
    
    var aCoins = n / 2
    var bCoins = n / 2
    
    for i in 0..<n {
        if aCoins > 0 && !candyTypes.contains(A[i]) {
            candyTypes.insert(A[i])
            aCoins -= 1
        } else if bCoins > 0 && !candyTypes.contains(B[i]) {
            candyTypes.insert(B[i])
            bCoins -= 1
        }
    }
    
    return candyTypes.count
}

// Example usage
var A1 = [1, 2, 3, 4]
var B1 = [3, 3, 3, 7]
print(solution(&A1, &B1)) // Output: 4

var A2 = [2, 2, 2, 2, 2, 2]
var B2 = [7, 4, 2, 5, 1, 2]
print(solution(&A2, &B2)) // Output: 4
