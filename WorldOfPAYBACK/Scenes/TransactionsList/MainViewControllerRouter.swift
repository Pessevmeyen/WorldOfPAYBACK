//
//  MainViewControllerRouter.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import UIKit

protocol MainViewControllerRoutingLogic: AnyObject {
    func rouToTransactionDetail(index: Int)
}

protocol MainViewControllerDataPassing: AnyObject {
    var dataStore: MainViewControllerDataStore? { get }
}

final class MainViewControllerRouter: MainViewControllerRoutingLogic, MainViewControllerDataPassing {
    
    weak var viewController: MainViewControllerViewController?
    var dataStore: MainViewControllerDataStore?
    
    func rouToTransactionDetail(index: Int) {
        let storyboard = UIStoryboard(name: "DetailTransactions", bundle: nil)
        let destVC: DetailTransactionsViewController = storyboard.instantiateViewController(identifier: "DetailTransactionsViewController")
        destVC.router?.dataStore?.transactionsData = (dataStore?.transactions?.items?[index])
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
}
