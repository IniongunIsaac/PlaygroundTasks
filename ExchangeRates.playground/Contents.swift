import Foundation

// Define the struct for the exchange rate
struct ExchangeRate: Codable {
    let code: String
    let rate: Double
}

// Sample JSON data
let jsonData = """
[
    {"code": "USD-NGN", "rate": 1212.73},
    {"code": "USD-EGP", "rate": 24.56},
    {"code": "USD-GBP", "rate": 0.7964895297},
    {"code": "USD-TZS", "rate": 2327.09},
    {"code": "USD-UGX", "rate": 3755.14},
    {"code": "USD-KES", "rate": 128.16},
    {"code": "USD-EUR", "rate": 0.9},
    {"code": "USD-GHS", "rate": 128.16},
    {"code": "USD-USDC", "rate": 1},
    {"code": "USD-UYU", "rate": 200},
    {"code": "USD-MXN", "rate": 16.61},
    {"code": "USD-BRL", "rate": 16.61},
    {"code": "USD-IDR", "rate": 16003},
    {"code": "USD-ZAR", "rate": 18.43},
    {"code": "USD-PHP", "rate": 58.58},
    {"code": "TZS-USD", "rate": 0.0004233391543},
    {"code": "KES-USD", "rate": 0.007687104114},
    {"code": "EGP-USD", "rate": 0.041},
    {"code": "EUR-USD", "rate": 1.0706},
    {"code": "GBP-USD", "rate": 1.2369},
    {"code": "UGX-USD", "rate": 0.0002623470249},
    {"code": "NGN-USD", "rate": 0.000800728},
    {"code": "GHS-USD", "rate": 0.007687104114},
    {"code": "USDC-USD", "rate": 1},
    {"code": "UYU-USD", "rate": 0.005},
    {"code": "MXN-USD", "rate": 0.0602},
    {"code": "BRL-USD", "rate": 0.0602},
    {"code": "IDR-USD", "rate": 0.000062},
    {"code": "ZAR-USD", "rate": 0.054},
    {"code": "PHP-USD", "rate": 0.017}
]
""".data(using: .utf8)!

// Decode JSON data into an array of ExchangeRate
let decoder = JSONDecoder()
do {
    let rates = try decoder.decode([ExchangeRate].self, from: jsonData)
    
    // Create two lists for the exchange rates
    var rateList1: [ExchangeRate] = []
    var rateList2: [ExchangeRate] = []
    
    // Create a dictionary to quickly lookup reverse rates
    var reverseRates: [String: ExchangeRate] = [:]
    for rate in rates {
        reverseRates[rate.code] = rate
    }
    
    for rate in rates {
        if rate.code.hasPrefix("USD-") {
            rateList1.append(rate)
            let components = rate.code.split(separator: "-")
            if components.count == 2 {
                let reverseCode = "\(components[1])-\(components[0])"
                if let reverseRate = reverseRates[reverseCode] {
                    rateList2.append(reverseRate)
                }
            }
        }
    }
    
    // Print the results for verification
    print("rateList1: \(rateList1.count)")
    for rate in rateList1 {
        print("Code: \(rate.code), Rate: \(rate.rate)")
    }
    
    print("\nrateList2: \(rateList2.count)")
    for rate in rateList2 {
        print("Code: \(rate.code), Rate: \(rate.rate)")
    }
    
} catch {
    print("Failed to decode JSON: \(error.localizedDescription)")
}
