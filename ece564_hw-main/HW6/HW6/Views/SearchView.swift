//
//  SearchView.swift
//  HW5
//
//  Created by Loaner on 2/21/22.
//

import SwiftUI

struct SearchView: View {
    @State var textFieldInput: String = ""
    @State var peopleSearched:[DukePerson] = []
    @State var flag: Bool = false
    
    func findByNetID(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if stringToCompare == p.netID{
                peopleSearched.append(p)
            }
        }
    }
    
    func findByFirstName(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if stringToCompare == p.firstName.lowercased(){
                peopleSearched.append(p)
            }
        }
    }
    
    func findByLastName(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if stringToCompare == p.lastName.lowercased(){
                peopleSearched.append(p)
            }
        }
    }
    
    func findById(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if stringToCompare == p.id.lowercased(){
                peopleSearched.append(p)
            }
        }
    }
    
    func findByWhereFrom(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if p.whereFrom.lowercased().contains(stringToCompare){
                peopleSearched.append(p)
            }
        }
    }
    
    func findByLanguages(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            let tempLangs: String = convertToString(p.languages)
            if tempLangs.lowercased().contains(stringToCompare){
                peopleSearched.append(p)
            }
        }
    }
    
    func findByHobbies(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            let temp = convertToString(p.hobbies)
            if temp.contains(stringToCompare){
                peopleSearched.append(p)
            }
        }
    }
    
    func findByDegree(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if stringToCompare == p.degree.lowercased(){
                peopleSearched.append(p)
            }
        }
    }
    func findByTeam(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if stringToCompare == p.team.lowercased(){
                peopleSearched.append(p)
            }
        }
    }
    func findByEmail(){
        let stringToCompare: String = textFieldInput.lowercased()
        for p in PeopleList{
            if stringToCompare == p.email.lowercased(){
                peopleSearched.append(p)
            }
        }
    }
    func findWrapper(){
        peopleSearched = []
        findByNetID()
        if (peopleSearched.count == 0){
            findByLastName()
            if (peopleSearched.count == 0){
                findByFirstName()
                if (peopleSearched.count == 0){
                    findById()
                    if (peopleSearched.count == 0){
                        findByWhereFrom()
                        if (peopleSearched.count == 0){
                            findByTeam()
                            if (peopleSearched.count == 0){
                                findByEmail()
                                if (peopleSearched.count == 0){
                                    findByDegree()
                                    if (peopleSearched.count == 0){
                                        findByHobbies()
                                        if (peopleSearched.count == 0){
                                            findByLanguages()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    TextField("Search for People", text: $textFieldInput)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .font(.title3)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    Button("Find"){
                        findWrapper()
                    }
                }
                Text("Search Results")
                    .font(.title3)
                    .fontWeight(.medium)
                ForEach($peopleSearched, id: \.netID){$currentPerson in
                    PersonRow(person: currentPerson)
                        .padding()
                }
                
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
