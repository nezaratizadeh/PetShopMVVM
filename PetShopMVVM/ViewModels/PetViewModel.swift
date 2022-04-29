//
//  EmployeesViewModel.swift
//  jadidi
//
//  Created by Leila Nezaratizadeh on 20/04/2022.
//

import Foundation

class PetViewModel : NSObject {
    
    private var apiService : APIService!
    private var url : URL = URL(string: "https://petstore.swagger.io/v2/pet/findByStatus?status=pending")!
    private(set) var petData : [Pet]! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
     init(url:URL) {
        super.init()
        self.apiService =  APIService()
        self.url = url
        callFuncToGetPetData()
    }
    
    func callFuncToGetPetData() {
        self.apiService.apiToGetPetData(sourceURL: url) { (petData) in
            self.petData = petData
        }
    }
}
