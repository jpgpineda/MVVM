//
//  SchoolViewModel.swift
//  MVVM
//
//  Created by Javier Pineda Gonzalez on 18/08/22.
//

import Foundation

class SchoolViewModel {
    private let schoolsUrl = URL(string: "http://universities.hipolabs.com/search?country=United+States")!
    
    var schoolModel: [School]?
    
    func getSchools(completion: @escaping () -> ()) {
        let task = URLSession.shared.dataTask(with: schoolsUrl) { [weak self] data, response, error in
            if let error = error {
                print("Hubo un error \(error.localizedDescription)")
            } else {
                guard let data = data else { return }
                do {
                    let schools = try JSONDecoder().decode([School].self, from: data)
                    self?.schoolModel = schools
                    completion()
                } catch {
                    print("Hubo un error en el parseo de informacion \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
