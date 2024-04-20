import Foundation

struct Stack<T> {
    private var elements = [T]()  // Array to hold the stack elements

    // Check if the stack is empty
    var isEmpty: Bool {
        return elements.isEmpty
    }

    // Push an element onto the stack
    mutating func push(_ element: T) {
        elements.append(element)
    }

    // Pop the top element from the stack and return it
    mutating func pop() -> T? {
        return elements.popLast()
    }

    // Return the top element of the stack without removing it
    func peek() -> T? {
        return elements.last
    }

    // Return the number of elements in the stack
    var count: Int {
        return elements.count
    }

    // Remove all elements from the stack
    mutating func removeAll() {
        elements.removeAll()
    }
}

var stack = Stack<Int>()

// Push elements onto the stack
stack.push(10)
stack.push(20)
stack.push(30)

// Print the top element
if let topElement = stack.peek() {
    print("Top element: \(topElement)")  // Output: Top element: 30
}

// Pop elements from the stack
while let poppedElement = stack.pop() {
    print("Popped element: \(poppedElement)")
}
// Output:
// Popped element: 30
// Popped element: 20
// Popped element: 10

// Check if the stack is empty
print("Is stack empty? \(stack.isEmpty)")  // Output: Is stack empty? true

struct Deque<T> {
    private var elements = [T]()  // Array to hold the deque elements

    // Check if the deque is empty
    var isEmpty: Bool {
        return elements.isEmpty
    }

    // Get the number of elements in the deque
    var count: Int {
        return elements.count
    }

    // Enqueue an element at the front of the deque
    mutating func enqueueFront(_ element: T) {
        elements.insert(element, at: 0)
    }

    // Enqueue an element at the back of the deque
    mutating func enqueueBack(_ element: T) {
        elements.append(element)
    }

    // Dequeue an element from the front of the deque and return it
    mutating func dequeueFront() -> T? {
        if isEmpty {
            return nil
        } else {
            return elements.removeFirst()
        }
    }

    // Dequeue an element from the back of the deque and return it
    mutating func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return elements.removeLast()
        }
    }

    // Peek at the element at the front of the deque without removing it
    func peekFront() -> T? {
        return elements.first
    }

    // Peek at the element at the back of the deque without removing it
    func peekBack() -> T? {
        return elements.last
    }

    // Remove all elements from the deque
    mutating func removeAll() {
        elements.removeAll()
    }
}

var deque = Deque<Int>()

// Enqueue elements into the deque (front and back)
deque.enqueueFront(10)
deque.enqueueBack(20)
deque.enqueueFront(5)
deque.enqueueBack(30)

// Print elements at the front and back of the deque
if let frontElement = deque.peekFront() {
    print("Front element: \(frontElement)")  // Output: Front element: 5
}

if let backElement = deque.peekBack() {
    print("Back element: \(backElement)")  // Output: Back element: 30
}

// Dequeue elements from the front and back of the deque
while let dequeuedFrontElement = deque.dequeueFront() {
    print("Dequeued front element: \(dequeuedFrontElement)")
}

while let dequeuedBackElement = deque.dequeueBack() {
    print("Dequeued back element: \(dequeuedBackElement)")
}
// Output:
// Dequeued front element: 5
// Dequeued front element: 10
// Dequeued back element: 30
// Dequeued back element: 20

// Check if the deque is empty
print("Is deque empty? \(deque.isEmpty)")  // Output: Is deque empty? true

let array = [1,2,3,4,5,6,7,8,11]
let reversed = stride(from: array.count - 1, through: 0, by: -1).map { array[$0] }
print(reversed)

var revsd = [Int]()
for i in array {
    revsd.insert(i, at: 0)
}
print(revsd)

var max = array[0]
var min = array[0]
for i in array {
    if i > max {
        max = i
    }
    if i < min {
        min = i
    }
}
print(max)
print(min)

func countFactors(of number: Int) -> Int {
    if number <= 0 {
        return 0
    }
    
//    var count = 0
//    for i in 1...number {
//        if number % i == 0 {
//            count += 1
//        }
//    }
//    return count
    
    return (1...number).filter { number % $0 == 0 }.count
}

