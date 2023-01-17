//
//  PersonRow.swift
//  HW5
//
//  Created by Loaner on 2/13/22.
//

import SwiftUI

struct PersonRow: View {
    @State var flag: Bool = false
    @State var person: DukePerson
    var body: some View {
        VStack {
            HStack{
                CircleImageRow(image: person.pPhoto ?? maleAvatar!)
                VStack{
                    Button("\(person.lastName), \(person.firstName)"){
                        flag = true
                    }
                    VStack {
                        Text(person.description)
                    }
                }
            }
        }.sheet(isPresented: $flag){
            ContentView(person: person)
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(person: testPerson)
            .previewLayout(.fixed(width: 375, height: 100))
    }
}
//
//    testPerson.setValues(gender: .Male, fName: "Suryansh", lName: "Jain", whereFrom: "Mumbai, India", hobbies: ["Coding", "Gaming"], age: 22, profession: .Student, degree: "MS ECE", languages: ["C", "C++", "Java", "Swift"], team: "None", email: "suryanshjain.1309@gmail.com", netID: "sj346")
