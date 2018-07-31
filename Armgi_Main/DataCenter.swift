//
//  DataCenter.swift
//  Armgi_Main
//
//  Created by Tars on 7/26/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import Foundation

let dataCenter:DataCenter = DataCenter()

class DataCenter:NSObject, NSCoding {

    var studyName:[String]
    var ddayList:[Int]

    init?(studyName: [String], ddayList: [Int]){
        self.studyName = studyName
        self.ddayList = ddayList

        super.init()
    }
    // MARK: Archiving Paths

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!

    static let ArchiveURL = DocumentsDirectory.URL

    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("data")

    // MARK: NSCoding

    func encode(with aCoder: NSCoder){
        aCoder.encode(studyName, forKey: "studyName")
        aCoder.encode(ddayList, forKey: "dday")
    }

    required convenience init?(coder aDecoder: NSCoder){
        guard var studyName:[String] = aDecoder.decodeObject(forKey: "studyName") as? [String] else{
            return
        }
        guard var ddayList:[Int] = aDecoder.decodeObject(forKey: "dday") as? [Int] else{
            return
        }
        // Must call designated initializer.
        self.init(studyName: studyName, ddayList: ddayList)
    }
}
