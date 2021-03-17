//
//  CityViewController.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit


class CityViewController: UIViewController{
    
    
    @IBOutlet weak var tableViewCities: UITableView!
    var cities:[Academic]? = []
    let toast = Toast()
    let spinner = SpinnerViewController()
    var signupViewModel:SignupViewModel!
    var viewModel = AcademicViewModel(url:ApiURL.cities.rawValue, key: AcademicKeys.city.rawValue)
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewCities.delegate = self
        tableViewCities.dataSource = self
        showSpinner()
        viewModel.bindViewModelToController = {
            self.handleCitiesResponse(cities: self.viewModel.datas, error: self.viewModel.error)
        }
    }
    
    private func showSpinner(){
        DispatchQueue.main.async{
            Log.info(key: "showSpinner",value: "is Begun")
            self.spinner.showSpinner(viewController: self)
        }
    }
    
    private func stopSpinner(){
        DispatchQueue.main.async {
            Log.info(key: "stopSpinner",value: "is Begun")
            self.spinner.disableSpinner()
        }
    }
    
    
    func handleCitiesResponse(cities: [Academic]?, error: String?) {
        
        if(error == nil && cities != nil){
            self.cities = cities
            updateTable()
        }else{
            showToastMessage()
        }
        
        stopSpinner()
        
    }
    
    private func showToastMessage(){
        DispatchQueue.main.async {
            self.toast.showToast(message: NSLocalizedString("error_something_went_wrong", comment: ""), viewController: self)
        }
    }
    
    private func updateTable(){
        DispatchQueue.main.async {
            Log.info(key: "updateTable",value: "is Begun")
            self.tableViewCities.reloadData()
        }
    }
    
    private func selectRow(row:Int){
        var signup = Signup()
        signup.city_id = cities![row].id
        signupViewModel = SignupViewModel(signup: signup)
        
    }
    
    private func showUniversities(){
        self.performSegue(withIdentifier: "citiesTOuniversities", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let university = segue.destination as? UniversityViewController {
            university.signupViewModel = self.signupViewModel
        }
     }
    
    
    
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(row:indexPath.row)
        showUniversities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cities?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewCities.dequeueReusableCell(withIdentifier: "cityCell",for:indexPath)
        cell.textLabel?.text = "" + String(indexPath.row+1) + ". " + cities![indexPath.row].name
        return cell
        
    }
    
}
