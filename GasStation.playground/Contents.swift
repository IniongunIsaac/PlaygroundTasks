import Foundation

/*Gas Station
Have the function GasStation(strArr) take strArr which will be an an array consisting of the
following elements: N which will be the number of gas stations in a circular route and each subsequent
element will be the string g:c where g is the amount of gas in gallons at that gas station and c will
be the amount of gallons of gas needed to get to the following gas station. For example strArr may
be: ["4","3:1","2:2","1:2","0:1"]. Your goal is to return the index of the starting gas station that
will allow you to travel around the whole route once, otherwise return the string impossible.
For the example above, there are 4 gas stations, and your program should return the string 1 because
starting at station 1 you receive 3 gallons of gas and spend 1 getting to the next station.
Then you have 2 gallons + 2 more at the next station and you spend 2 so you have 2 gallons when you get
to the 3rd station. You then have 3 but you spend 2 getting to the final station, and at the final
station you receive 0 gallons and you spend your final gallon getting to your starting point.
Starting at any other gas station would make getting around the route impossible, so the answer is 1.
If there are multiple gas stations that are possible to start at, return the smallest index (of the gas station).
N will be >= 2.

Examples
Input: new String[] {"4","1:1","2:2","1:2","0:1"}
Output: "impossible"
Input: new String[] {"4","0:1","2:2","1:2","3:1"}
Output: "4"
*/

func gasStationCircularRoute(_ strArr: [String]) -> String {
    guard strArr.count >= 2, let numStations = Int(strArr.first ?? "0"), (strArr.count - 1) == numStations else {
        return "impossible"
    }
    
    var totalGas = 0
    var totalNeeded = 0
    var gasInTank = 0
    var startIndex = 1
    
    for i in 1...numStations {
        let station = strArr[i].split(separator: ":")
        guard station.count == 2, let gasAvailable = Int(station[0]), let gasNeeded = Int(station[1]) else {
            return "impossible"
        }
        
        totalGas += gasAvailable
        totalNeeded += gasNeeded
        gasInTank += gasAvailable - gasNeeded
        
        /*
         - gasInTank < 0:
            * This condition checks if, after moving to the next gas station (subtracting the required gas), the gasInTank becomes negative. If gasInTank is negative, it means that starting from the current station, you won't have enough gas to reach the next station.
            * When gasInTank becomes negative, it indicates that the current starting station (startIndex) is not suitable for completing the circular route.
        - gasInTank = 0:
            * If gasInTank becomes negative at any point (indicating that the current station is not suitable), we reset gasInTank to zero and update startIndex to the next station (i + 1).
            * Resetting gasInTank to zero means that we start considering the next gas station as a potential starting point for the circular route.
         */
        if gasInTank < 0 {
            gasInTank = 0
            startIndex = i + 1
        }
    }
    
    if totalGas >= totalNeeded {
        return "\(startIndex)"
    } else {
        return "impossible"
    }
}

//print(gasStationCircularRoute(["4", "1:1", "2:2", "1:2", "0:1"]))  // "impossible"
//print(gasStationCircularRoute(["4", "0:1", "2:2", "1:2", "3:1"]))  // "4"

func canCompleteCircularRoute(in array: [String]) -> String {
    let impossible = "impossible"
    guard array.count >= 2, let numStations = Int(array[0]), numStations != 0, numStations == (array.count - 1) else {
        return impossible
    }
    
    var totalGasNeeded = 0
    var totalGasAvailable = 0
    var gasInTank = 0
    var startIndex = 1
    
    for index in 1...numStations {
        guard array[index].contains(":") else {
            return impossible
        }
        let stationData = array[index].split(separator: ":")
        guard stationData.count == 2, let gasAvailable = Int(stationData[0]), let gasNeeded = Int(stationData[1]) else {
            return impossible
        }
        
        totalGasAvailable += gasAvailable
        totalGasNeeded += gasNeeded
        gasInTank += gasAvailable - gasNeeded
        
        if gasInTank < 0 {
            gasInTank = 0
            startIndex = index + 1
        }
    }
    
    if totalGasAvailable >= totalGasNeeded {
        return "\(startIndex)"
    } else {
        return impossible
    }
}

print(canCompleteCircularRoute(in: ["4", "1:1", "2:2", "1:2", "0:1"]))  // "impossible"
print(canCompleteCircularRoute(in: ["4", "0:1", "2:2", "1:2", "3:1"]))  // "4"
