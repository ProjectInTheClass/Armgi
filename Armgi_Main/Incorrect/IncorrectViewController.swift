//
//  IncorrectViewController.swift
//  Armgi_Main
//
//  Created by CAUAD09 on 2018. 8. 10..
//  Copyright © 2018년 sspog. All rights reserved.
//

import UIKit

class IncorrectViewController: UIViewController {

    @IBOutlet weak var oneTime: UIView!
    @IBOutlet weak var twoTime: UIView!
    @IBOutlet weak var threeTime: UIView!
    
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!

    var selectedSubject = 0
    var selectedUnit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        oneTime.layer.borderColor = UIColor.black.cgColor
        oneTime.layer.borderWidth = 0.5
        twoTime.layer.borderColor = UIColor.black.cgColor
        twoTime.layer.borderWidth = 0.5
        threeTime.layer.borderColor = UIColor.black.cgColor
        threeTime.layer.borderWidth = 0.5
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let wordsCount:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords.count
        let sentencesCount:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences.count

        var oneTime:Int = 0
        var twoTime:Int = 0
        var threeTime:Int = 0

        for i in 0 ..< wordsCount {
            switch dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords[i].odapCount {
                case 0:
                    break
                case 1:
                    oneTime += 1
                    break
                case 2:
                    twoTime += 1
                    break
                default:
                    threeTime += 1
            }
        }

        for i in 0 ..< sentencesCount {
            switch dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences[i].odapCount {
            case 0:
                break
            case 1:
                oneTime += 1
                break
            case 2:
                twoTime += 1
                break
            default:
                threeTime += 1
            }
        }

        oneLabel.text = String(oneTime)
        twoLabel.text = String(twoTime)
        threeLabel.text = String(threeTime)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let IncorrectTVC = segue.destination as? IncorrectTableViewController
        if segue.identifier == "odapOne" {
            IncorrectTVC?.selectedOdap = 1
        } else if segue.identifier == "odapTwo" {
            IncorrectTVC?.selectedOdap = 2
        } else if segue.identifier == "odapThree" {
            IncorrectTVC?.selectedOdap = 3
        }
        IncorrectTVC?.selectedSubject = selectedSubject
        IncorrectTVC?.selectedUnit = selectedUnit
    }
}
