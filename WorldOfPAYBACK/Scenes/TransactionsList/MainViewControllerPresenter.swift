//
//  MainViewControllerPresenter.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import Foundation

protocol MainViewControllerPresentationLogic: AnyObject {
    func presentTransactions(response: MainViewController.Fetch.Response)
    func presentAlert(response: Alert.Fetch.Response)
    func presentFilterConstants(filterConstants: [MainViewController.Fetch.FilterItems])
    func presentTransactions(response: [Item])
}

final class MainViewControllerPresenter: MainViewControllerPresentationLogic {
    
    weak var viewController: MainViewControllerDisplayLogic?
    
    func presentTransactions(response: MainViewController.Fetch.Response) {
        var transactions: [MainViewController.Fetch.ViewModel.TransactionModel] = []
        response.transactionsResponse.items?.forEach {
            transactions.append(MainViewController.Fetch.ViewModel.TransactionModel(partnerDisplayName: $0.partnerDisplayName,
                                                                                    reference: $0.alias?.reference,
                                                                                    category: $0.category,
                                                                                    description: $0.transactionDetail?.description ?? "",
                                                                                    bookingDate: $0.transactionDetail?.bookingDate?.convertToDisplayFormat(),
                                                                                    amount: $0.transactionDetail?.value?.amount,
                                                                                    currency: $0.transactionDetail?.value?.currency))
        }
        let sortedBooking = transactions.sorted { $0.bookingDate?.compare($1.bookingDate ?? "", options: .numeric) == .orderedDescending }
        var totalAmount = 0
        transactions.forEach { item in
            totalAmount += item.amount ?? 0
        }
        viewController?.displayTransactions(viewModel: MainViewController.Fetch.ViewModel(transactionsList: sortedBooking), totalAmount: totalAmount)
    }
    
    func presentAlert(response: Alert.Fetch.Response) {
        viewController?.displayAlert(alertTitle: response.alertTitle ?? "", actionTitle: response.actionTitle ?? "", message: response.alertMessage ?? "")
    }
    
    func presentFilterConstants(filterConstants: [MainViewController.Fetch.FilterItems]) {
        viewController?.displayFilterConstants(filterConstants: filterConstants)
    }
    
    func presentTransactions(response: [Item]) {
        var transactions: [MainViewController.Fetch.ViewModel.TransactionModel] = []
        response.forEach { value in
            transactions.append(MainViewController.Fetch.ViewModel.TransactionModel(partnerDisplayName: value.partnerDisplayName,
                                                                                    reference: value.alias?.reference,
                                                                                    category: value.category,
                                                                                    description: value.transactionDetail?.description ?? "",
                                                                                    bookingDate: value.transactionDetail?.bookingDate?.convertToDisplayFormat(),
                                                                                    amount: value.transactionDetail?.value?.amount,
                                                                                    currency: value.transactionDetail?.value?.currency))
        }
        let sortedBooking = transactions.sorted { $0.bookingDate?.compare($1.bookingDate ?? "", options: .numeric) == .orderedDescending }
        var totalAmount = 0
        transactions.forEach { item in
            totalAmount += item.amount ?? 0
        }
        viewController?.displayTransactions(viewModel: MainViewController.Fetch.ViewModel(transactionsList: sortedBooking), totalAmount: totalAmount)
    }
}

extension Date {

    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: self)
    }
}


extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }

    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
