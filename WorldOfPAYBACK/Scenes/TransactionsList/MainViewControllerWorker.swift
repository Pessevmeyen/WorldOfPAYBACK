//
//  MainViewControllerWorker.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import Foundation

protocol MainViewControllerWorkingLogic: AnyObject {
    func getList(completion: @escaping ((Result<Transactions,Error>) -> Void))
    func getFilterConstans(completion: @escaping (([MainViewController.Fetch.FilterItems]) -> Void))
}

final class MainViewControllerWorker: MainViewControllerWorkingLogic {
    
    
    
    func getList(completion: @escaping ((Result<Transactions,Error>) -> Void)) {
        NetworkManager.shared.fetch(encode: Transactions.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFilterConstans(completion: @escaping (([MainViewController.Fetch.FilterItems]) -> Void)) {
        var itemList: [MainViewController.Fetch.FilterItems] = []
        
        let capacityInterval: MainViewController.Fetch.FilterItems = .init(first: "Category", second: Constants.capacityArray)
        
        itemList.append(capacityInterval)
        completion(itemList)
    }
}
