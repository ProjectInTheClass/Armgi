//
//  SegmentViewController.swift
//  amgi
//
//  Created by CAUAD09 on 2018. 7. 30..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit

class QuizSegmentViewController: UIViewController {

    @IBOutlet weak var sentencesView: UIView!
    @IBOutlet weak var wordsView: UIView!

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
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
        if segue.identifier == "toBasicSegue" {
            let BasicQuiz = segue.destination as? BasicQuizViewController
            BasicQuiz?.selectedSubject = selectedSubject
            BasicQuiz?.selectedUnit = selectedUnit
        } else if segue.identifier == "toFlipSegue" {

        }
    }
}
