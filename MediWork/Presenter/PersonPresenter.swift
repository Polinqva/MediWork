//
//  PersonPresenter.swift
//  MediWork
//
//  Created by Polina Smirnova on 24.05.2023.
//

import Foundation

class PersonPresenter {
    private var persons: [PersonModel] = []

    func parseJSON(from file: String) {
        if let fileURL = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                persons = try decoder.decode([PersonModel].self, from: jsonData)
            } catch {
                print(String(describing: error))
            }
        } else {
            print("JSON file not found")
        }
    }

    func getPersons() -> [PersonModel] {
        return persons
    }
}
