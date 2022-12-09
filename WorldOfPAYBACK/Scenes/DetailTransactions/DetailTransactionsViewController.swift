//
//  DetailTransactionsViewController.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 6.12.2022.
//

import UIKit

protocol DetailTransactionsDisplayLogic: AnyObject {
    func displayDetailsList(viewModel: DetailTransactions.Fetch.ViewModel)
}

final class DetailTransactionsViewController: UIViewController {
    
    @IBOutlet weak var partnerDisplayNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var interactor: DetailTransactionsBusinessLogic?
    var router: (DetailTransactionsRoutingLogic & DetailTransactionsDataPassing)?
    var viewModel: DetailTransactions.Fetch.ViewModel?
    
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
        interactor?.fetchDetails(request: DetailTransactions.Fetch.Request())
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailTransactionsInteractor()
        let presenter = DetailTransactionsPresenter()
        let router = DetailTransactionsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setLabels() {
        partnerDisplayNameLabel.text = viewModel?.partnerDisplayName
        descriptionLabel.text = viewModel?.description
    }
}

extension DetailTransactionsViewController: DetailTransactionsDisplayLogic {
    func displayDetailsList(viewModel: DetailTransactions.Fetch.ViewModel) {
        self.viewModel = viewModel
        setLabels()
    }
}
