//
//  Extension.swift
//  Created by Apple on 13/12/18.
//  Copyright © 2018 All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

 
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertAction(Title: String , Message: String , ButtonTitle: String) {

        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in

            self.navigationController?.popViewController(animated: true)

        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
            
            self.navigationController?.popViewController(animated: true)
            
        }))

        self.present(alert, animated: true, completion: nil)

    }
    
    
    func showAlertAction_pushType(Title: String , Message: String , ButtonTitle: String, vc: UIViewController?) {
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
            self.navigationController?.pushViewController(vc!, animated: true)
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlertAction_popController(Title: String , Message: String , ButtonTitle: String, vc: UIViewController?) {
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
            self.navigationController?.popToViewController(vc!, animated: true)
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
