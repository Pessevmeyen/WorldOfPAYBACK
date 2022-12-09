//
//  MainViewControllerModels.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import Foundation

enum MainViewController {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            var transactionsResponse: Transactions
        }
        
        struct ViewModel {
            
            let transactionsList: [MainViewController.Fetch.ViewModel.TransactionModel]
            
            struct TransactionModel {
                var partnerDisplayName: String?
                var reference: String?
                var category: Int?
                var description: String
                var bookingDate: String?
                var amount: Int?
                var currency: String?
            }
        }
        
        struct FilterItems {
            let first: String
            let second: [String]?
        }
    }
}



