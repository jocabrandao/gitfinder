//
//  FollowerDS.swift
//  gitfinder
//
//  Created by Joca on 02/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

/// Follower Datasource implementation for FollowersTableView (FollowersTV in the storyboard)
class FollowersDS : GenericDS<Follower>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "followerCell", for: indexPath) as! FollowersTVC
        let oneFollower = data.value[indexPath.row]
        newCell.oneFollower = oneFollower
        return newCell
    }

    
}
