//
//  ViewController.swift
//  Go Plan
//
//  Created by Basit Tri Anggoro on 22/12/24.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var mediumLbl: UILabel!
    @IBOutlet weak var lowLbl: UILabel!
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var backgroundRounded2: UIView!
    @IBOutlet weak var backgroundRounded: UIView!
    @IBOutlet weak var activityTimeLabel: UILabel!
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var quotesLabel: UILabel!
    @IBOutlet weak var addNew: UIView!
    var quotesRandom=""
    var i=0    //format tanggalan hari ini
    let quotes = ["Dream Big. Pray Bigger","Do it with passion or not at all","Focus on the good","Every day is a second chance","You're amazing. Remember that!","Dream Big. Pray Bigger","Think like a proton, always positive","Take it easy", "Think like a proton, always positive","Don't Give Up!"]
    
    var monday = [[String:String]]() //shortcut dari dictionary
    var tuesday = [Dictionary<String, String>]()
    var wednesday = [Dictionary<String, String>]()
    var thursday = [Dictionary<String, String>]()
    var friday = [Dictionary<String, String>]()
    var saturday = [Dictionary<String, String>]()
    var sunday = [Dictionary<String, String>]()
    var today = [Dictionary<String, String>]()
    
//    - Apply Dictionary, for loop, segue,
    
    //FUNGSI UTAMA
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
        activity()  //Give index to function
        updateTime()    //Updating time every second, countArray(), getIndex()
        identifyDay()   //identifying day, getIndex()
        backgroundStyle()   //Give style to view (rounded corner)
        updater()           //Update many things by using time interval (indicator,time,quotes)
        print(monday)
        var high=0
        var medium=0
        var low=0
        
        for i in 0..<today.count{
            if today[i]["priority"] == "High" {
                high+=1
            }else if today[i]["priority"] == "Medium"{
                medium+=1
            }else if today[i]["priority"] == "Low"{
                low+=1
            }
        }
        navigationController?.navigationBar.isHidden = true
        
        highLbl.text = "High \(high)"
        mediumLbl.text = "Medium \(medium)"
        lowLbl.text = "Low \(low)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //define the new view (use class name)
        let destinationView = segue.destination as? SecondViewController
        destinationView?.monday = monday
        destinationView?.tuesday = tuesday
        destinationView?.wednesday = wednesday
        destinationView?.thursday = thursday
        destinationView?.friday = friday
        destinationView?.saturday = saturday
        destinationView?.sunday = sunday
        destinationView?.today = today
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let formatterClock = DateFormatter()
        formatterClock.dateFormat = "h:mm a" // jam:menit, "a" prints "pm" or "am"
        let oClock = formatterClock.string(from: Date())
        
        let oneActivity = today[i] as Dictionary
        let clock = oneActivity["clock"]
        let scheduleTime = "\(clock!)"  //ngubah function ke string
        let currentTime = oClock
        //cek kondisi kalo waktu aktivitas dan waktu sekarang berjalan sama maka akan muncul alert
        if (scheduleTime.elementsEqual(currentTime)) {
            showAlert()
        }
        
        //light mode
        UIApplication.shared.windows.forEach{
            window in window.overrideUserInterfaceStyle = .light
        }
    }
    
   @IBAction func unwindFirstButtonTapped(_ sender: UIStoryboardSegue) {
    print("abc")
    let test = sender.source as? SecondViewController
    thursday = test!.thursday
   }
    
    func updater(){
        // Realtime Tick/ update jam dg interval waktu 1 detik
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        //Update quotes text in label by 6 seconds
         
        
        Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(changeQoutes), userInfo: nil, repeats: true)
    }
    func showAlert(){
        let alert = UIAlertController(title: activityNameLabel.text, message: "Go for it! it's \(activityTimeLabel.text!)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func changeQoutes(){
        quotesRandom = quotes.randomElement()!
        quotesLabel.text = "\""+quotesRandom+"\""
    }
    
    func backgroundStyle(){
        backgroundRounded.layer.cornerRadius = 10;
        backgroundRounded2.layer.cornerRadius = 10;
        addNew.layer.cornerRadius = 50;
    }
    
    @objc func identifyDay(){
        enum Day:String{
           case Monday
           case Tuesday
           case Wednesday
           case Thursday
           case Friday
           case Saturday
           case Sunday
        }
        
        let dayName = dayLabel.text
        switch dayName! {
        case Day.Monday.rawValue:
            today = monday
        case Day.Tuesday.rawValue:
            today = tuesday
        case Day.Wednesday.rawValue:
            today = wednesday
        case Day.Thursday.rawValue:
            today = thursday
        case Day.Friday.rawValue:
            today = friday
        case Day.Saturday.rawValue:
            today = saturday
        case Day.Sunday.rawValue:
            today = sunday
        default:
            print("Error")
        }
        
        switch i {
        case 0:
            getIndex(index: i, activitiesArray: today)
        case 1:
            getIndex(index: i, activitiesArray: today)
        case 2:
            getIndex(index: i, activitiesArray: today)
        case 3:
            getIndex(index: i, activitiesArray: today)
        case 4:
            getIndex(index: i, activitiesArray: today)
        case 5:
            getIndex(index: i, activitiesArray: today)
        case 6:
            getIndex(index: i, activitiesArray: today)
        default:
            print("Error: Day is unknown")
        }
    }
    @IBAction func previous(_ sender: UIButton) {
        identifyDay()
        i-=1
        if(i<0){
            i=today.count-1    //harus dikurangin satu karena arraynya dimulai dari 0
            getIndex(index: i, activitiesArray: today)
        }else if(i<today.count){
            getIndex(index: i, activitiesArray: today)
        }else{
            print("Error")
        }
    }
    @IBAction func next(_ sender: UIButton) {
        identifyDay()
        i+=1
        if(i<today.count){
            getIndex(index: i, activitiesArray: today)
        }else if(i>=today.count){
            i=0
            getIndex(index: i, activitiesArray: today)
        }else{
            print("Error")
        }
    }
    @objc func getIndex(index:Int, activitiesArray:[Dictionary<String, Any>]){
        let oneActivity = activitiesArray[index] as Dictionary
        let name=oneActivity["name"]
        let clock=oneActivity["clock"]
        let priority=oneActivity["priority"]
        
        activityNameLabel.text = "\(name!)"
        activityTimeLabel.text = "\(clock!)"
        priorityLabel.text = "\(priority!)"
    }
    @objc func countArray(){
        //Give index to function
        if(i<today.count){
            getIndex(index: i, activitiesArray: today)
        }else{
            print("Array is not enough")
        }
    }
    @objc func updateTime(){
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "EEEE"       //format hari
        let today = formatterDay.string(from: Date())
           dayLabel.text=today
        
        let formatterAll = DateFormatter()
        formatterAll.dateFormat = "E, d MMM yyyy" //mengatur format tanggal menjadi "Hari, tgl Bln Tahun"
        
        let formatterClock = DateFormatter()
        formatterClock.dateFormat = "h:mm a"    // jam:menit, "a" prints "pm" or "am"
    }
    @objc func activity(){
        monday = [
            [
                "name": "Jogging",
                "clock": "06:00 AM",
                "priority": "Medium"
            ],
            [
                "name": "Buy Pet Food",
                "clock": "11:00 PM",
                "priority": "Medium"
            ],
            [
                "name": "Teach English (LIA)",
                "clock": "12:40 PM",
                "priority": "High"
            ],

        ]
        tuesday = [
            [
                "name": "Jogging",
                "clock": "5:45 AM",
                "priority": "Low"
            ],
            [
                "name": "Call your mom",
                "clock": "10:00 AM",
                "priority": "Medium"
            ],        ]
        wednesday = [
            [
                "name": "Learn Business",
                "clock": "6:00 AM",
                "priority": "High"
            ],
            [
                "name": "Meeting with client",
                "clock": "9:30 AM",
                "priority": "High"
            ],
            [
                "name": "Read a book",
                "clock": "6:35 PM",
                "priority": "Medium"
            ]
        ]
        thursday = [
            [
                "name": "Visit Abdul's House",
                "clock": "10:00 AM",
                "priority": "Medium"
            ],
            [
                "name": "Read a book",
                "clock": "6:35 PM",
                "priority": "Medium"
            ],
        ]
        friday = [
            [
                "name": "Jogging",
                "clock": "6:00 AM",
                "priority": "Medium"
            ],
            [
                "name": "Weekly Meeting",
                "clock": "6:30 PM",
                "priority": "High"
            ],
        ]
        saturday = [
            [
                "name": "Futsal",
                "clock": "8.00 AM",
                "priority": "Medium"
            ],
            [
                "name": "Part Time Job",
                "clock": "11.00 AM",
                "priority": "High"
            ],
            [
                "name": "Family Gathering",
                "clock": "7:10 PM",
                "priority": "Medium"
            ],
        ]
        sunday = [
            [
                "name": "Swimming",
                "clock": "6:45 AM",
                "priority": "Medium"
            ],
            [
                "name": "Read a book",
                "clock": "7:00 PM",
                "priority": "Medium"
            ],
        ]
    }
}


