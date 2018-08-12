//
//  MyArmgiTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/6/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class starCell: UITableViewCell {

    @IBOutlet weak var starTextView: UITextView!
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

class MyArmgiTableViewController: UITableViewController {

    var starList:[String] = []

    @IBOutlet weak var randomTV: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 시한 폭탄 같은 존재.
    override func viewWillAppear(_ animated: Bool) {

        // 중요 표시한 모든 암기들을 보여준다.
        for i in 0 ..< dataCenter.studyList.count {
            for j in 0 ..< dataCenter.studyList[i].unitList.count {
                for k in 0 ..< dataCenter.studyList[i].unitList[j].allWords.count {
                    if dataCenter.studyList[i].unitList[j].allWords[k].starFlag == false {
                        // 별표 체크가 되었다면 false가 되있는 상태.
                        starList.append("\(dataCenter.studyList[i].unitList[j].allWords[k].keyword)\r\n\(dataCenter.studyList[i].unitList[j].allWords[k].explanation)")
                    }
                }
            }
        }

        // 랜덤으로 암기를 하나 선정해서 보여준다.

        let date = dataCenter.todayDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        let todayDate = dateFormatter.string(from: date)
        let currentDate = dateFormatter.string(from: Date())

        print(todayDate)
        print(currentDate)
        print()

        if starList.count > 0 && todayDate != currentDate { // 근데 만약 완전 처음 앱을 실행했다면? 아무것도 안뜨다가 다음날에 뜰것.
            let randNum:UInt32 = arc4random_uniform(UInt32(starList.count))
            randomTV.text = starList[Int(randNum)]

            dataCenter.todayDate = Date() // 오늘 날짜로 갱신.
        }

        self.tableView.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        starList = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if starList.count != 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "중요 표시한 암기가 없습니다"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starCell", for: indexPath)

        guard let starCell = cell as? starCell else{
            return cell
        }

        // if 키워드 방식이라면
        starCell.starTextView.text = "\(starList[indexPath.row])"
        starCell.starMark.image = UIImage(named: "goalStar")

        return starCell
    }
}
