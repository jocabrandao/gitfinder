//
//  UIExtensions.swift
//  gitfinder
//
//  Created by Joca on 02/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentLoadingView(_ status: Bool) {
        var fadeView : UIView?
        
        if status == true {
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            
            fadeView?.backgroundColor = UIColor.black
            fadeView?.alpha = 0.0
            fadeView?.tag = 99
            
            let spinner = UIActivityIndicatorView()
            spinner.color = UIColor.white
            spinner.activityIndicatorViewStyle = .whiteLarge
            spinner.center = view.center
            
            view.addSubview(fadeView!)
            fadeView?.addSubview(spinner)
            
            spinner.startAnimating()
            
            UIView.animate(withDuration: 0.2, animations: {
                fadeView?.alpha = 0.7
            })
            
        } else {
            for subview in view.subviews {
                if subview.tag == 99 {
                    UIView.animate(withDuration: 0.2, animations: {
                        subview.alpha = 0.0
                    }, completion: {(finish) in
                        subview.removeFromSuperview()
                    })
                }
            }
        }
    }
}
