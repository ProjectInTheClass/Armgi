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
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class WordTableViewController: UITableViewController, UITextFieldDelegate{
    
    var selectedUnit: OneUnit?
    var delegate: MyArmgiTableViewController?

    @IBOutlet weak var selectedSubjectName: UILabel!
    @IBOutlet weak var selectedUnitName: UILabel!
    @IBOutlet weak var newKeyword: UITextField!
    @IBOutlet weak var newExplanation: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedUnitName.text = selectedUnit?.unitName
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
    //주변 터치해서 키보드 숨기기.

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowCount = selectedUnit?.allWords.count else {
            return 0
        }
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keywordSet", for: indexPath) as! WordsCell
        
        guard let wordSet = selectedUnit?.allWords[indexPath.row] else {
            return cell
        }

        cell.keywordLabel?.text = wordSet.keyword
        cell.explanationText?.text = wordSet.explanation

        if selectedUnit?.allWords[indexPath.row].starImageFlag == true{
            cell.starMark.image = UIImage(named: "goalStar")
        }
        selectedUnit?.allWords[indexPath.row].starFlag = true

        return cell
    }
    
    @IBAction func saveNewWordSetButton(_ sender: Any) {
        if let newKeyword = self.newKeyword.text, let newExplanation = self.newExplanation.text {
            if newKeyword == "" || newExplanation == "" {
                //빈 텍스트일 때
            } else {
                selectedUnit?.allWords.append(Words(keyword: newKeyword, explanation: newExplanation))
            }
        }
        self.newKeyword.text = nil
        self.newExplanation.text = nil
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "삭제") { (action, indexPath) in
            self.selectedUnit?.allWords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        let star = UITableViewRowAction(style: .normal, title: "별표") { (action, indexPath) in

            if self.selectedUnit?.allWords[indexPath.row].starFlag == true{
                let starCell = self.tableView.cellForRow(at: indexPath) as! WordsCell
                starCell.starMark.image = UIImage(named: "goalStar")
                self.selectedUnit?.allWords[indexPath.row].starImageFlag = true
                self.selectedUnit?.allWords[indexPath.row].starFlag = false

                let starText = "\(self.selectedUnit?.allWords[indexPath.row].keyword)\r\n\(self.selectedUnit?.allWords[indexPath.row].explanation)"
                self.delegate?.starList.append(starText)

            } else { // 별표 한 번 더 누르면 해제
                let starCell = self.tableView.cellForRow(at: indexPath) as! WordsCell
                starCell.starMark.image = nil
                self.selectedUnit?.allWords[indexPath.row].starImageFlag = false
                self.selectedUnit?.allWords[indexPath.row].starFlag = true
            }
        }
        star.backgroundColor = UIColor().colorFromHex("#F9C835")
        return [delete, star]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let MainTVC = segue.destination as? MainTableViewController
        MainTVC?.delegate = self
    }
}
