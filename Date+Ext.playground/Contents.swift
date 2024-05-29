import UIKit

extension Date {
    static func date(from date: String, dateFormat: String, addingSeconds: Bool = true) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .init(secondsFromGMT: addingSeconds ? 1800 : 0)
        
        if let date = formatter.date(from: date) {
            return date
        }
        return Date()
    }
    
    static func dateTimeString(
        from date: Date = Date(),
        dateStyle: DateFormatter.Style = .short,
        timeStyle: DateFormatter.Style = .none,
        dateFormat: String? = nil
    ) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = timeStyle
        formatter.dateStyle = dateStyle
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let dateFormat = dateFormat {
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date)
    }
    
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
}

var monthDates = [Date]()
for index in stride(from: -2, through: 0, by: 1) {
    monthDates.append(Date().month(value: index))
}
print(monthDates)
print(monthDates.min()?.startOfMonth ?? .init())

/*let dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
let dateString = "2024-03-27T07:46:05"

let currentDate = Date.date(from: dateString, dateFormat: dateFormat, addingSeconds: false)
let stringDate = Date.dateTimeString(from: currentDate, dateStyle: .full, timeStyle: .full, dateFormat: "MM/dd/yyyy HH:mm:ss")
let time = Date.dateTimeString(from: currentDate, dateStyle: .none, timeStyle: .short)

print(currentDate)
print(stringDate)
print(time)
*/
