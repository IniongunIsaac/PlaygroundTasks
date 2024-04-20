import Foundation

@discardableResult public func with<T>(_ it: T, f: (T) -> Void) -> T {
    f(it)
    return it
}

extension Date {
    
    func month(value: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: value, to: self) ?? Date()
    }
    
    var localTime: Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    var startOfMonth: Date {
        guard let interval = Calendar.current.dateInterval(of: .month, for: self) else { return Date() }
        return interval.start.localTime // Without toLocalTime it give last months last date
    }

    var endOfMonth: Date {
        guard let interval = Calendar.current.dateInterval(of: .month, for: self) else { return Date() }
        return interval.end
    }
    
    var startEndDates: (start: Date, end: Date) {
        (startOfMonth, endOfMonth)
    }
    
    func adding(_ value: Int, for component: Calendar.Component) -> Date {
        Calendar.current.date(byAdding: component, value: value, to: self) ?? Date()
    }
    
    func string(format: String) -> String {
        let formatter = with(DateFormatter()) {
            $0.locale = Locale(identifier: "en_US_POSIX")
            $0.dateFormat = format
            $0.timeZone = .init(secondsFromGMT: 0)
        }
        return formatter.string(from: self)
    }
}

//print(Date().string(format: "MMM"))

//print(Date().startOfMonth.adding(6, for: .day))
//print(Date().startOfMonth.adding(7, for: .day))
//print(Date().startOfMonth.adding(7, for: .day).adding(6, for: .day))
//print(Date().startOfMonth.adding(14, for: .day))
//print(Date().startOfMonth.adding(14, for: .day).adding(6, for: .day))
//print(Date().startOfMonth.adding(21, for: .day))
//print(Date().startOfMonth.adding(21, for: .day).adding(6, for: .day))
//print(Date().endOfMonth)

//let currentMonth = Date().month(value: 0)
//let prevMonth = Date().month(value: -1)
//let prevTwoMonths = Date().month(value: -2)

//print(currentMonth)
//print(prevMonth)
//print(prevTwoMonths)
//print("==========================")
//print(currentMonth.startAndEndDates())
//print(prevMonth.startAndEndDates())
//print(prevTwoMonths.startAndEndDates())
//print("==========================")
//print(currentMonth.startEndDates)
//print(prevMonth.startEndDates)
//print(prevTwoMonths.startEndDates)

// Define a struct representing your object with a date attribute
struct MyObject {
    let name: String
    let date: Date
}

// Sample list of MyObject instances
let objects = [
    MyObject(name: "Object 1", date: Date(timeIntervalSince1970: 167384400)), // Sample dates
    MyObject(name: "Object 2", date: Date(timeIntervalSince1970: 159382200)),
    MyObject(name: "Object 3", date: Date(timeIntervalSince1970: 175308400)),
    MyObject(name: "Object 4", date: Date(timeIntervalSince1970: 161569800))
]

// Sorting objects by date in ascending order (ASC)
let objectsAsc = objects.sorted { $0.date < $1.date }

// Sorting objects by date in descending order (DESC)
let objectsDesc = objects.sorted { $0.date > $1.date }

/*print("Sorted by date ascending:")
for obj in objectsAsc {
    print(obj)
}

print("\nSorted by date descending:")
for obj in objectsDesc {
    print(obj)
}


var dates = [Date]()
for index in stride(from: -2, through: 0, by: 1) {
    dates.append(Date().month(value: index))
}*/

//dates.sort { $1 < $0 }
//
//print(dates)

extension String {
    var numbers: String {
        return filter { "0"..."9" ~= $0 }
    }
}

//print("print(currentMonth.startEndDates11)".numbers) 2024-02-24T03:41:56.648863Z

func getDate(text: String, outputFormat: String = "dd/MM/yyyy") -> String {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_NG")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    var date = formatter.date(from: text)
    if date == nil {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSS'Z'"
        date = formatter.date(from: text)
    }
    if date != nil {
        formatter.dateFormat = outputFormat
        date = formatter.date(from: text)
    }
    if let date {
        return formatter.string(from: date)
    }
    return text
}

func getDate2(
    text: String,
    inputFormat: String = "yyyy-MM-dd",
    outputFormat: String = "dd/MM/yyyy"
) -> String {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_NG")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = inputFormat
    let date = formatter.date(from: text.components(separatedBy: "T")[0])
    if let date {
        formatter.dateFormat = outputFormat
        return formatter.string(from: date)
    }
    return text
}

//print("Date1: \(getDate2(text: "2024-02-24T03:41:56.648863Z"))")
//print("Date2: \(getDate2(text: "2024-02-24T03:41:47Z"))")
