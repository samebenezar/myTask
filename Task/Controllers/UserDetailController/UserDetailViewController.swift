//
//  UserDetailViewController.swift
//  Task
//
//  Created by Sam Ebenezar on 16/11/21.
//

import UIKit

class UserDetailViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var userImage_img: SetImage!
    @IBOutlet weak var userName_lbl: UILabel!
    @IBOutlet weak var userEmail_lbl: UILabel!
    @IBOutlet weak var userId_lbl: UILabel!
    
    //MARK- variables
    var image = ""
    var name = ""
    var email = ""
    var id = -1
    var imageData = Data()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "User Detail"
        if imageData.isEmpty{
            
        userImage_img.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "noImage"))
            
        }else{
            
            userImage_img.image = UIImage(data: imageData)
        }
        userName_lbl.text = name
        userEmail_lbl.text = email
        userId_lbl.text = "\(id)"
        
    }
}
