//
//  FacultyViewController.swift
//  KampusChat
//
//  Created by Burak on 16.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class FacultyViewController: UIViewController {

    
    var faculties:[Academic]? = []
    let toast = Toast()
    let spinner = SpinnerViewController()
    var signupViewModel:SignupViewModel!
    var viewModel: AcademicViewModel!
    
    var url:String = ""
    
    
    @IBOutlet weak var tableViewFaculties: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFaculties.delegate = self
        tableViewFaculties.dataSource = self
        showSpinner()
        prepareURL()
        viewModel = AcademicViewModel(url:self.url, key: AcademicKeys.faculty.rawValue)
        
        viewModel.bindViewModelToController = {
            self.handleFacultiesResponse(faculties: self.viewModel.datas, error: self.viewModel.error)
        }
        
    }
    
    private func prepareURL(){
        let university_id = signupViewModel.signup.universityId!
        url = ApiURL.faculties.rawValue + "?id=" + String(university_id)
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
    
    
    func handleFacultiesResponse(faculties: [Academic]?, error: String?) {
        
        if(error == nil && faculties != nil){
            self.faculties = faculties
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
            self.tableViewFaculties.reloadData()
        }
    }
    
    private func selectRow(row:Int){
        signupViewModel.signup.facultyId = faculties![row].id
        
    }
    
    private func showDepartments(){
        self.performSegue(withIdentifier: "facultiesTOdepartments", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Log.info(key: "prepare", value: "is Begun")
        
        // Sending Data To DepartmentViewController
        if let department = segue.destination as? DepartmentViewController {
            department.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From UniversityViewController
        if let university = segue.destination as? UniversityViewController {
            signupViewModel = university.signupViewModel
        }
        
        
    }
    
    
}

extension FacultyViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(row:indexPath.row)
        showDepartments()
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
