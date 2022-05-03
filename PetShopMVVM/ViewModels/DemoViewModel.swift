//
//  DemoViewModel.swift
//  PetShopMVVM
//
//  Created by Leila Nezaratizadeh on 02/05/2022.
//

import Foundation

final class DemoViewModel: NSObject {
    
    private var apiService : APIService!

    var state = State(petData: []) {
        didSet {
            callback(state)
        }
    }
    var callback: (State) -> ()
    
    init(callback: @escaping (State) -> ()) {
        self.apiService =  APIService()
        self.callback = callback
    }
    
    func loadData(sourceURL: URL) {
        self.apiService.apiToGetPetData(sourceURL: sourceURL) { (petData) in
            self.state.petData = petData
        }
    }
    
    func editData(pet:Pet!, sourceURL: URL) {
        self.apiService.apiToEditPetData(sourceURL: sourceURL, pet: pet) 
    }
    
    func deletePet(pet:Pet!, sourceURL: URL) {
        self.apiService.deletePet(sourceURL: sourceURL, pet:pet )
    }
}
