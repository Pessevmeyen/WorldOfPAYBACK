//
//  MainViewControllerInteractor.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import Foundation
import Reachability

protocol MainViewControllerBusinessLogic: AnyObject {
    func fetchList()
    func fetchFilterConstants(filterConstants: [MainViewController.Fetch.FilterItems])
    func fetchFilter(request: String)
    func fetchDataAfterFetched()
}

protocol MainViewControllerDataStore: AnyObject {
    var transactions: Transactions? { get set }
}

final class MainViewControllerInteractor: MainViewControllerBusinessLogic, MainViewControllerDataStore {
    
    var presenter: MainViewControllerPresentationLogic?
    var worker: MainViewControllerWorkingLogic = MainViewControllerWorker()
    
    var transactions: Transactions?
    
    func fetchList() {
        checkConnection()
        worker.getList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.transactions = response
                guard let transactions = self.transactions else { return }
                self.presenter?.presentTransactions(response: MainViewController.Fetch.Response(transactionsResponse: transactions))
            case .failure(let error):
                self.presenter?.presentAlert(response: Alert.Fetch.Response(alertTitle: "Error", alertMessage: "\(error.localizedDescription) Please Pull Down to Refresh or Try Again Later", actionTitle: "OK"))
            }
        }
    }
    
    func fetchFilterConstants(filterConstants: [MainViewController.Fetch.FilterItems]) {
        worker.getFilterConstans { [weak self] result in
            guard let self else { return }
            self.presenter?.presentFilterConstants(filterConstants: result)
        }
    }
    
    func fetchFilter(request: String) {
        let filteredData = transactions?.items?.filter({ filter in
            return String(filter.category ?? 1) == request
        })
        guard let filteredData else {
            presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: "An error occured when filtering. Please try again later", actionTitle: "OK"))
            return
        }
        presenter?.presentTransactions(response: filteredData)
    }
    
    func fetchDataAfterFetched() {
        guard let transactions = self.transactions else { return }
        presenter?.presentTransactions(response: MainViewController.Fetch.Response(transactionsResponse: transactions))
    }
    
    private func checkConnection() {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .unavailable:
            presenter?.presentAlert(response: Alert.Fetch.Response(alertTitle: "Error", alertMessage: "Unreachable Internet Connection", actionTitle: "OK"))
        default: break
        }
    }
}
