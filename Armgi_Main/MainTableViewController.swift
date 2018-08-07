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
    @IBOutlet weak var goalStateBar: UIView!
    @IBOutlet weak var goalStateBarBack: UIView!
    @IBOutlet weak var goalStateLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 셀 선택시 목표량 바 안사라짐.
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = goalStateBar.backgroundColor
        let background = goalStateBarBack.backgroundColor
        super.setSelected(selected, animated: animated)
        if selected {
            goalStateBar.backgroundColor = color
            goalStateBarBack.backgroundColor = background
        }
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = goalStateBar.backgroundColor
        let background = goalStateBarBack.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            goalStateBar.backgroundColor = color
            goalStateBarBack.backgroundColor = background
        }
    }

}

class MainTableViewController: UITableViewController {

    @IBOutlet weak var noDataView: UIView! //strong으로 하면 더 빨라지는 느낌?

    // 상단의 수정 bar button 으로 삭제하기.
    @IBAction func editList(_ sender: Any) {
        guard !dataCenter.studyList.isEmpty else{
            return
        }
        self.setEditing(true, animated: true)
    }

    var selectedColor:[Int] = [] // Add에서 선택한 색깔 담음.
    var delegate:WordTableViewController?

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedSubjectName.text = dataCenter.studyList[indexPath.section]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if dataCenter.studyList.count != 0
        {
            tableView.backgroundView = nil
        }
        else
        {
            tableView.backgroundView = noDataView
        }
        return dataCenter.studyList.count
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

        guard let studyCell = cell as? MainTableViewCell else{
            return cell
        }
        studyCell.ddayLabel.text = ddayReturn(indexPathSection: indexPath.section)
        studyCell.goalStateBar.backgroundColor = UIColor().colorFromHex(dataCenter.templateColor[dataCenter.selectedColor[indexPath.section]])

        let goalVal = dataCenter.goalData.currentGoalVal/dataCenter.goalData.goalList[indexPath.section]
        if goalVal <= 1.0{
            studyCell.goalStateBar.frame.size.width = CGFloat(goalVal*343)
            //아이폰 사이즈에 따라 343이 아닐 수도 있음.
            //let cellWidth = ((UIScreen.mainScreen().bounds.width) — 32–30 ) / 3

            studyCell.goalStateLabel.text = String(Int(goalVal*100)) + "%"
            if goalVal == 1.0{
                studyCell.starImage.image = UIImage(named: "goalStar")
            }else{
                studyCell.starImage.image = nil
            }
        }
        return studyCell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?{
        return dataCenter.studyList[section]
    }

    // 셀이 Swipe 액션시 나타나는 것.
    // 테이블 section 삭제 및 studyList, ddayList 배열에서 제거.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "삭제") { (action, indexPath) in
            let deleteAlert = UIAlertController(title:"정말?", message:"학습 목표를 삭제하시겠습니까?\r\n삭제시 복구가 불가능합니다.", preferredStyle: .alert)
            let deleteOk = UIAlertAction(title:"확인", style: .destructive) { (action : UIAlertAction) in
                //Cell에 존재하는 모든 데이터들을 같이 삭제해주어야 한다.
                dataCenter.studyList.remove(at: indexPath.section)
                dataCenter.ddayList.remove(at: indexPath.section)
                dataCenter.goalData.goalList.remove(at: indexPath.section)
                // Delete the row from the data source
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
                tableView.deleteSections(indexSet, with: .automatic)
            }
            let deleteCancel = UIAlertAction(title:"취소", style: .cancel, handler:nil)
            deleteAlert.addAction(deleteOk)
            deleteAlert.addAction(deleteCancel)
            self.present(deleteAlert, animated: true, completion: nil)
            // delete item at indexPath
        }

        let edit = UITableViewRowAction(style: .normal, title: "수정") { (action, indexPath) in

            // edit item at indexPath
        }

        edit.backgroundColor = UIColor.gray

        return [delete, edit]
    }
}
