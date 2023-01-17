//
//  HW2App.swift
//  HW2
//
//  Created by Loaner on 1/23/22.
//

import SwiftUI

var newPerson: DukePerson = DukePerson()

//JSON Struct
struct grammar564: Codable{
    let firstname: String
    let lastname: String
    let wherefrom: String
    let gender: String
    let hobbies: [String]?
    let role: String
    let degree: String
    let languages: [String]?
    let picture: String?
    let team: String?
    let netid: String
    let email: String?
    let department: String?
    let id: String
}

//Error Checking function for person's gender
func parseGender(str genStr: String) -> Gender{
    if(genStr == "Female"){
        return .Female
    }
    else if(genStr == "NonBinary"){
        return .NonBinary
    }
    else{
        return .Male
    }
}

//Function that uploads a person's data to the server
func uploadData(person newPerson: DukePerson){
    let photoData = newPerson.pPhoto?.jpegData(compressionQuality: 1)
    let photoEncoded = photoData?.base64EncodedString()
    let photoToUpload = photoEncoded ?? ""
    let personData = grammar564(firstname: newPerson.firstName, lastname: newPerson.lastName, wherefrom: newPerson.whereFrom, gender: newPerson.gender.rawValue, hobbies: newPerson.hobbies, role: newPerson.profession.rawValue, degree: newPerson.degree, languages: newPerson.languages, picture: photoToUpload, team: newPerson.team, netid: newPerson.netID, email: newPerson.email, department: newPerson.department, id: newPerson.id)
    guard let dataToUpload = try? JSONEncoder().encode(personData) else{
        print("Problem in encoding")
        return
    }
    let urlToUploadTo = URL(string: "http://kitura-fall-2021.vm.duke.edu:5640/b64entries")!
    var urlReq = URLRequest(url: urlToUploadTo)
    urlReq.httpMethod = "POST"
    let loginString = "sj346:FF9250370FA4113D87E895C173ABFD39"
    guard let loginData = loginString.data(using: String.Encoding.utf8) else{
        print("Problem in coverting loginString to loginData")
        return
    }
    let loginStringB64 = loginData.base64EncodedString()
    urlReq.setValue("Basic \(loginStringB64)", forHTTPHeaderField: "Authorization")
    urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
    urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let task  = URLSession.shared.uploadTask(with: urlReq, from: dataToUpload){data, response, error in
        if let error = error{
            print("Error: \(error)")
            return
        }
        guard let response = response as? HTTPURLResponse,
        (200...299).contains(response.statusCode) else {
            print ("server error")
            return
        }
        if let mimetype = response.mimeType,
           mimetype == "applicaton/json",
           let data = data,
           let dataString = String(data: data, encoding: .utf8){
            print("Got this back: \(dataString)")
        }}
    task.resume()
    
}
//Profile pic setter
func parseProfilePic(pic jPicture: String?, gender gen: Gender){
    if let actualPhoto = jPicture{
        base64ImageStr = actualPhoto
    }
    else{
        if(gen == .Male){
            maleAvatar = UIImage(named: "MaleAvatar")
        }
        else if(gen == .Female){
            maleAvatar = UIImage(named: "FemaleAvatar")
        }
        else{
            maleAvatar = UIImage(named: "normalAvatar")
        }
    }
    
}

//Function to push values to database
func pushData(object j: grammar564){
    let newPerson: DukePerson = DukePerson()
    let newPGender: Gender = parseGender(str: j.gender)
    parseProfilePic(pic: j.picture, gender: newPGender)
    newPerson.setValues(gender: newPGender,
                        fName: j.firstname,
                        lName: j.lastname,
                        whereFrom: j.wherefrom,
                        hobbies: j.hobbies ?? [],
                        age: 0,
                        profession: DukeRole(rawValue: j.role) ?? .Other,
                        degree: j.degree,
                        languages: j.languages ?? [],
                        team: j.team ?? "",
                        email: j.email ?? "",
                        netID: j.netid,
                        department: j.department ?? "",
                        ID: j.id
)
    let photoToUse: UIImage? = convB64UIImage(img: j.picture)
    newPerson.pPhoto = photoToUse!
    PeopleList.append(newPerson)
}



@main
struct HW2App: App {
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
                for j in json{
                    pushData(object: j)
                }
                            
                
            }
        }
        theTask.resume()
    }
    
    //This function is the base function for Refresh from SErver button
    func refreshServer() {
        let url: String = "http://kitura-fall-2021.vm.duke.edu:5640/b64entries"
        retrieveData(from: url)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ZStack{
                AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), center: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                VStack {
                    NavigationLink(destination: ContentView()) {
                        Text("Search and Update Data ")
                            .font(.title)
                            .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1))
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/)
                    
                    Button("Refresh Data from server") {
                        refreshServer()
                    }.font(.title)
                        .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1))
                    }
                    
                }
            }
        }
    }

}
