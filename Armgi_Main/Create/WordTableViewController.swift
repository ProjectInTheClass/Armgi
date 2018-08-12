//
//  WordTableViewController.swift
//  amgi
//
//  Created by CAUAD09 on 2018. 8. 3..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit

class WordsCell: UITableViewCell {

    @IBOutlet weak var explanationText: UITextView!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var starMark: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class WordTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var selectedSubjectName: UILabel!
    @IBOutlet weak var selectedUnitName: UILabel!
    @IBOutlet weak var newKeyword: UITextField!
    @IBOutlet weak var newExplanation: UITextView!

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSubjectName.text = dataCenter.studyList[selectedSubject].subjectName
        selectedUnitName.text = dataCenter.studyList[selectedSubject].unitList[selectedUnit].unitName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //키보드 완료 버튼 누르면 키보드 숨기기.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let oneUnitDataCount = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords.count
        if  oneUnitDataCount > 0 {
            return oneUnitDataCount
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keywordSet", for: indexPath) as! WordsCell

        let wordSet = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords[indexPath.row]
        cell.keywordLabel?.text = wordSet.keyword
        cell.explanationText?.text = wordSet.explanation
        if wordSet.starImageFlag == true{
            cell.starMark.image = UIImage(named: "goalStar")
        } else {
            cell.starMark.image = nil // 새로 추가한 셀에 자동으로 별이 붙는 걸 해결.
        }
        return cell
    }
    
    @IBAction func saveNewWordSetButton(_ sender: Any) {
        if let newKeyword = self.newKeyword.text, let newExplanation = self.newExplanation.text {
            if newKeyword == "" || newExplanation == "" {
                //빈 텍스트일 때
            } else {
                dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords.insert(Words(keyword: newKeyword, explanation: newExplanation), at: 0)
            }
        }
        self.newKeyword.text = nil
        self.newExplanation.text = nil
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "삭제") { (action, indexPath) in
            dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allWords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let star = UITableViewRowAction(style: .normal, title: "별표") { (action, indexPath) in
            if dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allWords[indexPath.row].starFlag == true {
                let starCell = self.tableView.cellForRow(at: indexPath) as! WordsCell
                starCell.starMark.image = UIImage(named: "goalStar")
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allWords[indexPath.row].starImageFlag = true
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allWords[indexPath.row].starFlag = false
            }
            else { // 별표 한 번 더 누르면 해제
                let starCell = self.tableView.cellForRow(at: indexPath) as! WordsCell
                starCell.starMark.image = nil
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allWords[indexPath.row].starImageFlag = false
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allWords[indexPath.row].starFlag = true
            }
        }
        star.backgroundColor = UIColor().colorFromHex("#F9C835")
        return [delete, star]
    }
}
