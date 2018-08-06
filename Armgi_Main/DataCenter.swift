//
//  DataCenter.swift
//  Armgi_Main
//
//  Created by Tars on 7/26/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import Foundation

let dataCenter:DataCenter = DataCenter()

class DataCenter{

    var studyList:[String]
    var selectedSubject:Int
    var ddayList:[Int]
    var goalData:GoalData
    var templateColor:[String]
    var selectedColor:[Int]
    var collectionViewCellCurrent:Int //MainTableView에 현재 존재하는 셀의 개수를 저장.

    init(){
        self.studyList = []
        self.selectedSubject = 0
        self.ddayList = []
        self.goalData = GoalData(currentGoalVal: 0)
        self.templateColor = ["#60ADED","#8EFA00","#FFFB00","#FF2600"]
        //순서대로 파란색,초록색,노란색,빨간색
        self.selectedColor = []
        self.collectionViewCellCurrent = 0
    }
}

class GoalData {
    var goalList:[Float]
    var currentGoalVal:Float

    init(currentGoalVal:Float) {
        self.goalList = []
        self.currentGoalVal = currentGoalVal
    }
}

class OneUnit {
    var unitName:String?
    var allWords:[Words]
    var allSentences:[String]

    init(unitName:String) {
        self.unitName = unitName
        self.allWords = []
        self.allSentences = []
    }
}

class Words { //단어들
    var keyword:String
    var explanation:String

    init(keyword:String, explanation:String) {
        self.keyword = keyword
        self.explanation = explanation
    }

}

//optional로 처리 안해도 될까? 처리하면 append가 안되는데?
