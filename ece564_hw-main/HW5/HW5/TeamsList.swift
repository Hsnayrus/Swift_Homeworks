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
    var body: some View {
        let studentsList: [DukePerson] = getStudentsList()
        let teams: [String] = getTeams(studentsList)
        let teamWPeople: Dictionary<String, [DukePerson]> = getTeamsDict(teams)
        ForEach(Array(teamWPeople.keys).sorted(<), id: \.self){key in
            Text("\(key)").font(.title)
            ForEach(teamWPeople[key]!, id: \.netID){currentPerson in
                PersonRow(person: currentPerson)
            }
            
        }
        
    }
}

struct TeamsList_Previews: PreviewProvider {
    static var previews: some View {
        TeamsList()
    }
}
