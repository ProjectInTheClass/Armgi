//
//  DataCenter.swift
//  Armgi_Main
//
//  Created by Tars on 7/26/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import Foundation

let dataCenter:DataCenter = DataCenter()

class DataCenter: NSObject, NSCoding{

    var studyList:[String]
    var ddayList:[Int]
    var goalData:GoalData
    var unitList:[OneUnit]
    var starList:[Words]
    var selectedColor:[Int]

    var templateColor:[String]

    override init(){
        self.studyList = []
        self.ddayList = []
        self.goalData = GoalData(currentGoalVal: 0)
        self.unitList = []
        self.starList = []
        self.selectedColor = []

        self.templateColor = ["#60ADED","#8EFA00","#FFFB00","#FF2600"]
        //순서대로 파란색,초록색,노란색,빨간색
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.studyList, forKey: "studyList")
        aCoder.encode(self.ddayList, forKey: "ddayList")
        aCoder.encode(self.goalData, forKey: "goalData")
        aCoder.encode(self.unitList, forKey: "unitList")
        aCoder.encode(self.starList, forKey: "starList")
        aCoder.encode(self.selectedColor, forKey: "selectedColor")
        aCoder.encode(self.templateColor, forKey: "templateColor")
    }

    public required init?(coder aDecoder: NSCoder) {
        if let studyList = aDecoder.decodeObject(forKey:"studyList") as? [String]{
            self.studyList = studyList
        } else {
            self.studyList = []
        }
        if let ddayList = aDecoder.decodeObject(forKey:"ddayList") as? [Int]{
            self.ddayList = ddayList
        } else {
            self.ddayList = []
        }
        if let goalData = aDecoder.decodeObject(forKey:"goalData") as? GoalData{
            self.goalData = goalData
        } else {
            self.goalData = GoalData(currentGoalVal: 0)
        }
        if let unitList = aDecoder.decodeObject(forKey:"unitList") as? [OneUnit]{
            self.unitList = unitList
        } else {
            self.unitList = []
        }
        if let starList = aDecoder.decodeObject(forKey:"starList") as? [Words]{
            self.starList = starList
        } else {
            self.starList = []
        }
        if let selectedColor = aDecoder.decodeObject(forKey:"selectedColor") as? [Int]{
            self.selectedColor = selectedColor
        } else {
            self.selectedColor = []
        }
        if let templateColor = aDecoder.decodeObject(forKey:"templateColor") as? [String]{
            self.templateColor = templateColor
        } else {
            self.templateColor = ["#60ADED","#8EFA00","#FFFB00","#FF2600"]
        }
    }
}

class GoalData: NSObject, NSCoding {
    var goalList:[Float]
    var currentGoalVal:Float

    init(currentGoalVal:Float) {
        self.goalList = []
        self.currentGoalVal = currentGoalVal
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.goalList, forKey: "goalList")
        aCoder.encode(self.currentGoalVal, forKey: "currentGoalVal")
    }

    public required init?(coder aDecoder: NSCoder) {
        if let goalList = aDecoder.decodeObject(forKey:"goalList") as? [Float]{
            self.goalList = goalList
        } else {
            self.goalList = []
        }
        if let currentGoalVal = aDecoder.decodeObject(forKey:"currentGoalVal") as? Float{
            self.currentGoalVal = currentGoalVal
        } else {
            self.currentGoalVal = 0
        }
    }
}

class OneUnit: NSObject, NSCoding {
    var unitName:String?
    var allWords:[Words]
    var allSentences:[String]

    init(unitName:String) {
        self.unitName = unitName
        self.allWords = []
        self.allSentences = []
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.unitName, forKey: "unitName")
        aCoder.encode(self.allWords, forKey: "allWords")
        aCoder.encode(self.allSentences, forKey: "allSentences")
    }

    public required init?(coder aDecoder: NSCoder) {
        if let unitName = aDecoder.decodeObject(forKey:"unitName") as? String?{
            self.unitName = unitName
        } else {
            self.unitName = ""
        }
        if let allWords = aDecoder.decodeObject(forKey:"allWords") as? [Words]{
            self.allWords = allWords
        } else {
            self.allWords = []
        }
        if let allSentences = aDecoder.decodeObject(forKey:"allSenctences") as? [String]{
            self.allSentences = allSentences
        } else {
            self.allSentences = []
        }
    }

}

class Words: NSObject, NSCoding{ //단어들
    var keyword:String
    var explanation:String
    var starFlag:Bool
    var starImageFlag:Bool

    init(keyword:String, explanation:String) {
        self.keyword = keyword
        self.explanation = explanation
        self.starFlag = false
        self.starImageFlag = false
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.keyword, forKey: "keyword")
        aCoder.encode(self.explanation, forKey: "explanation")
        aCoder.encode(self.starFlag, forKey: "starFlag")
        aCoder.encode(self.starImageFlag, forKey: "starImageFlag")
    }

    public required init?(coder aDecoder: NSCoder) {
        if let keyword = aDecoder.decodeObject(forKey:"keyWord") as? String{
            self.keyword = keyword
        } else {
            self.keyword = ""
        }
        if let explanation = aDecoder.decodeObject(forKey:"explanation") as? String{
            self.explanation = explanation
        } else {
            self.explanation = ""
        }
        if let starFlag = aDecoder.decodeObject(forKey:"starFlag") as? Bool{
            self.starFlag = starFlag
        } else {
            self.starFlag = false
        }
        if let starImageFlag = aDecoder.decodeObject(forKey:"starImageFlag") as? Bool{
            self.starImageFlag = starImageFlag
        } else {
            self.starImageFlag = false
        }
    }
}