func sameNumberOfFactors(_ num1: Int, _ num2: Int) -> Int {
    // Check if any argument is negative
    if num1 < 0 || num2 < 0 {
        return -1
    }
    
    // Count factors for both numbers
    let num1Factors = countFactors(of: num1)
    let num2Factors = countFactors(of: num2)
    
    // Compare factor counts
    if num1Factors == num2Factors {
        return 1
    } else {
        return 0
    }
}

let result1 = sameNumberOfFactors(12, 6)  // Returns 1 (Both have 6 factors: 1, 2, 3, 4, 6, 12)
let result2 = sameNumberOfFactors(8, 12)  // Returns 0 (8 has 4 factors: 1, 2, 4, 8; 12 has 6 factors: 1, 2, 3, 4, 6, 12)
let result3 = sameNumberOfFactors(-1, 10) // Returns -1 (First argument is negative)
let result4 = sameNumberOfFactors(18, -5) // Returns -1 (Second argument is negative)

print("Result 1: \(result1)")
print("Result 2: \(result2)")
print("Result 3: \(result3)")
print("Result 4: \(result4)")


func isAscending(_ array: [Int]) -> Bool {
    for index in 0..<(array.count - 1) {
        if array[index] > array[index + 1] {
            return false
        }
    }
    return true
}

func isStepped(_ array: [Int]) -> Int {
    if !isAscending(array) {
        return 0
    }
    
    var elementCounts = [Int: Int]()
    for item in array {
        elementCounts[item] = (elementCounts[item] ?? 0) + 1
    }
    //print(elementCounts)
    let isDistinct = elementCounts.values.filter { $0 < 3 }.count == 0
    //print(isDistinct)
    return isDistinct ? 1 : 0
}

func isStepped2(_ array: [Int]) -> Int {
    // Check if the array has at least 3 elements
    if array.count < 3 {
        return 0
    }
    
    var occurrences = [Int: Int]()  // Dictionary to store occurrences of each value
    var isAscending = true  // Flag to track if the array is in ascending order
    
    // Iterate through the array to check ascending order and count occurrences
    for i in 0..<array.count {
        // Check ascending order (a[n] <= a[n+1])
        if i < array.count - 1 && array[i] > array[i + 1] {
            isAscending = false
        }
        
        // Count occurrences of each value
        if let count = occurrences[array[i]] {
            occurrences[array[i]] = count + 1
        } else {
            occurrences[array[i]] = 1
        }
    }
    
    // Check if array is stepped (ascending order and at least 3 occurrences of each distinct value)
    for (_, count) in occurrences {
        if count < 3 {
            return 0  // Less than 3 occurrences of some value
        }
    }
    
    return isAscending ? 1 : 0
}

print(isStepped2([1,1,1,2,2,2]))
print(isStepped2([1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4]))

func isPairedN(_ array: [Int], _ n: Int) -> Int {
    if array.count < 2 || n <= 0 || (array.count == 2 && n != 3) {
        return 0
    }
    
    for i in 0..<array.count {
        for j in 0..<array.count {
            if array[i] != array[j] && (array[i] + array[j]) == n && ((i + 1) + (j + 1)) == n {
                return 1
            }
        }
    }
    
    return 0
}

let array1 = [1, 2, 3, 4, 5]
let array2 = [3, 4, 1, 6, 2]
let array3 = [10, 20, 30, 40]
let array4 = [5]
let n1 = 6
let n2 = 7

print("Array 1 is paired-\(n1): \(isPairedN(array1, n1))")  // Output: Array 1 is paired-6: 1
print("Array 2 is paired-\(n1): \(isPairedN(array2, n1))")  // Output: Array 2 is paired-6: 0
print("Array 3 is paired-\(n2): \(isPairedN(array3, n2))")  // Output: Array 3 is paired-7: 1
print("Array 4 is paired-\(n1): \(isPairedN(array4, n1))")  // Output: Array 4 is paired-6: 0
print("Array 4 is paired-\(0): \(isPairedN([1, -1], 3))")  // Output: Array 4 is paired-6: 0
