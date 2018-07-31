//
//  MainTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 7/26/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var ddayLabel: UILabel! //DdayLabel

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class MainTableViewController: UITableViewController {

/*
    // 상단의 수정 bar button 으로 삭제하기.
    @IBAction func editList(_ sender: Any) {
        guard !studyData.studyName.isEmpty else{
            return
        }
        self.setEditing(true, animated: true)
    }
*/

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

    func addNewItem(studyAdd:String, ddayAdd:Int){
        dataCenter.studyName.append(studyAdd)
        dataCenter.ddayList.append(ddayAdd)
        self.tableView.reloadData()
    }

    @IBAction func unwindToMain(seque:UIStoryboardSegue){
        print("Now_Main")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections

        return dataCenter.studyName.count
        
        /*
        guard let rowCount = studyData.studyName else{
            return 0
        }
        return rowCount.count
        */
        /*
        let returnRow:Int
        if let rowCount = studyData.studyName{
            returnRow = rowCount.count
        }
        return returnRow
        //DataCenter에서 studyName를 optional로 처리하면, Binding작업이 무한 반복됨.
        */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    //Dday 출력형식 정의
    func ddayReturn(indexPathSection:Int) -> String{
        switch dataCenter.ddayList[indexPathSection] {
        case 0:
            return "D - Day"
        case ..<0:
            return "Dday가 이미 지났습니다."
        default:
            return "D - " + String(dataCenter.ddayList[indexPathSection])
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studyCell", for: indexPath)

        // Configure the cell...

        guard let studyCell = cell as? MainTableViewCell else{
            return cell
        }

        studyCell.ddayLabel.text = ddayReturn(indexPathSection: indexPath.section)

        /*
        if let dday = ddayData.ddayList{
            studyCell.ddayLabel.text = String(dday[indexPath.section])
        }
        */
        return studyCell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?{

        return dataCenter.studyName[section]
        /*
        guard let header = studyData.studyName else{
            return "오류"
        }
        return header[section]
         */
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    // 테이블 section 삭제 및 studyName, ddayList 배열에서 제거.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        // Delete the row from the data source

        dataCenter.studyName.remove(at: indexPath.section)
        dataCenter.ddayList.remove(at: indexPath.section)
        //Cell에 존재하는 모든 데이터들을 같이 삭제해주어야 한다.

        let indexSet = IndexSet(arrayLiteral: indexPath.section)
        tableView.deleteSections(indexSet, with: .automatic)


        /*else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }*/
    }

    //delete를 한글로 바꾸기.
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }


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
