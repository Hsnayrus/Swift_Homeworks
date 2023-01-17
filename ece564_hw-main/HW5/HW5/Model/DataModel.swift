//
//  DataModel.swift
//  HW2
//
//  Created by Loaner on 2/1/22.
//

import SwiftUI

//
//  DataModel.swift
//  HW2
//
//  Created by Loaner on 2/1/22.
//

import Foundation

enum Gender : String {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-binary"
}

enum Prefixes: String{
    case Mr = "Mr."
    case Mrs = "Mrs."
    case Ms = "Ms."
    case Other = "Other"
    
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
    var hobbies = ["none"]
    var age = 22
    var prefix: Prefixes = .Mr
    var profession: DukeRole = .Student
    var email: String = ""
    var pPhoto: UIImage?
    var netID: String = ""
    var department: String = ""
    var id: String = ""
}

enum DukeRole : String {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
    case Other = "Other"
}

protocol ECE564 {
    var degree : String { get set }
    var languages: [String] { get set }
    var team : String { get set }
}

class DukePerson: Person, ECE564, Codable, CustomStringConvertible{
    var degree: String = ""

    var languages: [String] = [""]
    
    var team: String = ""
    
    var description: String{
        get{
            var pronouns: String = ""
            var areIs: String = ""
            
            if(gender == .Male){
                pronouns = "He"
                areIs = "is"
            }
            else if(gender == .Female){
                pronouns = "She"
                areIs = "is"
                
            }
            else{
                pronouns = "They"
                areIs = "are"
            }
            var roleDuke: String = "\(pronouns) \(areIs) currently a \(profession) at Duke."
            if(profession == .Other){
                roleDuke = ""
            }
            return "\(firstName) \(lastName) \(areIs) from \(whereFrom). " + roleDuke
        }
    }
    //This is basically an assignment operator and sets the values of the current person according to the new person.
    //Updates all values except the netID
    static func +=(currentPerson: DukePerson, newPerson: DukePerson){
        currentPerson.firstName = newPerson.firstName
        currentPerson.lastName = newPerson.lastName
        currentPerson.gender = newPerson.gender
        currentPerson.whereFrom = newPerson.whereFrom
        currentPerson.hobbies = newPerson.hobbies
        currentPerson.age = newPerson.age
        currentPerson.profession = newPerson.profession
        currentPerson.degree = newPerson.degree
        currentPerson.languages = newPerson.languages
        currentPerson.team = newPerson.team
        currentPerson.email = newPerson.email
        currentPerson.department = newPerson.department
        currentPerson.id = newPerson.id
    }
    static func -=(currentPerson: DukePerson, newPerson: DukePerson){
        currentPerson.firstName = newPerson.firstName
        currentPerson.lastName = newPerson.lastName
        currentPerson.gender = newPerson.gender
        currentPerson.whereFrom = newPerson.whereFrom
        currentPerson.hobbies = newPerson.hobbies
        currentPerson.age = newPerson.age
        currentPerson.profession = newPerson.profession
        currentPerson.degree = newPerson.degree
        currentPerson.languages = newPerson.languages
        currentPerson.team = newPerson.team
        currentPerson.email = newPerson.email
        currentPerson.department = newPerson.department
        currentPerson.netID = newPerson.netID
        currentPerson.id = newPerson.id
        currentPerson.pPhoto = newPerson.pPhoto
    }
    //This function sets the values of the current object
    //by the ones provided as parameters
    func setValuesFromJson(gender newGender: Gender, fName newFirstName: String, lName newLastName: String, whereFrom location: String, hobbies newHobbies: [String], age newAge: Int, profession newRole: DukeRole, degree newDegree: String, languages newLanguages: [String], team newTeam: String, email newEmail: String, netID newNetID: String, department newDept: String, ID newID: String){
        self.gender     = newGender
        self.firstName  = newFirstName
        self.lastName   = newLastName
        self.whereFrom  = location
        self.hobbies    = newHobbies
        self.age        = newAge
        self.profession = newRole
        self.degree     = newDegree
        self.languages  = newLanguages
        self.team       = newTeam
        self.email      = newEmail
        self.netID      = newNetID
        self.department = newDept
        self.id         = newID
    }
    func setValues(gender newGender: Gender, fName newFirstName: String, lName newLastName: String, whereFrom location: String, hobbies newHobbies: [String], age newAge: Int, profession newRole: DukeRole, degree newDegree: String, languages newLanguages: [String], team newTeam: String, email newEmail: String, netID newNetID: String){
        self.gender     = newGender
        self.firstName  = newFirstName
        self.lastName   = newLastName
        self.whereFrom  = location
        self.hobbies    = newHobbies
        self.age        = newAge
        self.profession = newRole
        self.degree     = newDegree
        self.languages  = newLanguages
        self.team       = newTeam
        self.email      = newEmail
        self.netID      = newNetID
    }
}

func convertToBase64(_ image: UIImage?) -> String{
    let photoData = image?.jpegData(compressionQuality: 1)
    let photoEncoded = photoData?.base64EncodedString()
    return photoEncoded ?? ""
}

