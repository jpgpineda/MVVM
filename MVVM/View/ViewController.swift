//
//  ViewController.swift
//  MVVM
//
//  Created by Javier Pineda Gonzalez on 18/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var schoolsTable: UITableView!
    var schools: [School] = [School]()
    var viewModel = SchoolViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolsTable.dataSource = self
        viewModel.getSchools { [weak self] in
            guard let schools = self?.viewModel.schoolModel else { return }
            self?.schools = schools
            DispatchQueue.main.async {
                self?.schoolsTable.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath)
        var listConfiguration = UIListContentConfiguration.cell()
        let school = schools[indexPath.row]
        listConfiguration.text = school.name + " " + school.country
        cell.contentConfiguration = listConfiguration
        return cell
    }
}

