//
//  DetailTransactionsModels.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 6.12.2022.
//

import Foundation

enum DetailTransactions {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            var transactionDetail: Item?
        }
        
        struct ViewModel {
            var partnerDisplayName: String?
            var description: String
        }
    }
}
