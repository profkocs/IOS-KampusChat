//
//  FacultyViewController.swift
//  KampusChat
//
//  Created by Burak on 16.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class FacultyViewController: UIViewController {

    
    @IBOutlet weak var tableViewFaculties: UITableView!
    
    var signupViewModel:SignupViewModel?
    
    var faculties:[Academic]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        tableViewFaculties.delegate = self
        tableViewFaculties.dataSource = self
        
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
        
        let university_id = signupViewModel!.model.universityId
        url = ApiURL.faculties.rawValue + "?id=" + String(university_id!)
        
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
        
        getFacultyList()
        updateTable()
        
    }
    
    private func showError(error:[String]?){
        
        let message = error![0]
        
        showToastMessage(message: message)
        
    }
    
    // Getting City List From AcademicViewModel
    
    private func getFacultyList(){
        
        self.faculties = academicViewModel?.getFacultyList()
        
    }
    
    // Handling TableView
    
    private func updateTable(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "updateTable",value: "is Begun")
            
            self.tableViewFaculties.reloadData()
        }
    }
    
    // Setting SignupViewModel
    private func selectRow(row:Int){
        
        let faculty_id = faculties![row].id
        
        signupViewModel?.model.facultyId = faculty_id
        
    }
    
    // Segues
    
    private func showDepartmentScreen(){
        
        self.performSegue(withIdentifier: SegueKeys.faculty_to_department.rawValue, sender: nil)
    }
    
    
    // Sending SignupViewModel To NextViewController via Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let department = segue.destination as? DepartmentViewController {
            
            department.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From Previous ViewController
        if let university = segue.destination as? UniversityViewController {
            
            signupViewModel = university.signupViewModel
        }
        
        
    }
    
}

extension FacultyViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(row:indexPath.row)
        showDepartmentScreen()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (faculties?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewFaculties.dequeueReusableCell(withIdentifier: "facultyCell",for:indexPath)
        cell.textLabel?.text = "" + String(indexPath.row+1) + ". " + faculties![indexPath.row].name
        return cell
        
    }
    
}
