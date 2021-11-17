//
//  CoreDataActions.swift
//  Task
//
//  Created by Sam Ebenezar on 16/11/21.
//

import Foundation
import CoreData
import UIKit

public class CoreDataActions: NSObject{
    
    //MARK:- Initializers and deInitializers
    override init() {
        super.init()
        print(#file, "initialized")
    }
    deinit {
        print(#file, "deinitialized")
    }
    
    //MARK:- variables
    let managedContext = AppDelegate().persistentContainer.viewContext
    
    //MARK:- userDefinedFunctions
    func storeData(data: UserListDataModel?){
        
        guard let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext) else{
            return
        }
        
        for user in data?.data ?? []{
            
            let userData = NSManagedObject(entity: userEntity, insertInto: managedContext)
            
            userData.setValue(((user.firstName ?? "") + " " + (user.lastName ?? "")), forKey: "userName")
            userData.setValue(user.email ?? "", forKey: "email")
            userData.setValue(user.avatar ?? "", forKey: "userImage")
            userData.setValue(user.id ?? -1, forKey: "userId")
            userData.setValue(user.firstName ?? "", forKey: "firstName")
            userData.setValue(user.lastName ?? "", forKey: "lastName")
            
        }
        
        do{
            
            try managedContext.save()
            
        }catch{
            
            print("Could not save : \(error)")
            
        }
    }
    
    func retrieveData()->dbUserData?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        var users = dbUserData()
        users.userListing?.removeAll()
        var getData = [userList]()
        getData.removeAll()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                
                let newData = userList()
                
                if let userName = data.value(forKey: "userName") as? String{
                    
                    newData.userName = userName
                }
                
                if let firstName = data.value(forKey: "firstName") as? String{
                    
                    newData.firstName = firstName
                }
                
                if let lastName = data.value(forKey: "lastName") as? String{
                    
                    newData.lastName = lastName
                    
                }
                
                if let userId = data.value(forKey: "userId") as? Int{
                    
                    newData.id = userId
                    
                }
                
                if let userImage = data.value(forKey: "userImage") as? String{
                    
                    newData.avatar = userImage
                    
                }
                
                if let email = data.value(forKey: "email") as? String{
                    
                    newData.email = email
                }
                
                if let newUserImage = data.value(forKey: "newUserImage") as? Data{
                    
                    newData.newUserImage = newUserImage
                    
                }
                getData.append(newData)
            }
            
        } catch {
            
            print("Failed to retrieve : \(error)")
        }
        
        users.userListing = getData
        return users
    }
    
    func deleteData(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            
            let result = try managedContext.fetch(fetchRequest)
            
            for object in result {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }catch{
            
            print("Unable to Delete : \(error)")
        }
        
    }
    
    func storeSingleData(firstName: String, lastName: String, email: String, image: Data, userId: Int){
        
        guard let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext) else{
            return
        }
        
        let userData = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        userData.setValue(((firstName) + " " + (lastName)), forKey: "userName")
        userData.setValue(email, forKey: "email")
        userData.setValue(userId, forKey: "userId")
        userData.setValue(firstName, forKey: "firstName")
        userData.setValue(lastName, forKey: "lastName")
        userData.setValue(image, forKey: "newUserImage")
        
        do{
            
            try managedContext.save()
            
        }catch{
            
            print("Could not save : \(error)")
            
        }
    }
}
