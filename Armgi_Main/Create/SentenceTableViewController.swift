//
//  SentenceTableViewController.swift
//  amgi
//
//  Created by CAUAD09 on 2018. 8. 3..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit

class SentencesCell: UITableViewCell {

    @IBOutlet weak var sentenceText: UITextView!
    @IBOutlet weak var starMark: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SentenceTableViewController: UITableViewController, UITextFieldDelegate{

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0

    @IBOutlet weak var selectedSubjectName: UILabel!
    @IBOutlet weak var selectedUnitName: UILabel!
    @IBOutlet weak var newSentence: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSubjectName.text = dataCenter.studyList[selectedSubject].subjectName
        selectedUnitName.text = dataCenter.studyList[selectedSubject].unitList[selectedUnit].unitName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //키보드 완료 버튼 누르면 키보드 숨기기.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    // 텍스트 필드에 값이 입력되기 시작.
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //
    //    }

    //주변 터치해서 키보드 숨기기.

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let oneUnitDataCount = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences.count
        if  oneUnitDataCount > 0 {
            return oneUnitDataCount
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceSet", for: indexPath) as! SentencesCell
        let SentenceSet = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences[indexPath.row]
        cell.sentenceText?.text = SentenceSet.sentences
        if SentenceSet.starImageFlag == true{
            cell.starMark.image = UIImage(named: "goalStar")
        } else {
            cell.starMark.image = nil // 새로 추가한 셀에 자동으로 별이 붙는 걸 해결.
        }
        return cell
    }

    // 새로운 문장 저장하기.
    @IBAction func saveSentence(_ sender: Any) {
        if let newSentence = self.newSentence.text {
            if newSentence == "" {
                //빈 텍스트일 때
            } else {
                dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences.insert(Sentences(sentences: newSentence), at: 0)

                var bracketCount = 0
                var completeCount = 0
                var str:String = ""
                var strArr:[String] = []

                // 괄호 안의 값만 추출하기. // 빈괄호도 막아야하나?
                for character in newSentence {
                    if character == "(" {
                        bracketCount += 1
                    }
                    else if character == ")" {
                        bracketCount -= 1
                        completeCount += 1
                        strArr.append(str)
                        str = ""
                    }
                    if bracketCount == 1 {
                        str += String(character)
                    }
                    // 중첩 괄호 막기.
                    if bracketCount > 1 || bracketCount < 0 {
                        break
                    }
                }
                if bracketCount != 0 || bracketCount > 1 || bracketCount < 0 || completeCount > 3 {
                    print("error")
                } else {
                    print("good")
                    var index = 0
                    for item in strArr {
                        strArr[index] = item.trimmingCharacters(in : ["("])
                        index += 1
                    }
                    dataCenter.studyList[selectedSubject].unitList[selectedUnit].sentencesQuiz.append(strArr)
                    print(dataCenter.studyList[selectedSubject].unitList[selectedUnit].sentencesQuiz)
                }
            }
        }

        self.newSentence.text = nil
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .destructive, title: "삭제") { (action, indexPath) in
            dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allSentences.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        let star = UITableViewRowAction(style: .normal, title: "별표") { (action, indexPath) in
            if dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allSentences[indexPath.row].starFlag == true {
                let starCell = self.tableView.cellForRow(at: indexPath) as! SentencesCell
                starCell.starMark.image = UIImage(named: "goalStar")
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allSentences[indexPath.row].starImageFlag = true
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allSentences[indexPath.row].starFlag = false
            }
            else { // 별표 한 번 더 누르면 해제
                let starCell = self.tableView.cellForRow(at: indexPath) as! SentencesCell
                starCell.starMark.image = nil
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allSentences[indexPath.row].starImageFlag = false
                dataCenter.studyList[self.selectedSubject].unitList[self.selectedUnit].allSentences[indexPath.row].starFlag = true
            }
        }
        star.backgroundColor = UIColor().colorFromHex("#F9C835")
        return [delete, star]
    }
}
