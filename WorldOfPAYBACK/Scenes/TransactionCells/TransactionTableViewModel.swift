//
//  TransactionTableViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import Foundation

extension TransactionTableViewCell {
    
    struct ViewModel {
        
        public let valueAmount: String?
        public let currency: String?
        public let partnerName: String?
        public let description: String?
        public let bookingDate: String?
        
        public init(valueAmount: String = "500", currency: String = "TRY", partnerName: String = "PAYBACK", description: String = "an transaction app", bookingDate: String = "Today") {
            self.valueAmount = valueAmount
            self.currency = currency
            self.partnerName = partnerName
            self.description = description
            self.bookingDate = bookingDate
        }
    }
    
}
