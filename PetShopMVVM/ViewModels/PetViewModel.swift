//
//  EmployeesViewModel.swift
//  jadidi
//
//  Created by Leila Nezaratizadeh on 20/04/2022.
//

import Foundation

class PetViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var petData : [Pet]! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        self.apiService.apiToGetEmployeeData { (petData) in
            self.petData = petData
        }
    }
}
