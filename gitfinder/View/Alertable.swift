//
//  Alertable.swift
//  gitfinder
//
//  Created by Joca on 02/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

protocol Alertable { }

extension Alertable where Self: UIViewController {
    
    func showAlert(title: String, _ msg: String) {
    
        let alertCtrl = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertCtrl.addAction(action)
        present(alertCtrl, animated: true, completion: nil)
        
    }
}
