//
//  TeamsList.swift
//  HW5
//
//  Created by Loaner on 2/14/22.
//

import SwiftUI

//extension Dictionary{
//    static func >(_ person: [String:[DukePerson]], newPerson: [String:[DukePerson]]) -> [String:[DukePerson]]{
//        var personKeys = person.keys
//        var newPersonKeys = newPerson.keys
//        personKeys = personKeys.sorted(by: >)
//        newPersonKeys = newPersonKeys.sorted(by: >)
//        if(personKeys > newPersonKeys){
//            return person
//        }
//        else{
//            return newPerson
//        }
//    }
//}

struct TeamsList: View {
    @StateObject var teams: DukePeople = DukePeople(studentsList)
    private func deleteStudents(at offsets: IndexSet){
        print(finalStudentsList.count)
        print(studentsList.count)
        teamWPeople = getTeamsDict(getTeams(studentsList))
        finalStudentsList = Array(teamWPeople.keys).sorted(by: <)
        print(finalStudentsList.count)
        print(studentsList.count)
        teams.updateWithList(studentsList)
    }
    var body: some View {
        ForEach(finalStudentsList, id: \.self){key in
            Text("\(key)").font(.title)
            ForEach(teamWPeople[key]!, id: \.netID){currentPerson in
                PersonRow(person: currentPerson)
            }
        }
        .onDelete(perform: deleteStudents)
        .environmentObject(teams)
        
    }
}

struct TeamsList_Previews: PreviewProvider {
    static var previews: some View {
        TeamsList()
    }
}
