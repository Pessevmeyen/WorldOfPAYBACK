//
//  MainViewControllerViewController.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import UIKit
import SwiftyJSON
import SystemConfiguration

protocol MainViewControllerDisplayLogic: AnyObject {
    func displayTransactions(viewModel: MainViewController.Fetch.ViewModel, totalAmount: Int)
    func displayAlert(alertTitle: String, actionTitle: String, message: String)
    func displayFilterConstants(filterConstants: [MainViewController.Fetch.FilterItems])
}

final class MainViewControllerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: .main), forCellReuseIdentifier: "TransactionTableViewCell")
        }
    }
    
    let refreshControl = UIRefreshControl()
    var pickerView = UIPickerView()
    
    var interactor: MainViewControllerBusinessLogic?
    var router: (MainViewControllerRoutingLogic & MainViewControllerDataPassing)?
    
    var viewModel: MainViewController.Fetch.ViewModel?
    
    var itemList = [MainViewController.Fetch.FilterItems]()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchList()
        setSearchImageView()
        createFilterItems()
        refreshTableView()
        createToolbarDoneButtonForPickerView()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MainViewControllerInteractor()
        let presenter = MainViewControllerPresenter()
        let router = MainViewControllerRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func refreshTableView() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down to Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func setSearchImageView() {
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        search.isEnabled = false
        search.tintColor = .black
        navigationItem.leftBarButtonItems = [search]
    }

    private func createFilterItems() {
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
        interactor?.fetchFilterConstants(filterConstants: itemList)
    }
    
    private func createToolbarDoneButtonForPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissButton))
        toolBar.setItems([doneButton], animated: true)
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func dismissButton() {
        view.endEditing(true)
        interactor?.fetchDataAfterFetched()
        textField.text = ""
    }
    
    @objc private func refresh() {
        interactor?.fetchList()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
}

extension MainViewControllerViewController: MainViewControllerDisplayLogic {
    func displayTransactions(viewModel: MainViewController.Fetch.ViewModel, totalAmount: Int) {
        self.viewModel = viewModel
        totalAmountLabel.text = "Total Amount: \(totalAmount)"
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    func displayFilterConstants(filterConstants: [MainViewController.Fetch.FilterItems]) {
        itemList = filterConstants
    }
    
    func displayAlert(alertTitle: String, actionTitle: String, message: String) {
        getAlert(alertTitle: alertTitle, actionTitle: actionTitle, message: message)
    }
}

//MARK: - TableView Delegate & Data Sources
extension MainViewControllerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactionsList.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell,
              let model = viewModel?.transactionsList[indexPath.row] else { return UITableViewCell() }
        cell.setCell(viewModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.rouToTransactionDetail(index: indexPath.row)
    }
}

//MARK: - Picker View Delegate & Data Sources
extension MainViewControllerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return itemList.count
        } else {
            let selectedItem = pickerView.selectedRow(inComponent: 0)
            return itemList[selectedItem].second?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return itemList[row].first
        } else {
            let selectedItem = pickerView.selectedRow(inComponent: 0)
            return itemList[selectedItem].second?[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(0)
        pickerView.reloadComponent(1)
        
        let selectedSecond = pickerView.selectedRow(inComponent: 0)
        let selectedData = itemList[selectedSecond].second?[row]
        textField.text = selectedData
        interactor?.fetchFilter(request: selectedData ?? "")
    }
}
