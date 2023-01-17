//
//  DownloadView.swift
//  HW5
//
//  Created by Loaner on 2/20/22.
//

import SwiftUI

struct DownloadView: View {
    
    @State var progress: Double = 0
    let total: Double = 1
    
    @State var theTask: URLSessionDownloadTask?
    @State var observation: NSKeyValueObservation?
    var body: some View {
        ZStack{
            AngularGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), center: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            VStack{
                Text("Downloading Data from server. Please press List view again from Main screen")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding([.top, .leading, .bottom])
                    .opacity(1.0)
                    .cornerRadius(25.0)
                
                ProgressView(value: progress, total: total)
                    .progressViewStyle(.linear)
                    .padding(.all)
                    .accentColor(.white)
                    .scaleEffect(x: 1, y: 6, anchor: .center)
                
            }
        }
        .onAppear{
            let url: String = "http://kitura-fall-2021.vm.duke.edu:5640/b64entries"
            retrieveData(from: url)
        }
        .onDisappear{
//            print(PeopleList.count)
//            PeopleList = convertGrammarToDukePerson(grammarPeople)!
            professorList = getProfessorList()
            TAList = getTAList()
            studentsList = getStudentsList()
            teamWPeople = getTeamsDict(getTeams(studentsList))
            othersList = getOthersList()
        }
    }
    
    
    func retrieveData(from urlToUse: String) {
        let task = URLSession.shared
        let theTask = task.downloadTask(with: URL(string:urlToUse)!){data, response, error in
            
            if let data = data, let dataB = try? Data(contentsOf: data){
                var result: [grammar564]?
                do{
                    result = try JSONDecoder().decode([grammar564].self, from: dataB)
                }
                catch{
                    print(String(describing: error))
                }
                
                guard let json = result else{
                    print("Something wrong happened part 2")
                    return
                }
                //            saveDukePerson.savePeople(peopleToSave: json)
                for j in json{
                    pushData(object: j)
                }
            }
        }
        observation = theTask.progress.observe(\.fractionCompleted){observationProgress, _ in
            DispatchQueue.main.async{
                progress = observationProgress.fractionCompleted
            }
        }
        theTask.resume()
        //MARK- Saving people here after reloading data. Can be edited.
        //        for p in PeopleList{
        //            grammarPeople.append(convertToGrammar(p))
        //        }
        //        saveDukePerson.savePeople(peopleToSave: grammarPeople)
    }
    
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}
