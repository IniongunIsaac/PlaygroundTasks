import Foundation

/*
have the function StarRating(str) take the str parameter being passed which will be an average rating between 0.00 and 5.00, and convert this rating into a list of 5 image names to be displayed in a user interface to represent the rating as a list of stars and half stars. Ratings should be rounded up to the nearest half. There are 3 image file names available: "full.jpg", "half.jpg", "empty.jpg". The output will be the name of the 5 images (without the extension), from left to right, separated by spaces. For example: if str is "2.36" then this should be displayed by the following image:
 So your program should return the string "full full half empty empty".
*/

func starRatings(for string: String) -> String {
    guard !string.isEmpty, let rating = Double(string), rating >= 0, rating <= 5 else {
        return "Invalid Input"
    }
    let full = "full"
    let half = "half"
    let empty = "empty"
    
    if rating == .zero {
        return Array(repeating: empty, count: 5).joined(separator: " ")
    }
    
    if rating == 5 {
        return Array(repeating: full, count: 5).joined(separator: " ")
    }
    
    if string.contains(".") {
        let comps = string.components(separatedBy: ".")
        guard let digit = Int(comps[0]) else {
            return "Invalid Input"
        }
        var names = [String]()
        if digit > 0 {
            for _ in 0..<digit {
                names.append(full)
            }
        }
        
        if let fraction = Int(comps[1]), fraction > 0 {
            names.append(half)
        }
        
        if names.count < 5 && (digit + 2) < 5 {
            for _ in (digit + 2)...5 {
                names.append(empty)
            }
        }
        
        return names.joined(separator: " ")
    }
    
    return "Invalid Input"
}

//print(starRatings(for: "2.36"))
//print(starRatings(for: "0.38"))
//print(starRatings(for: "4.5"))
//print(starRatings(for: "0"))
//print(starRatings(for: ""))

// considering the solution below, explain the line "let roundedRating = (rating * 2).rounded() / 2"
func stringChallenge(_ str: String) -> String {
    // Convert the input rating to a Double
    guard let rating = Double(str) else {
        return "Invalid input"
    }

    // Round the rating to the nearest half
    let roundedRating = (rating * 2).rounded() / 2

    // Generate the list of image names based on the rounded rating
    let fullStars = Int(roundedRating)
    /*roundedRating.truncatingRemainder(dividingBy: 1)
    .truncatingRemainder(dividingBy: 1): This method calculates the remainder when roundedRating is divided by 1. Essentially, it isolates the decimal portion of roundedRating. For example:
    If roundedRating is 2.5, then roundedRating.truncatingRemainder(dividingBy: 1) will result in 0.5 (since 2.5 / 1 leaves a remainder of 0.5).
    If roundedRating is 3.0, then roundedRating.truncatingRemainder(dividingBy: 1) will result in 0.0 (since 3.0 / 1 has no remainder).*/
    let halfStar = roundedRating.truncatingRemainder(dividingBy: 1) == 0.5 ? 1 : 0
    let emptyStars = 5 - (fullStars + halfStar)

    // Construct the list of image names
    var imageNames: [String] = Array(repeating: "full", count: fullStars)
    imageNames += Array(repeating: "half", count: halfStar)
    imageNames += Array(repeating: "empty", count: emptyStars)

    // Join the image names into a string separated by spaces
    return imageNames.joined(separator: " ")
}

// Test cases
print(stringChallenge("0.38"))  // Output: half empty empty empty empty
print(stringChallenge("4.5"))   // Output: full full full full half
print(stringChallenge("0"))   // Output: empty empty empty empty empty
print(stringChallenge(""))   // Output: Invalid input
