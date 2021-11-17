//
//  AddUserViewModel.swift
//  Task
//
//  Created by Sam Ebenezar on 17/11/21.
//

import Foundation

class AddUserViewModel{
    
    //MARK:- Initializers and deInitializers
    init() {
        print(#file, "initialized")
    }
    deinit {
        print(#file, "deinitialized")
    }
    
    //MARK:- validations
    func isValid(firstName: String, lastName: String, email: String, image:Data, completion:@escaping(Bool, String)-> Void)->Void{
        
        if firstName.replacingOccurrences(of: " ", with: "") == ""{
            
            completion(false, "Please enter first name")
            
        }else if Validation().isValidName(firstName) == false{
            
            completion(false, "Please enter a valid first name")
            
        }else if lastName.replacingOccurrences(of: " ", with: "") == ""{
            
            completion(false, "Please enter last name")
            
        }else if Validation().isValidName(lastName) == false{
            
            completion(false, "Please enter a valid last name")
            
        }else if email.replacingOccurrences(of: " ", with: "") == ""{
            
            completion(false, "Please enter email")
            
        }else if Validation().isValidEmail(email) == false{
            
            completion(false, "Please enter a valid email")
            
        }else if image.isEmpty{
            
            completion(false, "Please select image")
            
        }
        
        completion(true , "")
    }
}
