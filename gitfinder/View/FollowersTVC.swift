//
//  FollowersTVC.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

class FollowersTVC: UITableViewCell {

    @IBOutlet weak var avatar: CircleIV!
    @IBOutlet weak var name: UILabel!
    
    /// At runtime it will receive the data that needs to be displayed in a table cell.
    var oneFollower : Follower? {
        didSet {
            guard let oneFollower = oneFollower else { return }
            name.text = oneFollower.username
            
            if oneFollower.avatarUrl != "" {
                avatar.load(url: NSURL(string: oneFollower.avatarUrl)! as URL)
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
