//
//  AlertUtils.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import UIKit

class AlertUtils {
    
    static func showErrorAlert(in viewController: UIViewController,
                               message: String) -> Void
    {
        let alert = UIAlertController(title: "Error", message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true)
    }
    
}
