//
//  UserListViewModel.swift
//  Task
//
//  Created by Sam Ebenezar on 16/11/21.
//

import Foundation

class UserListViewModel: BaseAPI{
    
    //MARK:- Initializers and deInitializers
    override init() {
        super.init()
        print(#file, "initialized")
    }
    deinit {
        print(#file, "deinitialized")
    }
    
    //MARK:- variables
    var userData : UserListDataModel?
    func getUserData()->UserListDataModel?{
        
        return userData
    }
    
    //MARK:- APIs
    
    func isUserListing(completion:@escaping(Bool, AnyObject?, String)-> Void)-> Void{
        
        let req = Request(url: (Urls.baseUrl, APISuffix.userListing), method: .get, params: nil, header: false, body: nil)
        
        super.hitApi(requests: req) { receivedData, message, resp in
            
            Indicator.shared.hideProgressView()
            
            if resp == 1{
                
                if receivedData == nil{
                    
                    completion(false, receivedData as AnyObject, message ?? "")
                    
                }else{
                    
                    if let data = receivedData as? [String : AnyObject]{
                        
                        do{
                            
                            let json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            self.userData = try JSONDecoder().decode(UserListDataModel.self, from: json)
                            completion(true, receivedData as AnyObject, "")
                            
                        }catch{
                            
                            print(error)
                            completion(false, receivedData as AnyObject, error.localizedDescription)
                        }
                    }else{
                        
                        completion(false, receivedData as AnyObject, "Wrong data format")
                        
                    }
                }
            }else{
                
                completion(false, receivedData as AnyObject, message ?? "")
                
            }
        }
    }
}
