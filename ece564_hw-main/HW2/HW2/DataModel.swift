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

class DukePerson: Person, ECE564, CustomStringConvertible{
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
    //This function sets the values of the current object
    //by the ones provided as parameters
    func setValues(gender newGender: Gender, fName newFirstName: String, lName newLastName: String, whereFrom location: String, hobbies newHobbies: [String], age newAge: Int, profession newRole: DukeRole, degree newDegree: String, languages newLanguages: [String], team newTeam: String, email newEmail: String, netID newNetID: String, department newDept: String, ID newID: String){
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
}



var PeopleList: [DukePerson] = []




