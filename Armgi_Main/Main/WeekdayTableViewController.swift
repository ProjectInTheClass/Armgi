//
//  WeekdayTableViewController.swift
//  Armgi_Main
//
//  Created by CAUAD09 on 2018. 8. 14..
//  Copyright © 2018년 sspog. All rights reserved.
//

import UIKit

class WeekdayTableViewController: UITableViewController {
    
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        for weekday in dataCenter.repeatedWeekdays {
            if weekday == (indexPath.row + 1) {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if let index = dataCenter.repeatedWeekdays.index(of: (indexPath.row + 1)) {
            dataCenter.repeatedWeekdays.remove(at: index)
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: false)
            cell?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            dataCenter.repeatedWeekdays.append(indexPath.row + 1)
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: false)
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }

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

extension WeekdayTableViewController {
    static func repeatText(weekdays: [Int]) -> String {
        if dataCenter.repeatedWeekdays.count == 7 {
            return "매일"
        }
        
        if dataCenter.repeatedWeekdays.isEmpty {
            return "없음"
        }
        
        var ret = String()
        var weekdaysSorted:[Int] = [Int]()
        
        weekdaysSorted = dataCenter.repeatedWeekdays.sorted(by: <)
        
        for day in weekdaysSorted {
            switch day{
            case 1:
                ret += "일 "
            case 2:
                ret += "월 "
            case 3:
                ret += "화 "
            case 4:
                ret += "수 "
            case 5:
                ret += "목 "
            case 6:
                ret += "금 "
            case 7:
                ret += "토 "
            default:
                //throw
                break
            }
        }
        return ret
    }
}

