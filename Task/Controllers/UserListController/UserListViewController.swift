//
//  UserListViewController.swift
//  Task
//
//  Created by Sam Ebenezar on 16/11/21.
//

import UIKit

class UserListViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var userList_table: UITableView!
    
    //MARK:- variables
    var viewModel : UserListViewModel? = UserListViewModel()
    var userData : dbUserData?
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Users"
        getUserList()
        userList_table.delegate = self
        userList_table.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        addButtonOnNav()
        
    }

    //MARK:- userDefinedFunctions
    func addButtonOnNav(){
        
        let addButton = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(tapAddUsers))
        addButton.tintColor = .blue
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    //MARK:- Actions
    @objc func tapAddUsers(_ sender: UIBarButtonItem){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddUserViewController") as! AddUserViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
//MARK:- tableViewDelegets
extension UserListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userData?.userListing?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userList_table.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as! UserListTableViewCell
        
        cell.userName_lbl.text = userData?.userListing?[indexPath.row].userName ?? ""
        cell.emai_lbl.text = userData?.userListing?[indexPath.row].email ?? ""
        if userData?.userListing?[indexPath.row].newUserImage == nil{
            
        cell.userImage_Img.sd_setImage(with: URL(string: userData?.userListing?[indexPath.row].avatar ?? ""), placeholderImage: UIImage(named: "noImage"))
            
        }else{
            
            cell.userImage_Img.image = UIImage(data: userData?.userListing?[indexPath.row].newUserImage ?? Data())
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.image = userData?.userListing?[indexPath.row].avatar ?? ""
        vc.email = userData?.userListing?[indexPath.row].email ?? ""
        vc.name = userData?.userListing?[indexPath.row].userName ?? ""
        vc.id = userData?.userListing?[indexPath.row].id ?? -1
        if userData?.userListing?[indexPath.row].newUserImage != nil{
        vc.imageData = userData?.userListing?[indexPath.row].newUserImage ?? Data()
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK:- addUserDelegate
extension UserListViewController: newUser{
    func userAdded() {
        
        userData = nil
        userData = CoreDataActions().retrieveData()
        userList_table.reloadData()
        
    }
}
//MARK:- APIs
extension UserListViewController{
    
    func getUserList(){
        
        Indicator.shared.showProgressView(view)
        
        viewModel?.isUserListing(completion: { success, receivedData, message in
            
            if success{
                CoreDataActions().deleteData()
                CoreDataActions().storeData(data: self.viewModel?.getUserData())
                self.userData = CoreDataActions().retrieveData()
                self.userList_table.reloadData()
                
            }else{
                
                self.showAlert("Demo", message: message)
            }
        })
    }
}
