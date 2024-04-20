import Foundation

let string = ""

func hasMatchingBracketPairs(_ string: String) -> Bool {
    var bracketStack = [Character]()
    let openingBrackets: [Character] = ["[", "(", "{", "<"]
    let closingBrackets: [Character] = ["]", ")", "}", ">"]
    
    for char in string {
        if openingBrackets.contains(char) {
            bracketStack.append(char)
        } else if closingBrackets.contains(char) {
            if let last = bracketStack.last, isMatchingPair(left: last, right: char) {
                bracketStack.removeLast()
            } else {
                return false
            }
        }
    }
    
    return true
}

func isMatchingPair(left: Character, right: Character) -> Bool {
    switch (left, right) {
    case ("(", ")"), ("[", "]"), ("{", "}"), ("<", ">"):
        return true
    default:
        return false
    }
}

print(hasMatchingBracketPairs(string))
