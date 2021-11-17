//
//  UserListTableViewCell.swift
//  Task
//
//  Created by Sam Ebenezar on 16/11/21.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var userImage_Img: SetImage!
    @IBOutlet weak var userName_lbl: UILabel!
    @IBOutlet weak var emai_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
