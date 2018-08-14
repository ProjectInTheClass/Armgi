//
//  IncorrectTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/14/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class IncorrectCell: UITableViewCell {

    @IBOutlet weak var odapTV: UITextView!
    @IBOutlet weak var odapCountLabel: UILabel!

}

class IncorrectTableViewController: UITableViewController {

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0
    var selectedOdap:Int = 0
    var odapList:[String] = []
    var odapMoreThree:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        let wordsData = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords
        let sentencesData = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences

        for item in wordsData {
            if item.odapCount == selectedOdap {
                odapList.append("\(item.keyword)\r\n\(item.explanation)")
                if selectedOdap == 3 {
                    odapMoreThree.append(3)
                }
            } else if item.odapCount > 3 && selectedOdap == 3 {
                odapList.append("\(item.keyword)\r\n\(item.explanation)")
                odapMoreThree.append(item.odapCount)
            }
        }

        for item in sentencesData {
            if item.odapCount == selectedOdap {
                odapList.append("\(item.sentences)")
            } else if item.odapCount > 3 && selectedOdap == 3 {
                odapList.append("\(item.sentences)")
                odapMoreThree.append(item.odapCount)
            }
        }
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
        // #warning Incomplete implementation, return the number of rows
        return odapList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "odapCell", for: indexPath)

        guard let odapCell = cell as? IncorrectCell else {
            return cell
        }

        odapCell.odapTV.text = odapList[indexPath.row]

        if selectedOdap == 3 {
            odapCell.odapCountLabel.text = String(odapMoreThree[indexPath.row]) + " 회"
        } else {
            odapCell.odapCountLabel.text = ""
        }

        return odapCell
    }
}
