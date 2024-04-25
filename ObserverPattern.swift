import Foundation

class Stock {
    let symbol: String
    var price: Float
    private var investors: [Investor]

    init(symbol: String, price: Float) {
        self.symbol = symbol
        self.price = price
        self.investors = []
    }

    func registerInvestor(_ investor: Investor) {
        investors.append(investor)
    }

    func unregisterInvestor(_ investor: Investor) {
        if let index = investors.firstIndex(where: { $0 === investor }) {
            investors.remove(at: index)
        }
    }

    func updatePrice(_ price: Float) {
        self.price = price
        notifyInvestors()
    }

    private func notifyInvestors() {
        investors.forEach { $0.update(stock: self, price: price) }
    }
}

class Investor {
    let name: String
    private var stocks: [Stock]

    init(name: String) {
        self.name = name
        self.stocks = []
    }

    func invest(in stock: Stock) {
        stocks.append(stock)
        stock.registerInvestor(self)
    }

    func divest(from stock: Stock) {
        if let index = stocks.firstIndex(where: { $0 === stock }) {
            stocks.remove(at: index)
            stock.unregisterInvestor(self)
        }
    }

    func update(stock: Stock, price: Float) {
        print("\(name) received update for \(stock.symbol): \(price)")
    }
}

let stock1 = Stock(symbol: "AAPL", price: 150.0)
let stock2 = Stock(symbol: "GOOGL", price: 2500.0)

let investor1 = Investor(name: "Alice")
let investor2 = Investor(name: "Bob")

investor1.invest(in: stock1)
investor2.invest(in: stock1)
investor2.invest(in: stock2)

print("Initial stock prices:")
print("Stock \(stock1.symbol): \(stock1.price)")
print("Stock \(stock2.symbol): \(stock2.price)")

print("\nUpdating stock prices...")
stock1.updatePrice(155.0)
stock2.updatePrice(2550.0)

