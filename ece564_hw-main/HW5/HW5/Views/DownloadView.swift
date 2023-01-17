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
            AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), center: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            VStack{
                ProgressView("Press List View again from main screen", value : progress, total: total)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                    .accentColor(/*@START_MENU_TOKEN@*/.pink/*@END_MENU_TOKEN@*/)
                
            }
        }
        .onAppear{
            let url: String = "http://kitura-fall-2021.vm.duke.edu:5640/b64entries"
            retrieveData(from: url)
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
