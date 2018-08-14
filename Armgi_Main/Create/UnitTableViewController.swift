//
//  unitTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/4/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class UnitTableViewCell: UITableViewCell {
    var isObserving = false;

    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!

    @IBOutlet weak var modeView: UIView!
    
    class var expandedHeight: CGFloat { get { return 179 } }
    class var defaultHeight: CGFloat { get { return 40 } }

    func checkHeight() {
        modeView.isHidden = (frame.size.height < UnitTableViewCell.expandedHeight)
    }

    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [.new, .initial], context: nil)
            isObserving = true;
        }
    }

    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
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
        // Initialization code
    }

}

class UnitTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var newUnitName: UITextField!

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0
    var selectedIndexPath: IndexPath?

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUnit = indexPath.row

        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }

        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }

        selectedUnit = indexPath.row
        self.view.endEditing(true)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? UnitTableViewCell)?.watchFrameChanges()
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? UnitTableViewCell)?.ignoreFrameChanges()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return UnitTableViewCell.expandedHeight
        } else {
            return UnitTableViewCell.defaultHeight
        }
    }

    override func viewDidLoad() {
//        self.modeView.layer.borderWidth = 1
//        self.modeView.layer.borderColor = UIColor.darkGray.cgColor

        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem // 테이블뷰 셀 편집
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells as! [UnitTableViewCell] {
            cell.ignoreFrameChanges()
        }
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
        let rowCount = dataCenter.studyList[selectedSubject].unitList.count
        return rowCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unitCells", for: indexPath)
        guard let unitCell = cell as? UnitTableViewCell else{
            return cell
        }

        unitCell.unitLabel.text = dataCenter.studyList[selectedSubject].unitList[indexPath.row].unitName
        let unit = dataCenter.studyList[selectedSubject].unitList[indexPath.row]
        unitCell.detailLabel.text = "\(unit.allWords.count) , \(unit.allSentences.count)"
        return unitCell
    }

// 새로운 단원명 버튼으로 추가하기.
    @IBAction func addNewUnit(_ sender: Any) {
        if let newUnit = newUnitName.text {
            if newUnit == "" {
                return
            } else {
                dataCenter.studyList[selectedSubject].unitList.append(OneUnit(unitName: newUnit))
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
            dataCenter.studyList[self.selectedSubject].unitList.remove(at: indexPath.row)
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
            SegmentVC?.selectedUnit = selectedUnit
        } else if segue.identifier == "QuizSegue" {
            let QuizSegmentVC = segue.destination as? QuizSegmentViewController
            QuizSegmentVC?.selectedSubject = selectedSubject
            QuizSegmentVC?.selectedUnit = selectedUnit
        } else if segue.identifier == "IncorrectSegue" {
            let IncorrectVC = segue.destination as? IncorrectViewController
            IncorrectVC?.selectedSubject = selectedSubject
            IncorrectVC?.selectedUnit = selectedUnit
        }
    }
}
