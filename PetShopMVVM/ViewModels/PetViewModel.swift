//
//  EmployeesViewModel.swift
//  jadidi
//
//  Created by Leila Nezaratizadeh on 20/04/2022.
//

import Foundation

class PetViewModel : NSObject {
    
    private var pet: Pet!
    private var apiService : APIService!
    private var url : URL = URL(string: "https://petstore.swagger.io/v2/pet/findByStatus?status=pending")!
    private(set) var petData : [Pet]! {
        didSet {
            self.bindEmployeeViewModelToController()
        }        
    }
    
    
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    init(url:URL,pet:Pet) {
        super.init()
        self.apiService =  APIService()
        self.url = url
        if pet == nil {
            callFuncToGetPetData()
        } else  {
            editPetData(pet:pet)
        }
    }
    
    func callFuncToGetPetData() {
        self.apiService.apiToGetPetData(sourceURL: url) { (petData) in
            self.petData = petData
        }
    }
    
    func editPetData(pet:Pet) {
        self.apiService.apiToEditPetData(sourceURL: url,pet: pet)
    }
}
