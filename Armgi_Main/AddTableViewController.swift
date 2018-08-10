//
//  AddTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 7/26/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    var collectionViewCellCurrent = 0

    //목표량 바 색상 선택
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCenter.templateColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        cell.backgroundColor = UIColor().colorFromHex(dataCenter.templateColor[indexPath.row])
        //처음 박스를 검은색으로 미리 설정.
        if indexPath.row == 0{
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 2.0
        }
        return cell

    }

    //다른 박스 선택시 기존 박스 체크 해제
    var preCellIndex:IndexPath = [0,0]
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let preCell = collectionView.cellForItem(at: preCellIndex)
        if indexPath != preCellIndex{
            cell?.layer.borderColor = UIColor.black.cgColor
            cell?.layer.borderWidth = 2.0
            preCell?.layer.borderWidth = 0
            preCellIndex = indexPath
            collectionViewCellCurrent = indexPath.row
        }
        print(collectionViewCellCurrent)
    }


    @IBOutlet weak var studyTitleInput: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker! // pickerView로 선택한 마감날짜.
    @IBOutlet weak var goalValueLabel: UILabel!
    @IBOutlet weak var stepperValue: UIStepper!
    @IBAction func stepperAction(_ sender: Any) {
        goalValueLabel.text = "\(Int(stepperValue.value))"
    }

    //텍스트 필드 공백시 알림
    let inputAlert = UIAlertController(title:"어이쿠!", message:"학습 주제나 목표량이 제대로 입력되었는지\r\n확인해주세요!", preferredStyle: .alert)
    let inputAlertAction = UIAlertAction(title:"확인", style: .default, handler: nil)

    @objc func dismissFunc(){
        self.inputAlert.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 홈 버튼을 누르고 돌아오면 오류메시지 안보이기.
        inputAlert.addAction(inputAlertAction)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dismissFunc), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        // 콜렉션 뷰 셀 간격.
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20 // ?
        collectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//완료 버튼으로 모달창 닫기.
    @IBAction func doneDismiss(_ sender: Any) {
        if let studyTitleInput = studyTitleInput.text{
            if studyTitleInput == "" || Int(stepperValue.value) == 0{
                self.present(inputAlert, animated: true, completion: nil)
            } else {
                dataCenter.studyList[dataCenter.chosenSubject] = Study(subjectName: studyTitleInput)
                dataCenter.chosenSubject += 1

                print(dataCenter.studyList)

                dataCenter.ddayList.append(findDday())
                dataCenter.goalData.goalList.append(Float(stepperValue.value))
                dataCenter.selectedColor.append(collectionViewCellCurrent)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

//취소 버튼으로 모달창 닫기.
    @IBAction func cancelDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

//키보드 완료 버튼 누르면 키보드 숨기기.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

//Dday를 구해주는 함수
     func findDday() -> Int{
        let todayDate = Date()
        do {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day]
            formatter.unitsStyle = .full //필요.
            if let daysString = formatter.string(from: todayDate, to: endDatePicker.date) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .none
                let startDate = dateFormatter.string(from: todayDate)
                let endDate = dateFormatter.string(from: endDatePicker.date)
                if startDate == endDate{
                    return 0
                }
                let ddayArr = daysString.components(separatedBy: " ")
                if let ddayIndexZero = Int(ddayArr[0].components(separatedBy: [","]).joined()){
                    if ddayIndexZero < 0{
                        return ddayIndexZero
                    }
                    else{
                        return ddayIndexZero + 1
                    }
                }
            }
        }
        return 9999
    }
}
