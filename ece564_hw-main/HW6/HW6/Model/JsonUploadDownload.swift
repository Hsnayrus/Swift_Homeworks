//
//  JsonUploadDownload.swift
//  HW4
//
//  Created by Loaner on 2/9/22.
//

import Foundation
import SwiftUI

var newPerson: DukePerson = DukePerson()

//JSON Struct
struct grammar564: Codable{
    var firstname: String
    var lastname: String
    var wherefrom: String
    var gender: String
    var hobbies: [String]?
    var role: String
    var degree: String
    var languages: [String]?
    var picture: String?
    var team: String?
    var netid: String
    var email: String?
    var department: String?
    var id: String
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
    newPerson.setValuesFromJson(gender: newPGender, fName: j.firstname, lName: j.lastname, whereFrom: j.wherefrom, hobbies: j.hobbies ?? [], age: 0, profession: DukeRole(rawValue: j.role) ?? .Other, degree: j.degree, languages: j.languages ?? [], team: j.team ?? "Student", email: j.email ?? "", netID: j.netid, department: j.department ?? "", ID: j.id)
    let photoToUse: UIImage? = convB64UIImage(img: j.picture)
    newPerson.pPhoto = photoToUse!
    let personExists: DukePerson? = personInList(newPerson)
    if let personExists = personExists {
        personExists += newPerson
    }
    else{
        PeopleList.append(newPerson)
    }
}
