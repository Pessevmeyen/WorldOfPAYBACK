//
//  DetailTransactionsRouter.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 6.12.2022.
//

import Foundation

protocol DetailTransactionsRoutingLogic: AnyObject {
    
}

protocol DetailTransactionsDataPassing: AnyObject {
    var dataStore: DetailTransactionsDataStore? { get }
}

final class DetailTransactionsRouter: DetailTransactionsRoutingLogic, DetailTransactionsDataPassing {
    
    weak var viewController: DetailTransactionsViewController?
    var dataStore: DetailTransactionsDataStore?
    
}
