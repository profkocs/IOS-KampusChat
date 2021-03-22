//
//  UniversityViewController.swift
//  KampusChat
//
//  Created by Burak on 16.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class UniversityViewController: UIViewController {

    var universities:[Academic]? = []
    let toast = Toast()
    let spinner = SpinnerViewController()
    var signupViewModel:SignupViewModel!
    var viewModel: AcademicViewModel!
    
    var url:String = ""
    
    @IBOutlet weak var tableViewUniversities: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewUniversities.delegate = self
        tableViewUniversities.dataSource = self
        showSpinner()
        prepareURL()
        viewModel = AcademicViewModel(url:self.url, key: AcademicKeys.university.rawValue)
        
        viewModel.bindViewModelToController = {
            self.handleUniversitiesResponse(universities: self.viewModel.datas, error: self.viewModel.error)
        }
        
    }
    
    private func prepareURL(){
        let city_id = signupViewModel.signup.cityId!
        url = ApiURL.universities.rawValue + "?id=" + String(city_id)
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
    
    
    func handleUniversitiesResponse(universities: [Academic]?, error: String?) {
        
        if(error == nil && universities != nil){
            self.universities = universities
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
            self.tableViewUniversities.reloadData()
        }
    }
    
    private func selectRow(row:Int){
        signupViewModel.signup.universityId = universities![row].id
        
    }
    
    private func showFaculties(){
        self.performSegue(withIdentifier: "universitiesTOfaculties", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Log.info(key: "prepare", value: "is Begun")
        
        // Sending Data To FacultyViewController
        if let faculty = segue.destination as? FacultyViewController {
            faculty.signupViewModel = self.signupViewModel
            
        }
        
        // Getting Data From CityViewController
        if let cities = segue.destination as? CityViewController {
            signupViewModel = cities.signupViewModel
        }
        
        
    }
    
    
}

extension UniversityViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(row:indexPath.row)
        showFaculties()
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
