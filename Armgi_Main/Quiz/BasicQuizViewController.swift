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
    @IBOutlet weak var quizCardView: UIView!
    @IBOutlet var noDataView: UIView!

    var selectedSubject:Int = 0
    var selectedUnit:Int = 0

    var qIndex:Int = 0
    var answerIndex:Int = 0

    var questionWordsList:[String] = []
    var questionSentencesList:[String] = []
    var answerWordsList:[String] = []
    var answerSentencesList:[[String]] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        subjectLabel.text = dataCenter.studyList[selectedSubject].subjectName
        unitLabel.text = dataCenter.studyList[selectedSubject].unitList[selectedUnit].unitName

        let count:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords.count + dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences.count

        if count == 0 { // 생성된 암기가 없으면..
            // self.view.isHidden = true
            self.view = noDataView
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        let countWords:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords.count
        let countSentences:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences.count
        let count:Int = countWords + countSentences

        questionWordsList = []
        questionSentencesList = []
        answerWordsList = []
        answerSentencesList = []

        for i in 0 ..< countWords {
            questionWordsList.append(dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords[i].keyword)
            answerWordsList.append(dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords[i].explanation)
        }

        for i in 0 ..< countSentences {
        questionSentencesList.insert(dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences[i].sentences, at: 0)
            answerSentencesList.append(dataCenter.studyList[selectedSubject].unitList[selectedUnit].sentencesQuiz[i])
        }

        if count > 0 && qIndex < countWords {
            questionLabel.text = questionWordsList[qIndex]
        } else if count > 0 && qIndex >= countWords && qIndex < count {
            print("퀴즈 들어옴!")
            // 괄호만 빼고 출력하기.
            var question:String = ""
            var flag = 0
            for char in questionSentencesList[qIndex - countWords] {
                if flag == 1 {
                    question += "  "
                    if char == ")" {
                        question += String(char)
                        flag = 0
                    }
                } else {
                    question += String(char)
                    if char == "(" {
                        flag = 1
                    }
                }
            }
            questionLabel.text = question
        }

        answerLabel.text = ""
        starButton.isHidden = true
        incorrectButton.isHidden = true
        preButton.isHidden = true
        nextButton.isHidden = true
    }

    @IBAction func CheckButton(_ sender: Any) {
        let countWords:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords.count
        let countSentences:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences.count
        let count:Int = countWords + countSentences

        if count > 0 {
            if answerIndex < countWords {
                let answer = answerWordsList[qIndex]

                answerLabel.text = answer
                if answerTF.text == answer {
                    answerLabel.textColor = UIColor.green
                    incorrectButton.isHidden = true
                    checkButton.isEnabled = false
                } else {
                    answerLabel.textColor = UIColor.red
                    incorrectButton.isHidden = false
                    checkButton.isEnabled = false
                }

                answerIndex += 1

            } else if answerIndex >= countWords && answerIndex < count {
                print("이거다 + \(answerSentencesList)")
                let answer = answerSentencesList[qIndex - countWords]

                // 답을 만들기 위함.
                var answerStr:String = ""
                for item in answer {
                    answerStr += item
                }
                // 답을 출력해서 보여주기 위함.
                var str:String = ""
                for item in answer {
                    str += item
                    str += ", "
                }
                print(str)
                answerLabel.text = str

                let inputAnswer = answerTF.text?.components(separatedBy: ["/"," "]).joined()

                if inputAnswer == answerStr {
                    answerLabel.textColor = UIColor.green
                } else {
                    answerLabel.textColor = UIColor.red
                    incorrectButton.isHidden = false
                }

                answerIndex += 1
            }
        }

        starButton.isHidden = false
        preButton.isHidden = false
        nextButton.isHidden = false
        self.view.endEditing(true)
    }

    @IBAction func NextButtton(_ sender: Any) {
        self.quizCardView.NextButton()
        checkButton.isEnabled = true

        qIndex += 1
        let count:Int = dataCenter.studyList[selectedSubject].unitList[selectedUnit].allWords.count + dataCenter.studyList[selectedSubject].unitList[selectedUnit].allSentences.count

        if qIndex >= count {
            print ("암기 퀴즈가 끝났습니다!\r\n목표량이 일 증가합니다.")
            dataCenter.goalData.currentGoalVal[selectedSubject] += 1
            checkButton.isEnabled = false
            /*
             if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CelebrateVC") as? CelebrateViewController {
             present(vc, animated: true, completion: nil)
             }
             */
        }
        answerTF.text = "" // 텍스트 필드 비워주기.
        self.viewWillAppear(true)
    }

    @IBAction func PreButton(_ sender: Any) {
        self.quizCardView.PreButton()
        checkButton.isEnabled = true

        if qIndex > 0 {
            qIndex -= 1
        }
        answerTF.text = "" // 텍스트 필드 비워주기.
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
