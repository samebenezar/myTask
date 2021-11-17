
//
//  Validation.swift

//  Copyright © 2020. All rights reserved.
//


import Foundation
import UIKit

public enum ValidationState {
    case valid
    case invalid(_ reason: String)
}

class Validation {
    
    func isValidEmail(_ emailString: String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: emailString)
    }
    
    func isValidName(_ txt: String) -> Bool {
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: txt)
        
    }
    
    func isValidZipCode(_ zipcodeString: String) -> Bool {
        
        let zipcodeRegex = "[0-9]{6,8}"
        
        let zipcodeTest = NSPredicate(format: "SELF MATCHES %@", zipcodeRegex)
        
        return zipcodeTest.evaluate(with: zipcodeString)
        
    }
    
    func isValidNumber(_ numberString: String) -> Bool {
        
        let numberRegex = "[0-9.]{1,}"
        
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        return numberTest.evaluate(with: numberString)
    }
    
    
    func isValidDiscount(_ numberString: String) -> Bool {
        
        let numberRegex = "[0-9]{0,99}"
        
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        return numberTest.evaluate(with: numberString)
    }
    
    func isValidPhoneNumber(_ phoneString: String) -> Bool {
        
        let phoneRegex = "[0-9+]{7,15}"
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phonePredicate.evaluate(with: phoneString)
    }
    
    func isValidCharacters(_ string: String) -> Bool {
        
        let regex = "[A-Za-z]{1,}"
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return test.evaluate(with: string)
        
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+$).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isPasswordValidSpecial(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validate(_ string: String, equalTo match: String) -> Bool {
        
        if (string == match) {
            
            return true
            
        }else {
            
            return false
            
        }
    }
}
