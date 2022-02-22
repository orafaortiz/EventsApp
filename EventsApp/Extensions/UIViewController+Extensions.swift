//
//  UIViewController+Extensions.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 20/02/22.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(
            identifier: "\(T.self)") as! T
        
        return controller
    }
}
