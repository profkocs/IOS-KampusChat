//
//  DepartmentViewController.swift
//  KampusChat
//
//  Created by Burak on 18.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController {

    
    @IBOutlet weak var tableViewDepartments: UITableView!
    
    var departments:[Academic]? = []
    
    var signupViewModel:SignupViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        tableViewDepartments.delegate = self
        tableViewDepartments.dataSource = self
        
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
        
        let faculty_id = signupViewModel!.signup.facultyId
        url = ApiURL.departments.rawValue + "?id=" + String(faculty_id!)
        
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
        
        getDepartmentList()
        updateTable()
        
    }
    
    private func showError(error:[String]?){
        
        let message = error![0]
        
        showToastMessage(message: message)
        
    }
    
    // Getting City List From AcademicViewModel
    
    private func getDepartmentList(){
        
        self.departments = academicViewModel?.getAcademicList(key: AuthServiceKeys.department.rawValue)
        
    }
    
    // Handling TableView
    
    private func updateTable(){
        
        DispatchQueue.main.async {
            
            Log.info(key: "updateTable",value: "is Begun")
            
            self.tableViewDepartments.reloadData()
        }
    }
    
    // Setting SignupViewModel
    private func selectRow(row:Int){
        
        var signup = Signup()
        
        signup.departmentId = departments![row].id
        
        signupViewModel = SignupViewModel(signup: signup)
        
    }
    
    // Segues
    
    private func showPasswordScreen(){
        
        self.performSegue(withIdentifier: SegueKeys.department_to_password.rawValue, sender: nil)
    }
    
    
    // Sending SignupViewModel To NextViewController via Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let passwordScreen = segue.destination as? PasswordViewController {
            
            passwordScreen.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From Previous ViewController
        if let faculty = segue.destination as? FacultyViewController {
            
            signupViewModel = faculty.signupViewModel
        }
        
        
    }
}

extension DepartmentViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(row:indexPath.row)
        showPasswordScreen()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (departments?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewDepartments.dequeueReusableCell(withIdentifier: "departmentCell",for:indexPath)
        cell.textLabel?.text = "" + String(indexPath.row+1) + ". " + departments![indexPath.row].name
        return cell
        
    }
    
}
