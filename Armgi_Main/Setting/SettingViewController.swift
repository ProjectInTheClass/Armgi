//
//  SettingViewController.swift
//  Settings
//
//  Created by CAUAD09 on 2018. 8. 8..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit
import UserNotifications


class SettingViewController: UITableViewController {
    
    //설정
    @IBOutlet weak var forgettingCurveMode: UITableViewCell!
    @IBOutlet weak var userSettingMode: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
//체크마크 변경
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//        if indexPath.row == 0 && indexPath.row == 2 {
//            cell.accessoryType = UITableViewCellAccessoryType.checkmark
//        }
//
//
//        forgettingCurveMode.accessoryType = .checkmark
//        userSettingMode.accessoryType = .checkmark
//
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)

//        if indexPath.row == 0 {
//            cell?.accessoryType = .checkmark
//            forgettingCurveMode.isSelected = false
//            forgettingCurveMode.accessoryType = .none
//
//            if cell?.accessoryType == .checkmark {
//                if cell?.isSelected == true {
//                    cell?.accessoryType = .none
//                }
//            }
//        } else if indexPath.row == 2 {
//            cell?.accessoryType = .checkmark
//            userSettingMode.isSelected = false
//            userSettingMode.accessoryType = .none
//
//            if cell?.accessoryType == .checkmark {
//                if cell?.isSelected == true {
//                    cell?.accessoryType = .none
//                }
//            }
//        }
        
        if userSettingMode.isSelected == true {
            userSettingMode.accessoryType = .checkmark
            forgettingCurveMode.isSelected = false
            forgettingCurveMode.accessoryType = .none
        } else if forgettingCurveMode.isSelected == true {
            forgettingCurveMode.accessoryType = .checkmark
            userSettingMode.isSelected = false
            userSettingMode.accessoryType = .none
        }
        
        //notification
        if indexPath.row == 2 {
            //알림값이 true인 과목들에게 아래코드 각각 씌우기
            
            for i in 0 ..< dataCenter.studyList.count {
                if dataCenter.alarmOnOff[i] == true {
                    for j in 0 ..< dataCenter.studyList[i].unitList.count {
                        
                    }
                }
            }
            
            func setNotification (time: Int, identifier: String) {
                let popUp = UNMutableNotificationContent()
                popUp.title = "과목"
                popUp.body = "키워드:뜻"
                
                let forgetTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
                let request = UNNotificationRequest(identifier: identifier, content: popUp, trigger: forgetTrigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
            
            setNotification(time: 60*60, identifier: "first")
            setNotification(time: 5*60*60, identifier: "second")
            setNotification(time: 24*60*60, identifier: "third")
            setNotification(time: 72*60*60, identifier: "fourth")
        }
        
    }

}
