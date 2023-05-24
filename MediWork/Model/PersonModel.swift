//
//  PersonModel.swift
//  MediWork
//
//  Created by Polina Smirnova on 24.05.2023.
//

import Foundation

struct PersonModel: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let created: String
    let engagementType: String
    let roleTitle: String
    let fixedLinePhone: String
    let mobilePhone: String?
    let email: String?
}
