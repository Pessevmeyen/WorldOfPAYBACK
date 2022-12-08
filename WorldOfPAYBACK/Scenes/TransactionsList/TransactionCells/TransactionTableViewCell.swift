//
//  TransactionTableViewCell.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var valueAmountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var partnerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    
    public var viewModel: MainViewController.Fetch.ViewModel.TransactionModel? {
        didSet {
            guard let viewModel else { return }
            setCell(viewModel: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(viewModel: MainViewController.Fetch.ViewModel.TransactionModel) {
        valueAmountLabel.text = "\(viewModel.amount ?? 0)"
        currencyLabel.text = viewModel.currency
        partnerNameLabel.text = viewModel.partnerDisplayName
        descriptionLabel.text = viewModel.description
        bookingDateLabel.text = viewModel.bookingDate
    }
}
