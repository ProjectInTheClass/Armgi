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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class WordTableViewController: UITableViewController {
    
    var selectedUnit:OneUnit?

    @IBOutlet weak var selectedSubjectName: UILabel!
    @IBOutlet weak var selectedUnitName: UILabel!
    @IBOutlet weak var newKeyword: UITextField!
    @IBOutlet weak var newExplanation: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSubjectName.text = dataCenter.studyList[dataCenter.selectedSubject]
        selectedUnitName.text = selectedUnit?.unitName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
        
        return cell
    }
    
    @IBAction func saveNewWordSetButton(_ sender: Any) {
        if let newKeyword = self.newKeyword.text, let newExplanation = self.newExplanation.text {
            if newKeyword == "" || newExplanation == "" {
                //빈 텍스트일 때
            } else {
                //wordData.keywordList.append(newKeyword)
                selectedUnit?.allWords.insert(Words(keyword: newKeyword, explanation: newExplanation), at: 0)
            }
        }
        self.newKeyword.text = nil
        self.newExplanation.text = nil
        self.tableView.reloadData()
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
