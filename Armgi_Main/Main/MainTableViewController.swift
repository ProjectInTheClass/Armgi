//
//  MainTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 7/26/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit
import UserNotifications

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
    var selectedSubject:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //알림허용
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound], completionHandler: { didAllow,Error in print(didAllow) })
    }

    override func viewWillAppear(_ animated: Bool) {
        print(dataCenter.studyList)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // 화면에 noData를 띄울지 결정.
    override func numberOfSections(in tableView: UITableView) -> Int {
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

    // 셀 만들기.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studyCell", for: indexPath)

        guard let studyCell = cell as? MainTableViewCell else{
            return cell
        }

        studyCell.ddayLabel.text = ddayReturn(indexPathSection: indexPath.section)
        studyCell.goalStateBar.backgroundColor = UIColor().colorFromHex(dataCenter.templateColor[dataCenter.selectedColor[indexPath.section]])

        let goalVal = dataCenter.goalData.currentGoalVal[indexPath.section]/dataCenter.goalData.goalList[indexPath.section]
        if goalVal <= 1.0{
            studyCell.goalStateBar.frame.size.width = CGFloat(goalVal*343)
            studyCell.goalStateLabel.text = String(Int(goalVal*100)) + "%"
            if goalVal == 1.0{
                studyCell.starImage.image = UIImage(named: "goalStar")
            }else{
                studyCell.starImage.image = nil
            }
        }
        return studyCell
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?{
//        return dataCenter.studyList[section]?.subjectName
//    }

    //테이블뷰 헤더. 색은 bgcolor 바꾸면 됨!!
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor().colorFromHex("#7285A5")

        let label = UILabel()
        label.text = dataCenter.studyList[section].subjectName
        label.textColor = UIColor.white
        label.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40)
        label.textAlignment = .center

        view.addSubview(label)
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }


//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = UIColor.clear
//        return view
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }

//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let header = view as? UITableViewHeaderFooterView {
//            header.backgroundView?.backgroundColor = UIColor.lightGray
//            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
//            header.textLabel?.textAlignment = .center
//            header.textLabel?.textColor = UIColor.white
//            // header.heightAnchor
//        }
//    }

    // 셀이 Swipe 액션시 나타나는 것.
    // 테이블 section 삭제 및 studyList, ddayList 배열에서 제거.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "삭제") { (action, indexPath) in
            let deleteAlert = UIAlertController(title:"정말?", message:"학습 목표를 삭제하시겠습니까?\r\n삭제시 복구가 불가능합니다.", preferredStyle: .alert)
            let deleteOk = UIAlertAction(title:"확인", style: .destructive) { (action : UIAlertAction) in

                //Cell에 존재하는 모든 데이터들을 같이 삭제해주어야 한다.
                dataCenter.studyList.remove(at: indexPath.section) // 신의 한 수
                dataCenter.ddayList.remove(at: indexPath.section)
                dataCenter.goalData.goalList.remove(at: indexPath.section)
                dataCenter.selectedColor.remove(at:indexPath.section)
                dataCenter.goalData.currentGoalVal.remove(at: indexPath.section)

                // Delete the row from the data source
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
                tableView.deleteSections(indexSet, with: .automatic)
            }

            let deleteCancel = UIAlertAction(title:"취소", style: .cancel, handler:nil)
            deleteAlert.addAction(deleteOk)
            deleteAlert.addAction(deleteCancel)

            self.present(deleteAlert, animated: true, completion: nil)
        }

        let edit = UITableViewRowAction(style: .normal, title: "수정") { (action, indexPath) in
            // edit item at indexPath
        }

        edit.backgroundColor = UIColor.gray

        return [delete, edit]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let UnitVC = segue.destination as? UnitTableViewController
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            UnitVC?.selectedSubject = selectedIndexPath.section
        }
    }

}
