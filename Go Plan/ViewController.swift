//
//  ViewController.swift
//  Go Plan
//
//  Created by Basit Tri Anggoro on 22/12/24.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var activityLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    
    var monday = [[String:String]]()
    var tuesday = [[String:String]]()
    var wednesday = [[String:String]]()
    var thursday = [[String:String]]()
    var friday = [[String:String]]()
    var saturday = [[String:String]]()
    var sunday = [[String:String]]()
    
    var today = [[String:String]]()
    var i = 0
    
    var p = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activities()
        updater()
        showActivities()
        activityLbl.text=today[0]["name"]
        timeLbl.text=today[0]["clock"]
    }
    
    func updater(){
        // Realtime Tick/ update jam dg interval waktu 1 detik
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime(){
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "EEEE"       //format hari
        let today = formatterDay.string(from: Date())
        dayLbl.text=today
    }
    
    
    
    @IBAction func previous(_ sender: UIButton) {
        showActivities()
        i-=1
    }
    
    @IBAction func next(_ sender: UIButton) {
        i+=1
        if i<today.count {
            let actName = today[i]["name"]!
            let actTime = today[i]["clock"]!
            activityLbl.text = actName
            timeLbl.text = actTime
            print(i)
            print(actName)
        }else{
            i = -1
        }
    }
    
    func showActivities(){
        updateTime()
        let currentDay = dayLbl.text!
        switch currentDay {
        case "Monday":
            today=monday
        case "Tuesday":
            today=tuesday
        case "Wednesday":
            today=wednesday
        case "Thursday":
            today=thursday
        case "Friday":
            today=friday
        case "Saturday":
            today=saturday
        case "Sunday":
            today=sunday
        default:
            print("Dictionary is not defined")
        }
    }
    
    func activities(){
        monday = [
            [
                "name": "Jogging",
                "clock": "06:00 AM"
            ],
            [
                "name": "Pay bill",
                "clock": "11:00 PM"
            ],
            [
                "name": "Meeting with Client",
                "clock": "12:40 PM"
            ],
            
        ]
        tuesday = [
            [
                "name": "Jogging",
                "clock": "5:45 AM"
            ],
            [
                "name": "Send packet to Lina",
                "clock": "10:20 AM"
            ],
        ]
        wednesday = [
            [
                "name": "Learn Business",
                "clock": "6:00 AM"
            ],
            [
                "name": "Meeting with client",
                "clock": "9:30 AM"
            ],
        ]
        thursday = [
            [
                "name": "Visit Abdul's House",
                "clock": "10:00 AM"
            ],
            [
                "name": "Read a book",
                "clock": "6:35 PM"
            ],
        ]
        friday = [
            [
                "name": "Buy Decorating Tools",
                "clock": "1:00 PM"
            ],
            [
                "name": "Meeting",
                "clock": "6:30 PM"
            ],
        ]
        saturday = [
            [
                "name": "Decorating New Room",
                "clock": "8.00 AM"
            ],
            [
                "name": "Family Gathering",
                "clock": "7:10 PM"
            ],
        ]
        sunday = [
            [
                "name": "Swimming in Palem Semi",
                "clock": "6:45 AM"
            ],
            [
                "name": "Service Car",
                "clock": "11:38 PM"
            ],
        ]
    }
    
}


