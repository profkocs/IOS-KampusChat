//
//  UniversityViewController.swift
//  KampusChat
//
//  Created by Burak on 16.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class UniversityViewController: UIViewController {

   
    @IBOutlet weak var tableViewUniversities: UITableView!
    
    var universities:[Academic]? = []
    
    var signupViewModel:SignupViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        tableViewUniversities.delegate = self
        tableViewUniversities.dataSource = self
        
        startSpinner()
        
        prepareUrl()
        
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
    
    
    // URL
    private var url:String?
    
    private func prepareUrl(){
        
        let city_id = signupViewModel!.model.cityId
        url = ApiURL.universities.rawValue + "?id=" + String(city_id!)
        
    }
    
    
    // Setting AcademicView Model
    
    private var academicViewModel:AcademicViewModel?
    
    private func setAcademicViewModel(){
        
        // View Model
        self.academicViewModel = AcademicViewModel(url: self.url!)
        
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
        
        getUniversityList()
        updateTable()
        
    }
    
    private func showError(error:[String]?){
        
        let message = error![0]
        
        showToastMessage(message: message)
        
    }
    
    // Getting City List From AcademicViewModel
    
    private func getUniversityList(){
        
        self.universities = academicViewModel?.getAcademicList(key: AuthServiceKeys.university.rawValue)
        
    }
    
    // Handling TableView
    
    private func updateTable(){
        DispatchQueue.main.async {
            
            Log.info(key: "updateTable",value: "is Begun")
            
            self.tableViewUniversities.reloadData()
        }
    }
    
    // Setting SignupViewModel
    private func selectRow(row:Int){
        
        let universityId = universities![row].id
        
        signupViewModel?.model.universityId = universityId
        
    }
    
    // Segues
    
    private func showFacultyScreen(){
        self.performSegue(withIdentifier: SegueKeys.university_to_faculty.rawValue, sender: nil)
    }
    
    
    // Sending SignupViewModel To NextViewController via Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let faculty = segue.destination as? FacultyViewController {
            
            faculty.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From Previous ViewController
        if let city = segue.destination as? CityViewController {
            signupViewModel = city.signupViewModel
        }
        
        
    }
    
  
}

extension UniversityViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(row:indexPath.row)
        showFacultyScreen()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (universities?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewUniversities.dequeueReusableCell(withIdentifier: "universityCell",for:indexPath)
        cell.textLabel?.text = "" + String(indexPath.row+1) + ". " + universities![indexPath.row].name
        return cell
        
    }

}
