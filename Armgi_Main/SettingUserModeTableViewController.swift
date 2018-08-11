//
//  SettingUserModeTableViewController.swift
//  Settings
//
//  Created by CAUAD09 on 2018. 8. 9..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit
import UserNotifications

class SettingUserModeTableViewController: UITableViewController {

    @IBOutlet weak var starMemory: UITableViewCell!
    @IBOutlet weak var starMemoryCheck: UIImageView!
    @IBOutlet weak var theIncorrect: UITableViewCell!
    @IBOutlet weak var theIncorrectCheck: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    let numberOfRowsAtSection: [Int] = [2, 1]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows: Int = 0
        
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if starMemory.isSelected == true {
            starMemoryCheck.image = UIImage.init(named: "checkmark")
            theIncorrect.isSelected = false
            theIncorrectCheck.image = UIImage.init(named: "checkmarkoff")
        } else if theIncorrect.isSelected == true {
            theIncorrectCheck.image = UIImage.init(named: "checkmark")
            starMemory.isSelected = false
            starMemoryCheck.image = UIImage.init(named: "checkmarkoff")
        }
        
        //notification
        if indexPath.row == 0 {
            let popUp = UNMutableNotificationContent()
            popUp.title = "별표친 아이의 과목"
            popUp.body = "별표친 아이 키워드 : 별표친 아이의 뜻"
            
            let starTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            // 위에는 타임인터벌이고 설정한 시간으로 바꿔야함
            //            let date = Date(timeIntervalSincNow: 2)
            //            var dateComponents = Calendar.current.dateComponents([.day, .hour, .minute])
            //            let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            //            let request = UNNotificationRequest(identifier: "dateCome", content: popUp, trigger: calendarTrigger)
            
            let request = UNNotificationRequest(identifier: "dateCome", content: popUp, trigger: starTrigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        } else if indexPath.row == 1 {
            let popUp = UNMutableNotificationContent()
            popUp.title = "오답의 과목"
            popUp.body = "오답인 문제"
            
            let incorrectTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            //            let date = Date(timeIntervalSincNow: 2)
            //            var dateComponents = Calendar.current.dateComponents([.day, .hour, .minute])
            //            let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            //            let request = UNNotificationRequest(identifier: "dateCome", content: popUp, trigger: calendarTrigger)
            let request = UNNotificationRequest(identifier: "dateCome", content: popUp, trigger: incorrectTrigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
