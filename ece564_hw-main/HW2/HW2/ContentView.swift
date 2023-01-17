//
//  ContentView.swift
//  HW2
//
//  Created by Loaner on 1/23/22.
//

import SwiftUI

var firstNames: [String] = []

var maleAvatar = UIImage(named: "MaleAvatar" )
var maleAvatarData = maleAvatar!.jpegData(compressionQuality: 1)
var maleAvatarB64String = maleAvatarData!.base64EncodedString()
var base64ImageStr: String?
var base64ImageData = Data(base64Encoded: base64ImageStr ?? maleAvatarB64String)
var finalImage = UIImage(data: base64ImageData ?? maleAvatarData!)

func addToDataBase(person newPerson: DukePerson){
    PeopleList.append(newPerson)
}

func convB64UIImage(img imgStr: String?) -> UIImage?{
    let b64Data = Data(base64Encoded: imgStr ?? maleAvatarB64String)
    let resImage = UIImage(data: b64Data ?? maleAvatarData!)
    return resImage
}

func populateDB(){
    let Suryansh: DukePerson = DukePerson()
    Suryansh.setValues(gender: .Male, fName: "Suryansh", lName: "Jain", whereFrom: "Mumbai, Maharashtra, India", hobbies: ["Gaming", "Partying"], age: 22, profession: .Student, degree: "MSECE", languages: ["C", "C++", "Java", "Python", "Verilog", "VHDL", "Swift"], team: "Duke", email: "suryansh.jain@duke.edu", netID: "sj346", department: "ECE", ID: "sj346")
    Suryansh.pPhoto = UIImage(named: "Suryansh Jain")!
    if (Suryansh.pPhoto == nil){
        print("sadly its nil")
    }
    PeopleList.append(Suryansh)
    
    let Richard: DukePerson = DukePerson()
    Richard.setValues(gender: .Male, fName: "Richard", lName: "Telford", whereFrom: "Chatham County, NC", hobbies: ["Hiking", "Swimming", "Biking"], age: 0, profession: .Professor, degree: "Not Applicable", languages: ["C", "C++", "Swift"], team: "None", email: "rt113@duke.edu", netID: "rt113", department: "ECE", ID: "rt113")
    Richard.pPhoto = UIImage(named: "ProfRic")!
    PeopleList.append(Richard)
}
   


struct ContentView: View {
    //Local variables of view
    @State var age: CGFloat = 0
    @State var photoGiven: UIImage? = nil
    @State var fName: String = ""
    @State var lName: String = ""
    @State var profession: DukeRole = .Student
    @State var degree: String = ""
    @State var hobbies: String = ""
    @State var languages: String = ""
    @State var email: String = ""
    @State var team: String = ""
    @State var gender: Gender = .Male
    @State var location: String = ""
    @State var description: String = "Description will be displayed here"
    @State var netID: String = ""
    @State var dept: String = ""
    @State var id: String = ""
    
    init(){
        populateDB()
    }
    
    //Finds person by Net ID
    func findByNetID() -> DukePerson? {
        for person in PeopleList{
            if(person.netID == netID){
               return person
            }
        }
        return nil
    }
    //Finds person by first name
    func findByFirstName() -> DukePerson?{
        for person in PeopleList{
            if(person.firstName == fName){
                return person
            }
        }
        return nil
    }
    //Finds person by last name
    func findByLastName() -> DukePerson?{
        for person in PeopleList{
            if(person.lastName == lName){
                return person
            }
        }
        return nil
    }
    //This function changes the values of text fields on screen if person found
    func updateParametersOnScreen(person newPerson: DukePerson) {
        fName = newPerson.firstName
        lName = newPerson.lastName
        location = newPerson.whereFrom
        gender = newPerson.gender
        age = CGFloat(newPerson.age)
        profession = newPerson.profession
        degree = newPerson.degree
        languages = newPerson.languages.joined(separator: ", ")
        email = newPerson.email
        team = newPerson.team
        description = newPerson.description
        netID = newPerson.netID
        photoGiven = newPerson.pPhoto
        hobbies  = newPerson.hobbies.joined(separator: ", ")
        dept = newPerson.department
        id = newPerson.id
    }
    //The main find function
    func find() -> DukePerson?{
        let findNetIDFlag: DukePerson? = findByNetID()
        let findFNameFlag: DukePerson? = findByFirstName()
        let findLNameFlag: DukePerson? = findByLastName()
        if(findNetIDFlag == nil){
            if(findFNameFlag == nil){
                if(findLNameFlag == nil){
                    return nil;
                }
                else{
                    return findLNameFlag
                }
            }
            else{
                return findFNameFlag
            }
        }
        return findNetIDFlag;
    }
     //This is a wrapper function for the find button
    func findWrapper(){
//        fName = $gender.wrappedValue.rawValue
//        lName = $profession.wrappedValue.rawValue
        let updateBy: DukePerson? = find()
        if(updateBy == nil){
            description = """
    Could not find person with provided credentials.
    Try changing Net ID, First Name or Last Name.
    Else try adding the particular person.
    """
        }
        else{
            updateParametersOnScreen(person: updateBy!)
        }
    }
    
