//
//  DetailTransactionsPresenter.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 6.12.2022.
//

import Foundation

protocol DetailTransactionsPresentationLogic: AnyObject {
    func presentDetails(response: DetailTransactions.Fetch.Response)
}

final class DetailTransactionsPresenter: DetailTransactionsPresentationLogic {
    
    weak var viewController: DetailTransactionsDisplayLogic?
    
    func presentDetails(response: DetailTransactions.Fetch.Response) {
//        let details = response.transactionDetail
        viewController?.displayDetailsList(viewModel: DetailTransactions.Fetch.ViewModel(partnerDisplayName: response.transactionDetail?.partnerDisplayName,
                                                                                         description: response.transactionDetail?.transactionDetail?.description ?? ""))
    }
    
}
