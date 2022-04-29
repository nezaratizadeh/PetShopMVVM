//
//  ViewController.swift
//  PetShopMVVM
//
//  Created by Leila Nezaratizadeh on 21/04/2022.
//

import UIKit

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var statusButton: UIButton!
    
    private var petViewModel : PetViewModel!
        
    var statusData = [String]()

    let transparentView = UIView()

    let statusTableView = UITableView()
    
    @IBOutlet weak var petTableView: UITableView!{
        didSet {
            petTableView.delegate = self
            petTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petViewModel =  PetViewModel(url:URL(string: "https://petstore.swagger.io/v2/pet/findByStatus?status=pending")!)
        statusTableView.delegate = self
        statusTableView.dataSource = self
        statusTableView.register(StatusCell.self, forCellReuseIdentifier: "StatusCell")
//      callToViewModelForUIUpdate()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.petTableView {
            if let per = petViewModel.petData{
                return per.count
            } else {
            return 0
            }
        } else {
            return statusData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.petTableView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath)
            
        
            if  let name = petViewModel.petData[indexPath.row].name{
            cell.imageView?.image = UIImage(systemName: "\(name.first!.lowercased()).square")
            cell.textLabel?.text = name
        }
        else {
            cell.imageView?.image = UIImage(systemName: "n.square")
            cell.textLabel?.text = "No name"
        }
        return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell", for: indexPath)
            cell.textLabel?.text = statusData[indexPath.row]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == statusTableView {
            statusButton.setTitle(statusData[indexPath.row], for: .normal)
            removeTransparentView()
            petViewModel = PetViewModel(url:URL(string: "https://petstore.swagger.io/v2/pet/findByStatus?status=\(statusData[indexPath.row])")!)
            callToViewModelForUIUpdate()
        }
    }
    
    @IBAction func ChangeStatus(_ sender: Any) {
        statusData = ["sold","available","pending"]
        addTranparentView()
    }
    
    func addTranparentView() {
        let frames = statusButton.frame
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        statusTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(statusTableView)
        statusTableView.layer.cornerRadius = 5
        statusTableView.reloadData()
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.statusTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width + 30, height: CGFloat(self.statusData.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = statusButton.frame

        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.statusTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)    }
    
    
    func callToViewModelForUIUpdate(){
        petViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.petTableView.reloadData()
        }
    }
    
    
    
}

