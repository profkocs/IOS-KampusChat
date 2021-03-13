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
    var cities:[City]? = []
    let toast = Toast()
    let spinner = SpinnerViewController()
    var signupViewModel:SignupViewModel!
    var citiesViewModel = CitiesViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewCities.delegate = self
        tableViewCities.dataSource = self
        showSpinner()
        citiesViewModel.bindViewModelToController = {
            self.handleCitiesResponse(cities: self.citiesViewModel.cities, error: self.citiesViewModel.error)
        }
    }
    
    private func showSpinner(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
    
    
    func handleCitiesResponse(cities: [City]?, error: String?) {
        
        if(error == nil && cities != nil){
            self.cities = cities
            updateTable()
        }else{
            toast.showToast(message: NSLocalizedString("error_something_went_wrong", comment: ""), viewController: self)
        }
        
        stopSpinner()
        
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
        
     if let university = segue.destination as? UniversitiesViewController {
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