    //This function converts String to String List
    func convToList(varToChange newVar: String) -> [String]{
        let anotherVar: String = newVar.filter{!$0.isWhitespace}
        let resStrList: [String] = anotherVar.components(separatedBy: ",")
        return resStrList
    }
    
    
    
    //This function updates the person's information if something is updated on the screen
    func updatePersonAttributes(person newPerson: DukePerson){
        newPerson.firstName = fName
        newPerson.lastName = lName
        newPerson.whereFrom = location
        newPerson.gender = gender
        newPerson.age = Int(age)
        newPerson.profession = profession
        newPerson.degree = degree
        newPerson.languages = convToList(varToChange: languages)
        newPerson.email = email
        newPerson.team = team
        newPerson.netID = netID
        newPerson.hobbies = convToList(varToChange: hobbies)
        if(newPerson.id == ""){
            newPerson.id = netID
        }
        else{
            newPerson.id = id
        }
        newPerson.department = dept
        if(netID == "sj346"){
//            uploadData(person: newPerson)
            description = "Data updated"
        }
        else{
            description = "Can't update other people's data"
        }
        PeopleList.append(newPerson)
        var counter: Int = 0
        for i in PeopleList{
            if(i.netID == "sj346"){
                break
            }
            counter += 1
        }
        uploadData(person: PeopleList[counter])
    }
    //This function checks for empty fields on the screen
    func checkForEmptyFields() -> Bool{
        if(fName == "" || lName == "" || degree == "" || hobbies == "" || languages == "" || email == "" || team == "" || location == "" || netID == "" || id == "" || dept == "" ){
            return true
        }
        return false;
    }
    //This function is the main function for the clear button
    func clearFnc(){
        fName = ""
        lName = ""
        age = 0
        gender = .Male
        profession = .Student
        location = ""
        degree = ""
        hobbies = ""
        languages = ""
        email = ""
        team = ""
        netID = ""
        dept = ""
        id = ""
        photoGiven = nil
        
    }
    
    //Main function for add/update button
    func btnFnc(){
        let emptyFields: Bool = checkForEmptyFields()
        if(emptyFields == false){
        let updateBy: DukePerson? = find()
            if(updateBy != nil){
                updatePersonAttributes(person: updateBy!)
               
            }
            else{
                description = "New Person Added"
                let newPerson: DukePerson = DukePerson()
                newPerson.setValues(gender: gender, fName: fName, lName: lName, whereFrom: location, hobbies: convToList(varToChange: hobbies), age: Int(age), profession: profession, degree: degree, languages: convToList(varToChange: languages), team: team, email: email, netID: netID, department: dept, ID: id)
                PeopleList.append(newPerson)
//                uploadData(person: newPerson)
                }
        }
        else{
            print("\(fName), \(lName), \(profession), \(age), \(dept), \(netID), \(degree), \(team), \(email)")
            description = "Some empty fields found"
        }
    }
    
