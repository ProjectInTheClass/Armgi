//
//  SegmentViewController.swift
//  amgi
//
//  Created by CAUAD09 on 2018. 7. 30..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {
   
    @IBOutlet weak var sentencesView: UIView!
    @IBOutlet weak var wordsView: UIView!

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        print(selectedUnit)
        print(selectedSubject)
    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            wordsView.alpha = 1
            sentencesView.alpha = 0
        } else {
            wordsView.alpha = 0
            sentencesView.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWordsView" {
            let WordTVC = segue.destination as? WordTableViewController
            WordTVC?.selectedSubject = selectedSubject
            WordTVC?.selectedUnit = selectedUnit
        } else if segue.identifier == "toSentencesView" {
            let SentenceTVC = segue.destination as? SentenceTableViewController
            SentenceTVC?.selectedSubject = selectedSubject
            SentenceTVC?.selectedUnit = selectedUnit
        }
    }
}