func convertToGrammar(_ person: DukePerson) -> grammar564{
    return grammar564(firstname: person.firstName, lastname: person.lastName, wherefrom: person.whereFrom, gender: person.gender.rawValue, hobbies: person.hobbies, role: person.profession.rawValue, degree: person.degree, languages: person.languages, picture: convertToBase64(person.pPhoto), team: person.team, netid: person.netID, email: person.email, department: person.degree, id: person.degree)
}

func convPeopleList() -> [grammar564]{
    var actualList: [grammar564] = []
    for person in PeopleList{
        actualList.append(convertToGrammar(person))
    }
 return actualList
}

//Save function for Nav Bar
func navBarSaveFunction(){
    grammarPeople = []
    grammarPeople = convPeopleList()
    saveDukePerson.savePeople(peopleToSave: grammarPeople)
    
}
//Navigation Bar function to Reload From Server
func navBarReloadFromServer(){
    let urlToUse: String = "http://kitura-fall-2021.vm.duke.edu:5640/b64entries"
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
    theTask.resume()
    //MARK- Saving people after loading data from server
    navBarSaveFunction()
}


func convertGrammarToDukePerson(_ grammarPerson: [grammar564]) -> [DukePerson]?{
    if(grammarPerson.count == 0){
        return nil
    }
    
    for gPerson in grammarPerson{
        let currentPerson: DukePerson = DukePerson()
        currentPerson.setValuesFromJson(gender: Gender(rawValue: gPerson.gender) ?? .NonBinary, fName: gPerson.firstname, lName: gPerson.lastname, whereFrom: gPerson.wherefrom, hobbies: gPerson.hobbies ?? [], age: 0, profession: DukeRole(rawValue: gPerson.role) ?? .Other, degree: gPerson.degree, languages: gPerson.languages ?? [], team: gPerson.team ?? "Student", email: gPerson.email ?? "", netID: gPerson.netid, department: gPerson.department ?? "", ID: gPerson.id)
        let tempImage: UIImage = pictureBasedOnGender(currentPerson)
        let tempImageData: Data = tempImage.jpegData(compressionQuality: 1)!
        let tempImageString = tempImageData.base64EncodedString()
        currentPerson.pPhoto = UIImage(data: Data(base64Encoded: gPerson.picture ?? tempImageString) ?? tempImageData)
        let personExists: DukePerson? = personInList(currentPerson)
        if let personExists = personExists {
            personExists += currentPerson
        }
        else{
            PeopleList.append(currentPerson)
        }
    }
    return PeopleList
}

func pictureBasedOnGender(_ newPerson: DukePerson) -> UIImage{
    if(newPerson.gender == .Male){
       return UIImage(named: "MaleAvatar")!
    }
    else if(newPerson.gender == .Female){
        return UIImage(named: "FemaleAvatar")!
    }
    else{
        return UIImage(named: "normalAvatar")!
    }
}

//This function checks if the current person is already in our database
func personInList(_ person: DukePerson) -> DukePerson?{
    for p in PeopleList{
        if(p.netID == person.netID){
            return p
        }
    }
    return nil
}

//This function returns the DukePerson Array of professors
func getProfessorList() -> [DukePerson]{
    var result: [DukePerson] = []
    for p in PeopleList{
        if p.profession == .Professor{
            result.append(p)
        }
    }
    return result
}

//This function returns the DukePerson array of TAs
func getTAList() -> [DukePerson]{
    var result: [DukePerson] = []
    for p in PeopleList{
        if(p.profession == .TA){
            result.append(p)
        }
    }
    return result
}


//This function returns the DukePerson array of Students
func getStudentsList() -> [DukePerson]{
    var result: [DukePerson] = []
    for p in PeopleList{
        if(p.profession == .Student){
            result.append(p)
        }
    }
    return result
}



//This function returns the DukePerson array of people with other professions
func getOthersList() -> [DukePerson]{
    var result: [DukePerson] = []
    for p in PeopleList{
        if(p.profession == .Other){
            result.append(p)
        }
    }
    return result
}

func getTeams(_ people: [DukePerson]) -> Set<String>{
    var result: Set<String> = Set<String>()
    for p in people{
        let temp: String = p.team.trimmingCharacters(in: .whitespacesAndNewlines)
        if(temp == "NA" || temp == "N/A" || temp == "Not Specified" || temp == "TBD" || temp == "Not Applicable, or NA" || temp == "Not Applicable" || temp == "None" || temp == "none"){
            p.team = "Student"
        }
        result.insert(p.team)
    }
    return result
}

func getTeamsArray(_ teamSet: Set<String>) -> [String]{
    var result: [String] = []
    teamSet.forEach(){team in
        result.append(team)
        print(team)
    }
    return result
}

func getTeamMembers(_ team: String) -> [DukePerson]{
    var result: [DukePerson] = []
    for p in PeopleList{
        if(p.team == team){
            result.append(p)
        }
    }
    return result
}

func getTeamsDict(_ teamSet: Set<String>) -> [String:[DukePerson]]{
    var result: Dictionary<String, [DukePerson]> = [:]
    for team in teamSet{
        let temp: [DukePerson] = getTeamMembers(team)
        result.updateValue(temp, forKey: team)
    }
    return result
}

func convertToString(_ what: [String]) -> String{
    var result: String = ""
    for p in what{
        result.append(p)
    }
    return result
}


var PeopleList: [DukePerson] = []

var grammarPeople: [grammar564] = []

var testPerson: DukePerson = DukePerson()
