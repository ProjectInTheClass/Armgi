////
////  MyArmgiTableViewController.swift
////  Armgi_Main
////
////  Created by Tars on 8/6/18.
////  Copyright © 2018 sspog. All rights reserved.
////
//
//import UIKit
//
//class starCell: UITableViewCell {
//
//    @IBOutlet weak var starTextView: UITextView!
//    @IBOutlet weak var starMark: UIImageView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//}
//
//class MyArmgiTableViewController: UITableViewController {
//
//    var starList:[String]?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        for i in 0 ..< dataCenter.studyList.count{
//            for j in 0 ..< dataCenter.studyList[i]!.oneUnitData.count{
//                for k in 0 ..< dataCenter.studyList[i]!.oneUnitData[j].allWords.count{
//                    if dataCenter.studyList[i]!.oneUnitData[j].allWords[k].starFlag == true {
//                        starList?.append("\(dataCenter.studyList[i]!.oneUnitData[j].allWords[k].keyword)\r\n\(dataCenter.studyList[i]!.oneUnitData[j].allWords[k].explanation)")
//                    }
//                }
//            }
//        }
//        self.tableView.reloadData()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let newStarList = starList{
//            return newStarList.count
//        }
//        return 0
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "starCell", for: indexPath)
//
//        guard let starCell = cell as? starCell else{
//            return cell
//        }
//
//        // if 키워드 방식이라면
//        starCell.starTextView.text = "\(starList?[indexPath.row])"
//
//        starCell.starMark.image = UIImage(named: "goalStar")
//
//        return starCell
//    }
//}
