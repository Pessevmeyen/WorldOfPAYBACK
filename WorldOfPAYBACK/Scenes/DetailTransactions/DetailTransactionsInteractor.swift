//
//  DetailTransactionsInteractor.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 6.12.2022.
//

import Foundation

protocol DetailTransactionsBusinessLogic: AnyObject {
    func fetchDetails(request: DetailTransactions.Fetch.Request)
}

protocol DetailTransactionsDataStore: AnyObject {
    var transactionsData: Item? { get set }
}

final class DetailTransactionsInteractor: DetailTransactionsBusinessLogic, DetailTransactionsDataStore {
    
    var presenter: DetailTransactionsPresentationLogic?
    var worker: DetailTransactionsWorkingLogic = DetailTransactionsWorker()
    
    var transactionsData: Item?
    
    func fetchDetails(request: DetailTransactions.Fetch.Request) {
        presenter?.presentDetails(response: DetailTransactions.Fetch.Response(transactionDetail: transactionsData))
    }
}
