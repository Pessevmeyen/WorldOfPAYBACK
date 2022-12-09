//
//  ResponseModel.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import Foundation

// MARK: - Transactions
public struct Transactions: Codable {
    internal init(items: [Item]? = nil) {
        self.items = items
    }
    
    var items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    internal init(partnerDisplayName: String? = nil, alias: Alias? = nil, category: Int? = nil, transactionDetail: TransactionDetail? = nil) {
        self.partnerDisplayName = partnerDisplayName
        self.alias = alias
        self.category = category
        self.transactionDetail = transactionDetail
    }
    
    let partnerDisplayName: String?
    let alias: Alias?
    let category: Int?
    let transactionDetail: TransactionDetail?
}

// MARK: - Alias
struct Alias: Codable {
    internal init(reference: String? = nil) {
        self.reference = reference
    }
    
    let reference: String?
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable {
    internal init(transactionDetailDescription: String? = nil, bookingDate: String? = nil, value: Value? = nil) {
        self.description = transactionDetailDescription
        self.bookingDate = bookingDate
        self.value = value
    }
    
    let description: String?
    let bookingDate: String?
    let value: Value?

    enum CodingKeys: String, CodingKey {
        case description
        case bookingDate, value
    }
}

// MARK: - Value
struct Value: Codable {
    internal init(amount: Int? = nil, currency: String? = nil) {
        self.amount = amount
        self.currency = currency
    }
    
    let amount: Int?
    let currency: String?
}
