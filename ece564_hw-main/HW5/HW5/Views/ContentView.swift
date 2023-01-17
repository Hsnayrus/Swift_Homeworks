//
//  ContentView.swift
//  HW2
//
//  Created by Loaner on 1/23/22.
//

import SwiftUI

var maleAvatar = UIImage(named: "MaleAvatar" )
var maleAvatarData = maleAvatar!.jpegData(compressionQuality: 1)
var maleAvatarB64String = maleAvatarData!.base64EncodedString()
var base64ImageStr: String?
var base64ImageData = Data(base64Encoded: base64ImageStr ?? maleAvatarB64String)
var finalImage = UIImage(data: base64ImageData ?? maleAvatarData!)

func addToDataBase(person newPerson: DukePerson){
    for p in PeopleList{
        if p.netID == newPerson.netID{
            p.firstName = newPerson.firstName
            p.lastName = newPerson.lastName
            p.languages = newPerson.languages
            p.hobbies = newPerson.hobbies
            p.pPhoto = newPerson.pPhoto
            p.gender = newPerson.gender
            p.team = newPerson.team
            p.department = newPerson.department
            p.id = newPerson.id
            p.profession = newPerson.profession
            p.email = newPerson.email
            p.age = newPerson.age
            p.prefix = newPerson.prefix
            p.whereFrom = newPerson.whereFrom
        }
    }
}

func convB64UIImage(img imgStr: String?) -> UIImage?{
    let b64Data = Data(base64Encoded: imgStr ?? maleAvatarB64String)
    let resImage = UIImage(data: b64Data ?? maleAvatarData!)
    return resImage
}

