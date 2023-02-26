//
//  Constants.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: Colors
    static let blueColor = UIColor(named: "BlueColor")!
    static let backgroundColor = UIColor(named: "BackgroundColor")!
    static let greenColor = UIColor(named: "GreenColor")!
    
    // MARK: Functions
    /// presenting error alert to the user
    static func presentError(title: String, message: String, target: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        DispatchQueue.main.async { [weak target] in
            target?.present(alert, animated: true)
        }
    }
}
