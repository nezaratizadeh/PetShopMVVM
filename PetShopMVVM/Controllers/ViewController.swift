//
//  ViewController.swift
//  PetShopMVVM
//
//  Created by Leila Nezaratizadeh on 21/04/2022.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var petTableView: UITableView!
    
    private var petViewModel : PetViewModel!
    
    private var dataSource : PetTableViewDataSource<PetTableViewCell,Pet>!
//    private var dataSource: PetTableViewDataSource<PetTableViewCell, Pet>!

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.petViewModel =  PetViewModel()
        self.petViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = PetTableViewDataSource(cellIdentifier: "PetTableViewCell", items: self.petViewModel.petData, configureCell: { (cell, evm) in
            
            if let name = evm.name{
                cell.petNameLabel.text = name
            }
            else {
                cell.petNameLabel.text =  "No name"
            }
            
            
        })
        
        DispatchQueue.main.async {
            self.petTableView.dataSource = self.dataSource
            self.petTableView.reloadData()
        }
    }
    
}

