//
//  UIViewControllerEx.swift
//  The Fork
//
//  Created by Charbel Mattar on 08/03/2022.
//

import UIKit

extension UIViewController {
    
    func embedInNavigationController() -> UINavigationController {
        if let navigation = self as? UINavigationController {
            return navigation
        }
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.isNavigationBarHidden = false
        return navigationController
  }
    
}
