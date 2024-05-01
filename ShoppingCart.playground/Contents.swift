import Foundation

protocol ShoppingCart {
    associatedtype Product
    
    var products: [Product] { get set }
    
    mutating func addProduct(_ product: Product)
    mutating func removeProduct(at index: Int)
    func totalPrice() -> Double
    func findMaxPricedProduct() -> Product?
    mutating func applyDiscount(discountPercentage: Double)
    mutating func removeAllProducts()
}

struct Item {
    let name: String
    let price: Double
}

struct MyShoppingCart: ShoppingCart {
    typealias Product = Item
    
    var products: [Item] = []
    
    mutating func addProduct(_ product: Item) {
        products.append(product)
    }
    
    mutating func removeProduct(at index: Int) {
        guard index >= 0 && index < products.count else { return }
        products.remove(at: index)
    }
    
    func totalPrice() -> Double {
        return products.map { $0.price }.reduce(0, +)
    }
    
    func findMaxPricedProduct() -> Item? {
        products.max { $0.price < $1.price }
    }
    
    mutating func applyDiscount(discountPercentage: Double) {
        let discountMultiplier = 1 - (discountPercentage / 100)
        products = products.map { Item(name: $0.name, price: $0.price * discountMultiplier) }
    }
    
    mutating func removeAllProducts() {
        products.removeAll()
    }
}

// Example usage:
var cart = MyShoppingCart()
cart.addProduct(Item(name: "Laptop", price: 1200))
cart.addProduct(Item(name: "Phone", price: 800))
cart.addProduct(Item(name: "Headphones", price: 150))

print("Total price before discount: \(cart.totalPrice())")

if let maxPricedProduct = cart.findMaxPricedProduct() {
    print("Max priced product: \(maxPricedProduct.name) - \(maxPricedProduct.price)")
}

cart.applyDiscount(discountPercentage: 10)

print("Total price after 10% discount: \(cart.totalPrice())")