public extension UIImage {
    func copy(newSize: CGSize, retina: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            /* size: */ newSize,
            /* opaque: */ false,
            /* scale: */ retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

func imageButtonFunction(){
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
    @State var photoLibraryShown = false
    @State var currentImage: UIImage = UIImage(systemName: "MaleAvatar") ?? UIImage(data: Data(maleAvatarData!))!
    @State var flag = true
    @State var contentPerson: DukePerson = DukePerson()
    @Environment(\.editMode) private var editMode
    @State private var disableTextField = true

    
    init(){
        //      Retrieving data locally. Basically loadData() function
        let tempPeopleList: [grammar564]? = saveDukePerson.loadData()
        if let tempPeopleList = tempPeopleList {
             grammarPeople = tempPeopleList
        }
    }
    
    init(person newPerson: DukePerson){
        let tempPeopleList: [grammar564]? = saveDukePerson.loadData()
        if let tempPeopleList = tempPeopleList {
             grammarPeople = tempPeopleList
        }
        
        print("\(newPerson.netID)")
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
        currentImage = newPerson.pPhoto?.copy(newSize: CGSize(width: 144, height: 144), retina: true) ?? UIImage()
        hobbies  = newPerson.hobbies.joined(separator: ", ")
        flag = true
        contentPerson -= newPerson
    }
    
    //Finds person by Net ID
    func findByNetID() -> DukePerson? {
        for person in PeopleList{
            if(person.netID == netID && person.netID != ""){
               return person
            }
        }
        return nil
    }
    //Finds person by first name
    func findByFirstName() -> DukePerson?{
        for person in PeopleList{
            if(person.firstName == fName && person.firstName != ""){
                return person
            }
        }
        return nil
    }
    //Finds person by last name
    func findByLastName() -> DukePerson?{
        for person in PeopleList{
            if(person.lastName == lName && person.firstName != ""){
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
        currentImage = newPerson.pPhoto?.copy(newSize: CGSize(width: 144, height: 144), retina: true) ?? UIImage()
        hobbies  = newPerson.hobbies.joined(separator: ", ")
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
        else{
            return findNetIDFlag;
        }
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
    Else try adding the particular personr.
    """
        }
        else{
            updateParametersOnScreen(person: updateBy!)
        }
        if(grammarPeople.count == 0){
            for p in PeopleList{
                grammarPeople.append(convertToGrammar(p))
            }
        }
        saveDukePerson.savePeople(peopleToSave: grammarPeople)
        PeopleList = convertGrammarToDukePerson(grammarPeople) ?? []
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
        newPerson.pPhoto = currentImage
        if(netID == "sj346"){
            uploadData(person: newPerson)
        }
        else{
            var counter: Int = 0;
            for p in PeopleList{
                if(p.netID == newPerson.netID){
                    break
                }
                counter += 1
            }
            var anotherCounter: Int = 0
            for g in grammarPeople{
                if(g.netid == PeopleList[counter].netID){
                    break
                }
                anotherCounter += 1
            }
            grammarPeople.remove(at: anotherCounter)
            grammarPeople.append(convertToGrammar(PeopleList[counter]))
            saveDukePerson.savePeople(peopleToSave: grammarPeople)
            description = "Changing data locally"
        }
    }
    //This function checks for empty fields on the screen
    func checkForEmptyFields() -> Bool{
        if(fName == "" || lName == "" || degree == "" || hobbies == "" || languages == "" || email == "" || team == "" || location == "" || netID == "" ){
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
        photoGiven = nil
        currentImage = UIImage(data: Data(maleAvatarData!))!
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
                newPerson.setValues(gender: gender, fName: fName, lName: lName, whereFrom: location, hobbies: convToList(varToChange: hobbies), age: Int(age), profession: profession, degree: degree, languages: convToList(varToChange: languages), team: team, email: email, netID: netID)
                
//                uploadData(person: newPerson)
                }
        }
        else{
//            print("\(fName), \(lName), \(profession), \(age), \(netID), \(degree), \(team), \(email)")
            description = "Some empty fields found"
        }
    }
    
    var body: some View {

        
        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), center: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            ScrollView{
                VStack {
                    VStack{
                        Button(action: {
                            photoLibraryShown = true
                            imageButtonFunction()
                        }){
                            CircleImage(image: currentImage)
//                        Image(uiImage: currentImage)
//                                .resizable(capInsets: EdgeInsets())
//                                .aspectRatio(contentMode: .fit)
////                                .padding(.all)
//                                .clipShape(Circle())
//                                .overlay{
//                                    Circle().stroke(.yellow, lineWidth: 4)
//                                }
//                                .padding()
                        }
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
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
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
                                .cornerRadius(10.0).disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
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
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
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
                            .disabled(disableTextField)
                            .onChange(of: editMode?.wrappedValue) { newValue in
                                if (newValue != nil) && (newValue!.isEditing) {
                                    // Edit button tapped
                                    disableTextField = false
                                }
                                else {
                                    // Done button tapped
                                    disableTextField = true
                                }
                            }
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
                            .disabled(disableTextField)
                            .onChange(of: editMode?.wrappedValue) { newValue in
                                if (newValue != nil) && (newValue!.isEditing) {
                                    // Edit button tapped
                                    disableTextField = false
                                }
                                else {
                                    // Done button tapped
                                    disableTextField = true
                                }
                            }
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
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
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
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
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
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
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
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
                        }
                        
                    }
                    
                    VStack(alignment: .leading){
                    HStack{
                        Button("Add/Update") {
                            btnFnc()
                        }
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).overlay(RoundedRectangle(cornerRadius: 20)
                                                                                            .stroke(Color.white, lineWidth: 1))
                                               
                        
                        Spacer()
                        Button("Edit") {
                            disableTextField.toggle()
                        }
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1))
                        
                    }.padding()
                       
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
        .onAppear{
            print("ContentView/OnAppear()")
            updateParametersOnScreen(person: contentPerson)
        }
        .sheet(isPresented: $photoLibraryShown) {
                ImagePicker( selectedImage: $currentImage, sourceType: .photoLibrary)
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
