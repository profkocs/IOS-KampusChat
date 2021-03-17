//
//  DepartmentViewController.swift
//  KampusChat
//
//  Created by Burak on 18.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController {

    var departments:[Academic]? = []
    let toast = Toast()
    let spinner = SpinnerViewController()
    var signupViewModel:SignupViewModel!
    var viewModel: AcademicViewModel!
    
    var url:String = ""
    
    
    @IBOutlet weak var tableViewDepartments: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewDepartments.delegate = self
        tableViewDepartments.dataSource = self
        showSpinner()
        prepareURL()
        viewModel = AcademicViewModel(url:self.url, key: AcademicKeys.department.rawValue)
        
        viewModel.bindViewModelToController = {
            self.handleDepartmentsResponse(departments: self.viewModel.datas, error: self.viewModel.error)
        }
        
    }
    
    private func prepareURL(){
        let faculty_id = signupViewModel.signup.faculty_id!
        url = ApiURL.departments.rawValue + "?id=" + String(faculty_id)
    }
    
    private func showSpinner(){
        DispatchQueue.main.async {
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
    
    
    func handleDepartmentsResponse(departments: [Academic]?, error: String?) {
        
        if(error == nil && departments != nil){
            self.departments = departments
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
            self.tableViewDepartments.reloadData()
        }
    }
    
    private func selectRow(row:Int){
        signupViewModel.signup.department_id = departments![row].id
        
    }
    
    private func showCreateUser(){
        self.performSegue(withIdentifier: "departmentsTOcreateUser", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Log.info(key: "prepare", value: "is Begun")
        
        // Sending Data To CreateViewController
        if let createUser = segue.destination as? CreateUserViewController {
            createUser.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From FacultyViewController
        if let faculty = segue.destination as? FacultyViewController {
            signupViewModel = faculty.signupViewModel
        }
        
        
    }
    
    
}

extension DepartmentViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(row:indexPath.row)
        showCreateUser()
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
