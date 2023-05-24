//
//  ContentView.swift
//  MediWork
//
//  Created by Polina Smirnova on 23.05.2023.
//

import SwiftUI

struct ContentView: View {
    private let presenter = PersonPresenter()
    private var persons: [PersonModel] { presenter.getPersons() }
    @State private var isExpanded = false
    @State private var sortOption: SortOption = .id
    @State private var sortedPersons: [PersonModel] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if isExpanded {
                    Picker("Sort Option", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.displayName).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                }
                
                List {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(sortedPersons, id: \.id) { person in
                                CardView(person: person)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                sortedPersons = sortPersons()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isExpanded.toggle()
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onChange(of: sortOption) { _ in
                sortedPersons = sortPersons()
            }
        }
    }
    init() {
        presenter.parseJSON(from: "test-data")
    }

    func sortPersons() -> [PersonModel] {
        switch sortOption {
        case .id:
            return persons.sorted { $0.id < $1.id }
        case .firstName:
            return persons.sorted { $0.firstName < $1.firstName }
        case .lastName:
            return persons.sorted { $0.lastName < $1.lastName }
        case .createdDate:
            return persons.sorted { $0.created < $1.created }
        case .company:
            return persons.sorted { $0.roleTitle < $1.roleTitle }
        case .status:
            return persons.sorted { $0.engagementType < $1.engagementType }
        case .phone:
            return persons.sorted { $0.fixedLinePhone < $1.fixedLinePhone }
        case .mobile:
            return persons.sorted { ($0.mobilePhone ?? "") < ($1.mobilePhone ?? "") }
        case .email:
            return persons.sorted { ($0.email ?? "") < ($1.email ?? "") }
        }
    }
}

struct CardView: View {
    @State private var isExpanded = false
    let person: PersonModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ID: \(person.id)")
                .font(.headline)
            
            if isExpanded {
                Divider()
                Text("First Name: \(person.firstName)")
                    .font(.headline)
                Text("Last Name: \(person.lastName)")
                    .font(.headline)
                Text("Created Date: \(person.created)")
                    .font(.headline)
                Text("Company: \(person.roleTitle)")
                    .font(.headline)
                Text("Status: \(person.engagementType)")
                    .font(.headline)
                Text("Phone: \(person.fixedLinePhone)")
                    .font(.headline)
                Text("Mobile: \(person.mobilePhone ?? "")")
                    .font(.headline)
                Text("Email: \(person.email ?? "")")
                    .font(.headline)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

enum SortOption: String, CaseIterable {
    case id = "ID"
    case firstName = "First Name"
    case lastName = "Last Name"
    case createdDate = "Created Date"
    case company = "Company"
    case status = "Status"
    case phone = "Phone"
    case mobile = "Mobile"
    case email = "Email"
    
    var displayName: String {
        return rawValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
