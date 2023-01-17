//
//  ListView.swift
//  HW5
//
//  Created by Loaner on 2/13/22.
//

import SwiftUI

struct ListView: View {
    @State private var showSearch: Bool = false
    @State var showDownloadView: Bool  = false
    @StateObject var professors: DukePeople = DukePeople(getProfessorList())
    @StateObject var tas: DukePeople = DukePeople(getTAList())
    @StateObject var others: DukePeople = DukePeople(getOthersList())
    @StateObject var students: DukeStudents = DukeStudents(teamWPeople)
    @StateObject var people: DukePeople = DukePeople(PeopleList)
    @StateObject var person: PersonObs = PersonObs(DukePerson())
    @State var flag: Bool = false
    
    var body: some View {
        
        if(getProfessorList().count != 0){
            List{
                if(professorList.count != 0){
                    Text("Instructor").font(.title)
                    ForEach(professorList, id: \.netID){currentPerson in
                        PersonRow(person: currentPerson)
                            .environmentObject(person)
                            .sheet(isPresented: $flag, onDismiss: {
                                flag = false
                            }){
                                ContentView(person: currentPerson)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                Button("Delete"){
                                    var i: Int = 0
                                    for p in professorList{
                                        if p.netID == currentPerson.netID{
                                            break
                                        }
                                        i = i + 1
                                    }
                                    professorList.remove(at: i)
                                    professors.updateWithList(professorList)
                                }
                                .tint(.red)
                                Button("Edit"){
                                    person.updatePerson(currentPerson)
                                    flag = true
                                }
                                .tint(.blue)
                            }
                    }
                    
                }
                
                if(TAList.count != 0){
                    Text("Teaching Assistant").font(.title)
                    ForEach(TAList, id: \.netID){currentPerson in
                        PersonRow(person: currentPerson)
                            .sheet(isPresented: $flag, onDismiss: {
                                flag = false
                            }){
                                ContentView(person: currentPerson)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                Button("Delete"){
                                    var i: Int = 0
                                    for p in TAList{
                                        if p.netID == currentPerson.netID{
                                            break
                                        }
                                        i = i + 1
                                    }
                                    TAList.remove(at: i)
                                    tas.updateWithList(TAList)
                                }
                                .tint(.red)
                                Button("Edit"){
                                    flag = true
                                }
                                .tint(.blue)
                            }
                    }
                }
                
                
                ForEach(Array(teamWPeople.keys).sorted(by: <), id: \.self){key in
                    Text("\(key)").font(.title)
                    ForEach(teamWPeople[key]!, id: \.netID){currentPerson in
                        PersonRow(person: currentPerson)
                            .sheet(isPresented: $flag, onDismiss: {
                                flag = false
                            }){
                                ContentView(person: currentPerson)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                Button("Delete"){
                                    var i: Int = 0
                                    if((teamWPeople[key]?.count) != 0){
                                        for p in teamWPeople[key]!{
                                            if p.netID == currentPerson.netID{
                                                break
                                            }
                                            i = i + 1
                                        }
                                        teamWPeople[key]?.remove(at: i)
                                        if(teamWPeople[key]?.count == 0){
                                            teamWPeople[key] = nil
                                        }
                                        students.updateWithDict(teamWPeople)
                                    }
                                }
                                .tint(.red)
                                Button("Edit"){
                                    flag = true
                                }
                                .tint(.blue)
                            }
                    }
                }
                
                if(othersList.count != 0){
                    Text("Others").font(.title)
                    ForEach(othersList, id: \.netID){currentPerson in
                        PersonRow(flag: flag, person: currentPerson)
                            .sheet(isPresented: $flag, onDismiss: {
                                flag = false
                            }){
                                ContentView(person: currentPerson)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                Button("Delete"){
                                    var i: Int = 0
                                    for p in othersList{
                                        if p.netID == currentPerson.netID{
                                            break
                                        }
                                        i = i + 1
                                    }
                                    othersList.remove(at: i)
                                    others.updateWithList(othersList)
                                }
                                .tint(.red)
                                Button("Edit"){
                                    flag = true
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
            .environmentObject(professors)
            .environmentObject(tas)
            .environmentObject(others)
            .environmentObject(students)
            .environmentObject(people)
            .environmentObject(person)
            .toolbar{
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
                        showDownloadView = true
                    }label:{
                        Label("Refresh from Server", systemImage: "arrow.clockwise.circle")
                    }
                }
            }
            .sheet(isPresented: $showDownloadView, onDismiss: {
                people.updateWithList(PeopleList)
                students.updateWithDict(getTeamsDict(getTeams(getStudentsList())))
            }){
                DownloadView()
            }
            .sheet(isPresented: $showSearch){
                SearchView()
            }
            .onAppear{
                professors.updateWithList(getProfessorList())
                students.updateWithDict(getTeamsDict(getTeams(getStudentsList())))
                tas.updateWithList(getTAList())
                others.updateWithList(getOthersList())
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
                .onDisappear{
                    people.updateWithList(PeopleList)
                }
        }
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

