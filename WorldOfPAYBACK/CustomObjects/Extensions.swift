//
//  Extensions.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 7.12.2022.
//

import UIKit

extension UIViewController {
    func getAlert(alertTitle: String? = nil, actionTitle: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
