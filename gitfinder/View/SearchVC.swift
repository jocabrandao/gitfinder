//
//  SearchVC.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var usersTV: UITableView!
    
    var searchedSomeone = false
    
    let ds = SearchDS()
    lazy var vm : SearchVM = {
        let viewModel = SearchVM(searchCriteria: searchTxt.text!, datasource: ds)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedSomeone = false
        
//        let tap = UIGestureRecognizer(target: self, action: #selector(SearchVC.handleTap))
//        view.addGestureRecognizer(tap)

    }

    @IBAction func searchTxtEditing(_ sender: Any) {
        if searchTxt.text == "" {
            searchBtn.setImage(UIImage(named: "search-button-disabled"), for: .normal)
            searchedSomeone = false
        } else {
            searchBtn.setImage(UIImage(named: "search-button-enabled"), for: .normal)
        }
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        if searchedSomeone && searchTxt.text != "" {
            searchBtn.setImage(UIImage(named: "search-button-disabled"), for: .normal)
            searchTxt.text = ""
            
            self.usersTV.dataSource = nil
            self.usersTV.reloadData()
            
            searchedSomeone = false
            
        } else if searchTxt.text != "" {
            searchBtn.setImage(UIImage(named: "search-button-clean"), for: .normal)

            self.vm.searchCriteria = searchTxt.text
            self.vm.searchByUser { _ in
                self.usersTV.dataSource = self.ds
                self.usersTV.delegate = self
                self.usersTV.reloadData()
            }
            
            searchedSomeone = true

        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SEGUE_DETAIL_VC, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            if let targetVC = segue.destination as? DetailVC {
                let indexPath = self.usersTV.indexPathForSelectedRow!
                let index = indexPath.row
                
                targetVC.selectedUser = ds.data.value[index]
            }
        }
    }
    
//    @objc func handleTap() {
//        view.endEditing(true)
//    }
    
}
