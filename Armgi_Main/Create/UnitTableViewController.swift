//
//  unitTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/4/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class UnitTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var newUnitName: UITextField!
    @IBOutlet weak var modeView: UIView!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    
    var selectedSubject:Int = 0
    var selectedUnit:Int = 0

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUnit = indexPath.row
    }

    override func viewDidLoad() {
//        self.modeView.layer.borderWidth = 1
//        self.modeView.layer.borderColor = UIColor.darkGray.cgColor

        createButton.layer.shadowColor = UIColor.gray.cgColor
        createButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        createButton.layer.shadowRadius = 2
        createButton.layer.shadowOpacity = 1.0

        quizButton.layer.shadowColor = UIColor.gray.cgColor
        quizButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        quizButton.layer.shadowRadius = 2
        quizButton.layer.shadowOpacity = 1.0

        incorrectButton.layer.shadowColor = UIColor.gray.cgColor
        incorrectButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        incorrectButton.layer.shadowRadius = 2
        incorrectButton.layer.shadowOpacity = 1.0

        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //키보드 완료 버튼 누르면 키보드 숨기기.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = dataCenter.studyList[selectedSubject]?.unitList.count
        return rowCount!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unitCells", for: indexPath)
        cell.textLabel?.text = dataCenter.studyList[selectedSubject]?.unitList[indexPath.row].unitName
        //let unitCount = dataCenter.studyList[selectedSubject]?.unitList.count
        //if unitCount! > 0 {
        let unit = dataCenter.studyList[selectedSubject]?.unitList[indexPath.row]
        cell.detailTextLabel?.text = "\(unit!.allWords.count) , \(unit!.allSentences.count)"
//        } else {
//            cell.detailTextLabel?.text = "0"
//        }
        return cell
    }

// 새로운 단원명 버튼으로 추가하기.
    @IBAction func addNewUnit(_ sender: Any) {
        if let newUnit = newUnitName.text {
            if newUnit == "" {
                return
            } else {
                // let chosenUnit = dataCenter.studyList[selectedSubject]?.chosenUnit
                dataCenter.studyList[selectedSubject]?.unitList.append(OneUnit(unitName: newUnit))
                // dataCenter.studyList[selectedSubject]?.chosenUnit += 1
            }
        }
        self.newUnitName.text = nil
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        // 제거할 때 한 번 더물어보기.
        let deleteAlert = UIAlertController(title:"정말?", message:"단원을 삭제하시겠습니까?\r\n삭제시 내용 복구가 불가능합니다.", preferredStyle: .alert)
        let deleteOk = UIAlertAction(title:"확인", style: .destructive) { (action : UIAlertAction) in
            dataCenter.studyList[self.selectedSubject]?.unitList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let deleteCancel = UIAlertAction(title:"취소", style: .cancel, handler:nil)
        deleteAlert.addAction(deleteOk)
        deleteAlert.addAction(deleteCancel)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateSegue" {
            let SegmentVC = segue.destination as? SegmentViewController
            SegmentVC?.selectedSubject = selectedSubject
            let selectedIndexPath = self.tableView.indexPathForSelectedRow
            if let indexPath = selectedIndexPath{
                SegmentVC?.selectedUnit = indexPath.row
            }
        } else if segue.identifier == "QuizSegue" {
            let QuizSegmentVC = segue.destination as? QuizSegmentViewController
            QuizSegmentVC?.selectedSubject = selectedSubject
            let selectedIndexPath = self.tableView.indexPathForSelectedRow
            if let indexPath = selectedIndexPath{
                QuizSegmentVC?.selectedUnit = indexPath.row
            }
        } else if segue.identifier == "IncorrectSegue" {
            
        }
    }
}
