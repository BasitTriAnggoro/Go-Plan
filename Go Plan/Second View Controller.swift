//
//  SecondView Controller.swift
//  Go Plan
//
//  Created by Basit Tri Anggoro on 22/12/24.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var namePickerTF: UITextField!
    @IBOutlet weak var timePickerTF: UITextField!
    @IBOutlet weak var priorityPicker: UIPickerView!
    @IBOutlet weak var priorityBtn: UIButton!
    
    let timePicker = UIDatePicker()
    var dayName = ""
    var day:String = ""
    var time:String = ""
    var activityName:String = ""
    var activityTime:String = ""
    var activityPriority:String = ""
    var monday = [Dictionary<String, String>]()
    var tuesday = [Dictionary<String, String>]()
    var wednesday = [Dictionary<String, String>]()
    var thursday = [Dictionary<String, String>]()
    var friday = [Dictionary<String, String>]()
    var saturday = [Dictionary<String, String>]()
    var sunday = [Dictionary<String, String>]()
    var today = [Dictionary<String, String>]()
    var priorities = ["High", "Medium", "Low"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=false
        priorityPicker.isHidden = true
        priorityPicker.delegate = self
        priorityPicker.dataSource = self
        showtimePicker()
        priorityBtn.layer.cornerRadius = 8;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //define the new view (use class name)
        let destinationView = segue.destination as? ViewController
        destinationView?.monday = monday
        destinationView?.tuesday = tuesday
        destinationView?.wednesday = wednesday
        destinationView?.thursday = thursday
        destinationView?.friday = friday
        destinationView?.saturday = saturday
        destinationView?.sunday = sunday
        destinationView?.today = today
    }
    func showAlert(){
        let alert = UIAlertController(title: "Success", message: "\(activityName) added to your weekly activity on \(dayName) at  \(activityTime)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func addBtnPressed(_ sender: UIButton) {
        activityName = namePickerTF.text!
        activityTime = time
        activityPriority = priorityBtn.currentTitle!
        dayName = day
        
        if (dayName != "" && activityName != "" && activityPriority != "") {
            
            switch dayName {
            case "Monday":
                let newAct = ["name": activityName, "clock": activityTime, "priority": activityPriority]
                monday.append(newAct)
                print(monday)
            case "Tuesday":
                let newAct = ["name": activityName, "clock": activityTime, "priority": activityPriority]
                tuesday.append(newAct)
                print(tuesday)
            case "Wednesday":
                let newAct = ["name": activityName, "clock": activityTime, "priority": activityPriority]
                wednesday.append(newAct)
                print(wednesday)
            case "Thursday":
                let newAct = ["name": activityName, "clock": activityTime, "priority": activityPriority]
                thursday.append(newAct)
                print(thursday)
            case "Friday":
                let newAct = ["name": activityName, "clock": activityTime, "priority": activityPriority]
                friday.append(newAct)
                print(friday)
            case "Saturday":
                let newAct = ["name": activityName, "clock": activityTime, "priority": activityPriority]
                saturday.append(newAct)
                print(saturday)
            case "Sunday":
                let newAct = ["name": activityName, "clock": activityTime, "priority": activityPriority]
                sunday.append(newAct)
                print(sunday)
            default:
                print("Error")
            }
//            showAlert()
            namePickerTF.text = ""
            timePickerTF.text = ""
            priorityBtn.setTitle("Choose Priority", for: .normal)
        }
    }
    
    
    
    func showtimePicker(){
        //Formate Date
        timePicker.datePickerMode = .dateAndTime
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donetimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(canceltimePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        timePickerTF.inputAccessoryView = toolbar
        timePickerTF.inputView = timePicker
        
    }
    
    @objc func donetimePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        day = formatter.string(from: timePicker.date)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "h:mm a"
        time = formatter2.string(from: timePicker.date)
        timePickerTF.text = "\(day), \(time)"
        self.view.endEditing(true)
    }
    
    @objc func canceltimePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func priorityBtnPressed(_ sender: UIButton) {
        if priorityPicker.isHidden == true{
            priorityPicker.isHidden = false
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priorityBtn.setTitle(priorities[row], for: .normal)
        priorityPicker.isHidden = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //       return list.count
    //    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    //        cell.textLabel?.text = list[indexPath.row]
    //        return cell
    //    }
}
