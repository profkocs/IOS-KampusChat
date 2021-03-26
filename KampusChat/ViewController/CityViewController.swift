//
//  CityViewController.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

/**
 Class Responsibility ->
 
 - Showing and Removing Spinner
 - Showing Toast Message
 - Setting AcademicViewModel
 - Starting Action
 - Handling Data and Error
 - Getting City List From AcademicViewModel
 - Showing Error Message
 - Handling TableView Actions
 - Setting SignupViewModel
 - Directing another screen.
 - Sending SignupViewModel To Next ViewController
 
 
 Class Dependencies ->
 
 - SpinnerViewController
 - Toast
 - SignupViewModel
 - AcademicViewModel
 */


import UIKit


class CityViewController: UIViewController{
    
    
    @IBOutlet weak var tableViewCities: UITableView!
    
    var cities:[Academic]? = []
    
    var signupViewModel:SignupViewModel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // TableView
        tableViewCities.delegate = self
        tableViewCities.dataSource = self
        
        startSpinner()
        
        setAcademicViewModel()
        
        startAction()
       
    }
    
    // Showing and Removing Spinner
    
    private let spinner = SpinnerViewController()
    
    private func startSpinner(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "startSpinner()",value: "is Begun")
            
            self.spinner.showSpinner(viewController: self)
        }
        
    }
    
    private func stopSpinner(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "stopSpinner()",value: "is Begun")
            
            self.spinner.disableSpinner()
        }
    }
    
    
    // Showing Toast Message
    
    private let toast = Toast()
    
    private func showToastMessage(message:String){
        
        DispatchQueue.main.async {
            
            Log.info(key: "showToastMessage()",value: "is Begun")
            
            self.toast.showToast(message:message,viewController:self)
        }
        
    }
    
    
    // Setting AcademicView Model
    
    private var academicViewModel:AcademicViewModel?
    
    private var url = ApiURL.cities.rawValue
    

    private func setAcademicViewModel(){
        
        // View Model
        self.academicViewModel = AcademicViewModel(url: self.url)
        
        // View Model Binding
        setAcademicViewModelBinding()
        
    }
    
    private func setAcademicViewModelBinding(){
        
        academicViewModel!.bindViewModelToController = {
            
            Log.info(key: "setAcademicViewModelBinding", value: "is Begun")
            
            // Handle Response
            self.handleResponse(error: self.academicViewModel?.error)
            
            
            // Spinner
            self.stopSpinner()
            
        }
        
    }
    
    // Starting Action
    private func startAction(){
        
        academicViewModel?.startAction()
    }
    
    
    // Handling Data and Error
    
    private func handleResponse(error:[String]?){
        
        if(error != nil){
            
            Log.info(key: "handleResponse", value: "error")
            
            showError(error:error)
            return
        }
        
        getCityList()
        updateTable()
        
    }
    
    private func showError(error:[String]?){
        
        let message = error![0]
        
        showToastMessage(message: message)
        
    }
    
    // Getting City List From AcademicViewModel
    
    private func getCityList(){
    
        self.cities = academicViewModel?.getAcademicList(key: AuthServiceKeys.city.rawValue)
        
    }
    
    // Handling TableView
    
    private func updateTable(){
        DispatchQueue.main.async {
            
            Log.info(key: "updateTable",value: "is Begun")
            
            self.tableViewCities.reloadData()
        }
    }
    
    // Setting SignupViewModel
    private func selectRow(row:Int){
        
        var signup = Signup()
        
        signup.cityId = cities![row].id
        
        signupViewModel = SignupViewModel(signup: signup)
        
    }
    
    // Segues
    
    private func showUniversityScreen(){
        self.performSegue(withIdentifier: SegueKeys.city_to_university.rawValue, sender: nil)
    }
    
    
    // Sending SignupViewModel To NextViewController via Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let university = segue.destination as? UniversityViewController {
            
            university.signupViewModel = self.signupViewModel
        }
    }
    
    
    
    
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectRow(row:indexPath.row)
        
        showUniversityScreen()
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
