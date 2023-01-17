
// This playground is here just for you to practice different Swift operations.
// Once you have a function working the way you want, you can copy it in to HW1.playground to start testing with your User Interface.
// The contents of this playground is not graded, so you don't have to use and you can even delete it if you want.

//: This is the playground file to use for submitting HW1.  You will add your code where noted below.  Make sure you only put the code required at load time in the ``loadView()`` method.  Other code should be set up as additional methods (such as the code called when a button is pressed).
  
import UIKit
import PlaygroundSupport
import CoreGraphics
import CoreFoundation

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
    var prefis: Prefixes = .Mr
}

enum DukeRole : String {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
    case Other = "Other"
}

protocol ECE564 {
    var degree : String { get }
    var languages: [String] { get }
    var team : String { get }
}

class DukePerson: Person, ECE564, CustomStringConvertible{
    var degree: String{
        get{
            return self.degree
        }
    }

    var languages: [String]{
        get{
            return self.languages
        }
    }

    var team: String{
        get{
            return self.team
        }
    }

    var description: String{
        get{
            var pronouns: String = ""
            if(gender == .Male){
                pronouns = "he"
            }
            else if(gender == .Female){
                pronouns = "she"
                
            }
            else{
                pronouns = "they"
            }
                
            return "\(firstName) \(lastName) is from \(whereFrom) and \(pronouns) are a  "
        }
    }
}



class HW1ViewController : UIViewController {
    // You can add code here
    func newDescription(textToDisplay text: String?, newRect actualRect: CGRect)  -> UILabel {
        let description = UILabel()
        description.backgroundColor = .clear
    //  description.frame = CGRect(x: 0, y: 0 , width: 400 , height: 420)
        let textDisplay: String? = text
        description.frame = actualRect
        description.text = textDisplay
        description.textColor = .systemOrange
        description.font = UIFont(name:"Verdana", size: 15)
        description.numberOfLines = 0
        description.textAlignment = .center
        description.lineBreakMode = .byWordWrapping
        description.layer.cornerRadius = 10.0
        return description
    }

    func newGradient(colors newColors: [CGColor], newRect actualRect: CGRect) -> CAGradientLayer{
        let newLayer = CAGradientLayer()
        newLayer.frame = actualRect
        newLayer.colors = newColors
        return newLayer
    }
    
    func newSegment(titles newTitles: [String], rect newRect: CGRect) -> UISegmentedControl {
        let newSeg = UISegmentedControl()
        newSeg.backgroundColor = .white
        newSeg.frame = newRect
        newSeg.selectedSegmentTintColor = .systemPurple
        var counter: Int = 0
        var newAction: UIAction
        for i in newTitles{
            newAction = UIAction(title: "\(i)"){ _ in print("\(i)")}
            newSeg.insertSegment(action: newAction, at: counter, animated: true)
            counter = counter + 1
        }
        return newSeg
    }

    func button(title newTitle: String, rect newRect: CGRect, func newFunc: Selector) -> UIButton{
        let myButton = UIButton()
        myButton.frame = newRect
        myButton.backgroundColor = .white
        myButton.layer.cornerRadius = 15
        myButton.isHidden = false
        myButton.titleLabel?.numberOfLines = 0
        myButton.titleLabel?.textAlignment = .center
        myButton.titleLabel?.lineBreakMode = .byWordWrapping
        myButton.setTitle(newTitle, for: UIControl.State())
        myButton.titleLabel?.font = UIFont(name: "Verdana", size: CGFloat(12))
        myButton.setTitleColor(UIColor.black, for: UIControl.State())
        myButton.setTitleColor(UIColor.purple, for: .highlighted)
        myButton.addTarget(self, action: newFunc, for: .touchUpInside)
        return myButton
    }
    
    
    
    @objc func addUpdatePressed(){
        print("Add update works")
        
    }
    
    @objc func findPressed(){
        print("Find works too")
        
    }
    func addUpdateView() -> UIView{
        let newView = UIView()
        let rect: CGRect = CGRect(x: 0, y: 0, width: 375, height: 1000)
        newView.frame = rect
        let colorsGradient: [CGColor] = [
            UIColor.darkGray.cgColor,
            UIColor.white.cgColor
        ]
        let gradient: CAGradientLayer = newGradient(colors: colorsGradient, newRect: rect)
        newView.layer.addSublayer(gradient)
        
        //Label for testing
        
        let newLabel = UILabel()
        newLabel.textAlignment = .center
        newLabel.textColor = .systemGray4
        newLabel.text = "Add/Update Segment Works"
        newView.addSubview(newLabel)
        return newView
    }
    
