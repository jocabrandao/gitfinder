//
//  SearchTVC.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    /// At runtime it will receive the data that needs to be displayed in a table cell.
    var oneUser : User? {
        didSet {
            guard let oneUser = oneUser else { return }
            name.text = oneUser.username
            
            if oneUser.avatarUrl != "" {
                avatar.load(url: NSURL(string: oneUser.avatarUrl)! as URL)
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
