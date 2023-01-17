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
                        if let tempPeople = loadInitialData(){
                            PeopleList = convertGrammarToDukePerson(tempPeople) ?? []
                            grammarPeople = tempPeople
                        }
                    }
                }
        }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
