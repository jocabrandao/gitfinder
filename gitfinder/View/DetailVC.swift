//
//  DetailVC.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var selectedUser: User?
    
    @IBOutlet weak var noFollowersMsg: UIView!
    
    @IBOutlet weak var avatar: CircleIV!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var followersTV: UITableView!
    
    let dsProfile = DetailDS()
    let dsFollowers = FollowersDS()
    lazy var vm : DetailVM = {
        let viewModel = DetailVM(selectedUser: selectedUser, datasourceProfile: dsProfile, datasourceFollowers: dsFollowers)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentLoadingView(true)
        
        self.vm.loadUserProfile { _ in

            DispatchQueue.main.async {
                let profile = self.dsProfile.data.value[0]
                self.avatar.load(url: NSURL(string: profile.avatarUrl)! as URL)
                self.name.text = profile.name
                self.email.text = profile.email
            }

            self.vm.searchUserFollowers({ _ in

                DispatchQueue.main.async {
                    self.followersTV.dataSource = self.dsFollowers
                    self.followersTV.reloadData()
                    self.presentLoadingView(false)
                }

            })

        }

    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