    var body: some View {
        
        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), center: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            ScrollView{
                VStack {
                    VStack{
                        
                        Image(uiImage: photoGiven ?? finalImage!)
                            .resizable(capInsets: EdgeInsets())
                            .aspectRatio(contentMode: .fit)
                            .padding(.all)
                        
                    }
                    
                    Group {
                        HStack{
                            Text("First Name:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("John", text: $fName)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)
                        }
                        HStack{
                            Text("Last Name:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("Doe", text: $lName)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)
                        }
                        HStack{
                            Text("Place of Origin:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("City, State", text: $location)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)
                        }
                        
                    }
                    VStack{
                        HStack{
                        Text("Gender:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .opacity(1.0)
                            .cornerRadius(25.0)
                            Spacer()
                                .padding(.leading)
                        }
                        Picker(selection: $gender, label: Text("Gender")) {
                            Text("Male").font(.title).tag(Gender.Male)
                            Text("Female").font(.title).tag(Gender.Female)
                            Text("Non-Binary").font(.title).tag(Gender.NonBinary)
                        }
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .pickerStyle(SegmentedPickerStyle())
                        
                    }
                    
                    //Mark
                    HStack{
                        
                        Text("Age:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding([.top, .leading, .bottom])
                            .opacity(1.0)
                            .cornerRadius(25.0)
                        
                        Slider(value: $age, in: 0...108)
                            .padding(.all)
                        
                        
                    }
                    Text("Current age is: \(age, specifier: "%.0f")")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                        .multilineTextAlignment(.trailing)
                        .lineLimit(nil)
                        .padding([.top, .leading, .bottom])
                        .opacity(1.0)
                        .cornerRadius(25.0)
                    VStack{
                        HStack{
                            Text("Profession:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            Spacer()
                            Spacer()
                        }
                            
                            Picker(selection: $profession, label: Text("Profession")) {
                                Text("Student").font(.title).tag(DukeRole.Student)
                                Text("Professor").font(.title).tag(DukeRole.Professor)
                                Text("TA").font(.title).tag(DukeRole.TA)
                                Text("Other").font(.title).tag(DukeRole.Other)
                            }
                            .padding(.all)
                            .pickerStyle(SegmentedPickerStyle())
                        
                        HStack{
                            Text("Department:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("Department you work in", text: $dept)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)

                        }
                        
                    }
                    
                    HStack{
                        Text("Degree:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding([.top, .leading, .bottom])
                            .opacity(1.0)
                            .cornerRadius(25.0)
                        
                        
                        TextField("Highest completed degree", text: $degree)
                            .padding(.vertical)
                            .foregroundColor(.black)
                            .font(.title3)
                            .cornerRadius(10.0)
                    }
                    HStack{
                        Text("Hobbies:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding([.top, .leading, .bottom])
                            .opacity(1.0)
                            .cornerRadius(25.0)
                        
                        
                        TextField("Hobby1, Hobby2, ...", text: $hobbies)
                            .padding(.vertical)
                            .foregroundColor(.black)
                            .font(.title3)
                            .cornerRadius(10.0)
                    }
                    Group{
                        HStack{
                            Text("Languages:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("language1, language2, ...", text: $languages)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)
                        }
                        
                        HStack{
                            Text("Email:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("Email you will use for account", text: $email)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        }
                        
                        VStack{
                        HStack{
                            Text("Net ID:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("Duke Net ID", text: $netID)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        }
                            HStack{
                                Text("ID:")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .padding([.top, .leading, .bottom])
                                    .opacity(1.0)
                                    .cornerRadius(25.0)
                                
                                
                                TextField("Default is NetID", text: $id)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                    .font(.title3)
                                    .cornerRadius(10.0)

                            }
                            
                        }
                        HStack{
                            Text("Team:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding([.top, .leading, .bottom])
                                .opacity(1.0)
                                .cornerRadius(25.0)
                            
                            
                            TextField("Current Team", text: $team)
                                .padding(.vertical)
                                .foregroundColor(.black)
                                .font(.title3)
                                .cornerRadius(10.0)
                        }
                        
                    }
                    
                    VStack(alignment: .center){
                    HStack{
                        Button("Add/Update") {
                            btnFnc()
                        }
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).overlay(RoundedRectangle(cornerRadius: 20)
                                                                                            .stroke(Color.white, lineWidth: 1))
                                               
                        
                        Spacer()
                        Button("Find") {
                            findWrapper()
                        }
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1))
                        
                    }
                       
                VStack{
                    HStack{
                        Button("Clear Contents") {
                            clearFnc()
                        }
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).overlay(RoundedRectangle(cornerRadius: 20)
                                                                                            .stroke(Color.white, lineWidth: 1))
                        
                        
                        }
                        Text(description)
                            .font(.title2)
                            .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                            .multilineTextAlignment(.center)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            
                            
                    }
                    }
                    
                }
            }
        }
}
}
struct ContentView_Previews: PreviewProvider {
    var firstName: Binding<String>
//    @Binding var
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ContentView()
                .preferredColorScheme(.dark)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}
