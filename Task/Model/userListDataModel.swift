//
//  userListDataModel.swift
//  Task
//
//  Created by Sam Ebenezar on 16/11/21.
//

import Foundation
// MARK: - UserListDataModel
struct UserListDataModel: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [userData]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct userData: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}

//MARK:- userListing
public class userList: NSObject, Codable {
    var id: Int?
    var email, firstName, lastName: String?
    var avatar: String?
    var userName: String?
    var newUserImage : Data?
    
    override init() { }
    
    required init(instance: userList) {
        
        self.id = instance.id
        self.email = instance.email
        self.firstName = instance.firstName
        self.lastName = instance.lastName
        self.avatar = instance.avatar
        self.userName = instance.userName
        self.newUserImage = instance.newUserImage
        
    }
}
public class dbUserData: NSObject,Codable{
    
    var userListing : [userList]?
    
    override init(){ }
    
    required init(instance : dbUserData){
        self.userListing = instance.userListing
        
    }
}
