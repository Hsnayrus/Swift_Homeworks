//
//  ListView.swift
//  HW5
//
//  Created by Loaner on 2/13/22.
//

import SwiftUI

struct ListView: View {
    @State private var showSearch: Bool = false
    //MARK: Delete This
    @State private var tempImage: UIImage = UIImage(systemName: "MaleAvatar")  ?? UIImage(data: Data(maleAvatarData!))!
    var body: some View {
        let professorList: [DukePerson] = getProfessorList()
        let TAList:[DukePerson] = getTAList()
        let othersList: [DukePerson] = getOthersList()
        if(professorList.count != 0){
            ZStack {
                AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), center: .bottom)
                List{
                    if(professorList.count != 0){
                        Text("Instructor").font(.title)
                        ForEach(professorList, id: \.netID){currentPerson in
                            PersonRow(person: currentPerson)
                        }
                    }
                    
                    if(TAList.count != 0){
                        Text("Teaching Assistant").font(.title)
                        ForEach(TAList, id: \.netID){currentPerson in
                            PersonRow(person: currentPerson)
                        }
                    }
                    
                    TeamsList()
                    if(othersList.count != 0){
                        Text("Others").font(.title)
                        ForEach(othersList, id: \.netID){currentPerson in
                            PersonRow(person: currentPerson)
                        }
                    }
                    
                }
            }.toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        showSearch = true
                    }label:{
                        Label("Search", systemImage: "magnifyingglass.circle.fill")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        navBarSaveFunction()
                    }label:{
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        refreshServer()
                    }label:{
                        Label("Refresh from Server", systemImage: "arrow.clockwise.circle")
                    }
                }
            }
            .sheet(isPresented: $showSearch){
                SearchView()
            }
            .onDisappear{
                for p in PeopleList{
                    grammarPeople.append(convertToGrammar(p))
                }
                saveDukePerson.savePeople(peopleToSave: grammarPeople)
            }
        }
        else{
            DownloadView()
        }
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
