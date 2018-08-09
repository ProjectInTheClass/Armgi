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
    
    var selectedUnit:OneUnit?

    @IBOutlet weak var newSentence: UITextView!
    @IBOutlet weak var selectedSubjectName: UILabel!
    @IBOutlet weak var selectedUnitName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        guard let rowCount = selectedUnit?.allSentences.count else {
            return 0
        }
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceSet", for: indexPath) as! SentencesCell

        guard let SentenceSet = selectedUnit?.allSentences[indexPath.row] else {
            return cell
        }
        cell.sentenceText?.text = SentenceSet
        
        return cell
    }
    
    @IBAction func saveSentence(_ sender: Any) {
        if let newSentence = self.newSentence.text {
            if newSentence == "" {
                return
            } else {
                selectedUnit?.allSentences.insert(newSentence, at: 0)
            }
        }
        self.newSentence.text = nil
        self.tableView.reloadData()
    }
    
    

}
