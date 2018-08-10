//
//  SettingViewController.swift
//  Settings
//
//  Created by CAUAD09 on 2018. 8. 8..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit


class SettingViewController: UITableViewController {
    
    //설정
    @IBOutlet weak var forgettingCurveCheck: UIImageView!
    @IBOutlet weak var userCheck: UIImageView!
    @IBOutlet weak var forgettingCurveMode: UITableViewCell!
    @IBOutlet weak var userSettingMode: UITableViewCell!

    //사용자 입력 모드
    @IBOutlet weak var starMemory: UITableViewCell!
    @IBOutlet weak var starMemoryCheck: UIImageView!
    @IBOutlet weak var theIncorrect: UITableViewCell!
    @IBOutlet weak var theIncorrectCheck: UIImageView!
    
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userSettingMode.isSelected == true {
            userCheck.image = UIImage.init(named: "checkmark")
            forgettingCurveMode.isSelected = false
            forgettingCurveCheck.image = UIImage.init(named: "checkmarkoff")
        } else if forgettingCurveMode.isSelected == true {
            forgettingCurveCheck.image = UIImage.init(named: "checkmark")
            userSettingMode.isSelected = false
            userCheck.image = UIImage.init(named: "checkmarkoff")
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




//-------------------------------------------------------------



/*
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 let cell = tableView.cellForRow(at: indexPath)
 
 if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
 if cell?.isSelected == true {
 cell?.accessoryView?.tintColor = UIColor.blue
 } else {
 cell?.accessoryView?.tintColor = UIColor.darkGray
 }
 }
 }
 
 func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 userSettingMode.accessoryType = .checkmark
 forgettingCurveMode.accessoryType = .checkmark
 
 if userSettingMode.isSelected {
 userSettingMode.accessoryView?.tintColor = UIColor.blue
 forgettingCurveMode.accessoryView?.tintColor = UIColor.darkGray
 } else if forgettingCurveMode.isSelected {
 userSettingMode.accessoryView?.tintColor = UIColor.darkGray
 forgettingCurveMode.accessoryView?.tintColor = UIColor.blue
 }
 }
 
 override func viewWillAppear(animated: Bool) {
 if let index = self.tableView.indexPathForSelectedRow{
 self.tableView.deselectRowAtIndexPath(index, animated: true)
 }
 }
 */

/*
 func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
 println("You selected cell #\(indexPath.row)!")
 
 }
 */
/*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell:UITableViewCell = self.forgettingCurveMode
 if cell.isSelected == true {
 cell.accessoryView?.tintColor = UIColor.blue
 } else {
 cell.accessoryView?.tintColor = UIColor.darkGray
 }
 
 return cell
 }
 */
