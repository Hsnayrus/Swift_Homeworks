//
//  StoreLocal.swift
//  HW4
//
//  Created by Loaner on 2/9/22.
//

import Foundation

import SwiftUI

//Citation: ToDoList app demonstrated in class
class saveDukePerson: NSObject, Codable{
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Test22")
    
    static func savePeople(peopleToSave peopleSave: [grammar564]){
//        for person in peopleSave {
        var outputData = Data()
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(peopleSave) {
            if String(data: encoded, encoding: .utf8) != nil {
                outputData = encoded
            }
//            else { return false }
            
            do {
                try outputData.write(to: saveDukePerson.ArchiveURL)
            } catch let error as NSError {
                print (error)
//                return false
            }
//            return true
        }
//        else { return false }
        
//    }
    }
    static func loadData() -> [grammar564]? {
        let decoder = JSONDecoder()
        var grammarPerson: [grammar564] = []
        let tempData: Data
        
        do {
            tempData = try Data(contentsOf: saveDukePerson.ArchiveURL)
        } catch _ as NSError {
            return nil
        }
        if let decoded = try? decoder.decode([grammar564].self, from: tempData) {
//            print("SaveDukePerson.loadData()/If let")
//            //MARK - Testing Code
//            if (grammarPeople.count != 0){
//                print(grammarPeople[0].netid)
//                print(decoded[0].gender)
//            }
            grammarPerson = decoded
        }
        return grammarPerson
    }

}

func loadInitialData() -> [grammar564]?{
    let result: [grammar564]? = saveDukePerson.loadData()
    if let letResult = result {
        return letResult
    }
    return nil;
}


