//
//  BasicQuizViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/11/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class BasicQuizViewController: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTF: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var preButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0
    var qIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        subjectLabel.text = dataCenter.studyList[selectedSubject]?.subjectName
        unitLabel.text = dataCenter.studyList[selectedSubject]?.unitList[selectedUnit].unitName
    }

    override func viewWillAppear(_ animated: Bool) {
        if let count = dataCenter.studyList[selectedSubject]?.unitList[selectedUnit].allWords.count {
            if count > 0 {
                questionLabel.text = dataCenter.studyList[selectedSubject]?.unitList[selectedUnit].allWords[qIndex].keyword
            }
        }
        answerLabel.text = ""
        starButton.isHidden = true
        incorrectButton.isHidden = true
        preButton.isHidden = true
        nextButton.isHidden = true
    }

    @IBAction func CheckButton(_ sender: Any) {
        let answer = dataCenter.studyList[selectedSubject]?.unitList[selectedUnit].allWords[qIndex].explanation
        answerLabel.text = answer
        if answerTF.text == answer {
            answerLabel.textColor = UIColor.green
        } else {
            answerLabel.textColor = UIColor.red
            incorrectButton.isHidden = true
        }
        starButton.isHidden = false
        preButton.isHidden = false
        nextButton.isHidden = false
        checkButton.isEnabled = false
        self.view.endEditing(true)
    }
    
    @IBAction func NextButtton(_ sender: Any) {
        /*
        guard let indexPath = collectionView.indexPathsForVisibleItems.first.flatMap({
            IndexPath(item: $0.row + 1, section: $0.section)
        }), collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
*/
        qIndex += 1
    }

    @IBAction func PreButton(_ sender: Any) {
        if qIndex > 0 {
            qIndex -= 1
        }
        self.viewWillAppear(true)
    }
    var flag:Bool = true

    @IBAction func starButton(_ sender: Any) {
        if flag == true {
            starButton.setImage(UIImage(named: "star"), for: .normal)
            flag = false
        } else {
            starButton.setImage(UIImage(named: "blankstar"), for: .normal)
            flag = true
        }
    }
    
    @IBAction func incorrectButton(_ sender: Any) {
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
