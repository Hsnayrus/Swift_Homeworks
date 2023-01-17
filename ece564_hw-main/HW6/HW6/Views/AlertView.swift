//
//  AlertView.swift
//  HW4
//
//  Created by Loaner on 2/9/22.
//

import SwiftUI

func primaryButtonAction() -> Bool{
    let tempPeopleList: [grammar564]? = saveDukePerson.loadData()
    if let tempPeopleList = tempPeopleList {
        grammarPeople = tempPeopleList
        PeopleList = convertGrammarToDukePerson(grammarPeople) ?? []
//        for person in grammarPeople{
//            print("AlertView/pimaryButtonAction, not entering loop")
//            print(person.netid)
//        }
        return true
    }
    else{
        return false
    }
}

func secondaryButtonAction(){
    refreshServer()
}


struct AlertView: View {
    @State private var showingAlert = true
    @State private var secondAlert:Bool = false

        var body: some View {
            MainScreen()
                .onAppear{
                    if(grammarPeople.count == 0){
                        let newPerson: DukePerson = DukePerson()
                        newPerson.setValuesFromJson(gender: .Male, fName: "Suryansh", lName: "Jain", whereFrom: "Mumbai, Maharashtra, India", hobbies: ["Gaming", "Partying"], age: 22, profession: .Student, degree: "MS ECE", languages: ["C", "C++", "Java", "Swift", "Python"], team: "Moody", email: "suryansh.jain@duke.edu", netID: "sj346", department: "None", ID: "sj346")
                        newPerson.pPhoto = UIImage(named: "MaleAvatar")
                        PeopleList.append(newPerson)
                        let anotherPerson: DukePerson = DukePerson()
                        anotherPerson.setValuesFromJson(gender: .Male, fName: "Richard", lName: "Telford", whereFrom: "Chatham County, NC", hobbies: ["Biking"], age: 0, profession: .Professor, degree: "None", languages: ["Objective C", "Swift"], team: "None", email: "rt113@duke.edu", netID: "rt113", department: "ECE", ID: "rt113")
                        anotherPerson.pPhoto = UIImage(named: "MaleAvatar")
                        PeopleList.append(anotherPerson)
//                        if let tempPeople = loadInitialData(){
//                            PeopleList = convertGrammarToDukePerson(tempPeople) ?? []
//                            grammarPeople = tempPeople
//                        }
                        
                    }
                }
        }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
