//
//  SearchVC.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate, Alertable {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var usersTV: UITableView!
    @IBOutlet weak var emptySearchMsg: UIView!
    
    var searchedSomeone = false
    
    var ds = SearchDS()
    lazy var vm : SearchVM = {
        let viewModel = SearchVM(searchCriteria: searchTxt.text!, datasource: ds)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTxt.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        searchedSomeone = false
        self.presentEmptyMessage(true)
    }

    @IBAction func searchTxtEditing(_ sender: Any) {
        if searchTxt.text == "" {
            searchBtn.setImage(UIImage(named: "search-button-disabled"), for: .normal)
            self.usersTV.dataSource = nil
            self.usersTV.reloadData()
            self.presentEmptyMessage(true)
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
            self.presentEmptyMessage(true)
            
            searchedSomeone = false
            
        } else if searchTxt.text != "" {
            searchBtn.setImage(UIImage(named: "search-button-clean"), for: .normal)
            
            self.presentLoadingView(true)
            self.vm.searchCriteria = searchTxt.text
            self.vm.searchByUser { (result) in

                switch result {
                case .success(let hasResult):
                    if hasResult {
                        self.usersTV.dataSource = self.ds
                        self.usersTV.delegate = self
                        self.usersTV.reloadData()
                        self.presentEmptyMessage(false)
                        self.presentLoadingView(false)
                    } else {
                        self.showAlert(title: "Sorry!", "I could not find anything with the search criteria.")
                        self.presentEmptyMessage(true)
                        self.presentLoadingView(false)
                    }
                    break
                case .failure:
                    self.showAlert(title: "Error", "Sorry, search is unavailable.")
                    self.presentEmptyMessage(true)
                    self.presentLoadingView(false)
                    break
                }
                
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTxt.resignFirstResponder()
        searchBtnTapped(self)
        return true
    }
    
    private func presentEmptyMessage(_ status: Bool) {
        
        if status == true {
            self.emptySearchMsg.isHidden = false
            self.usersTV.isHidden = true
        } else {
            self.emptySearchMsg.isHidden = true
            self.usersTV.isHidden = false
        }

    }

}
