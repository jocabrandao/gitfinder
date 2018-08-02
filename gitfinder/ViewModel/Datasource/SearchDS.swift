//
//  SearchDS.swift
//  gitfinder
//
//  Created by Joca on 01/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

/// Search Datasource implementation for SearchTableView (SearchTV in the storyboard)
class SearchDS : GenericDS<User>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTVC
        let oneUser = data.value[indexPath.row]
        newCell.oneUser = oneUser
        return newCell
    }

}