    func newTextField(text newText: String, rect newRect: CGRect) -> UITextField {
        let testTextField = UITextField().self
        testTextField.borderStyle = .roundedRect
        testTextField.text = newText
        testTextField.frame = newRect
        testTextField.translatesAutoresizingMaskIntoConstraints = false
        return testTextField
    }
    

    override func loadView() {
        let view = UIView()
        let textDisplay: String? = " This is the test "
        let descRect = CGRect(x: 0, y: 400, width: 375, height: 250)
        let newDescriptionLabel = newDescription(textToDisplay: textDisplay, newRect: descRect)
        let backRect = CGRect(x: 0, y: 0, width: 375, height: 1000)
        let backgroundGradient: [CGColor] = [
            UIColor.black.cgColor,
            UIColor.darkGray.cgColor,
            UIColor.systemGray.cgColor
        ]
        let newLayer = newGradient(colors: backgroundGradient, newRect: backRect)
        //Description has a limit of 655 Characters.
//        let addUpdateRect = CGRect(x: 0, y: 0, width: 187, height: 50)
//        let addUpdateView: UIView = addUpdateView()
//        let addSegment = newSegments(text: "Add/Update", position: 0, rect: addUpdateRect, view: addUpdateView )
//        let findSegment = newSegments(text: "Find", position: 1, rect: findRect, view: addUpdateView)
//        //Max count of description is 655 characters
        
        
        
        // Gender segment
        let genderRect = CGRect(x: 7.5, y: 280, width: 360, height: 50)
        let genders: [String] = ["Female", "Male", "Non-binary"]
        let genderSegment = newSegment(titles: genders, rect: genderRect)
        
        //Duke Role Segment
        let dukeRoleRect: CGRect = CGRect(x: 7.5, y: 335, width: 360, height: 50)
        let dukeRoles: [String] = ["Student", "Professor", "TA", "Other"]
        let dukeRolesSegment = newSegment(titles: dukeRoles, rect: dukeRoleRect)
        
        //button
        let addUpdateRect:CGRect = CGRect(x: 50, y: 400, width:130, height: 50)
        let addUpdateTitle: String = "Add/Update"
        let addUpdateButton = button(title: addUpdateTitle, rect: addUpdateRect, func: #selector(self.addUpdatePressed))
        
        let findRect: CGRect = CGRect(x: 185, y: 400, width: 130, height: 50)
        let findButtonTitle: String = "Find"
        let findButton = button(title: findButtonTitle, rect: findRect, func: #selector(self.findPressed))
        
        let firstNameText = "Enter First Name Here"
        let lastNameText = "Enter Last Name here"
        let ageText = "Enter Age here"
        let hobbiesText = "Enter hobbies here"
        let placeOfOriginText = "Where are you from?"
        
        let firstNameRect = CGRect(x: 7.5, y: 20, width: 360, height: 40)
        let lastNameRect = CGRect(x: 7.5, y: 70, width: 360, height: 40)
        let ageRect = CGRect(x: 7.5, y: 120, width: 360, height: 40)
        let hobbiesRect = CGRect(x: 7.5, y: 170, width: 360, height: 40)
        let pOORect = CGRect(x: 7.5, y: 220, width: 360, height: 40)
        
        
        
        let firstTextField = newTextField(text: firstNameText, rect: firstNameRect)
        let lastTextField = newTextField(text: lastNameText, rect: lastNameRect)
        let ageTextField = newTextField(text: ageText, rect: ageRect)
        let hobbiesTextField = newTextField(text: hobbiesText, rect: hobbiesRect)
        let pOOTextField = newTextField(text: placeOfOriginText, rect: pOORect)
        
        view.layer.addSublayer(newLayer)
        view.addSubview(newDescriptionLabel)
        view.addSubview(genderSegment)
        view.addSubview(dukeRolesSegment)
        view.addSubview(addUpdateButton)
        view.addSubview(findButton)
        view.addSubview(firstTextField)
        view.addSubview(lastTextField)
        view.addSubview(ageTextField)
        view.addSubview(hobbiesTextField)
        view.addSubview(pOOTextField)
        self.view = view
        }
// You can add code here
    
    }
    
// You can add code here

//}







// Don't change the following line - it is what allows the view controller to show in the Live View window
PlaygroundPage.current.liveView = HW1ViewController()
