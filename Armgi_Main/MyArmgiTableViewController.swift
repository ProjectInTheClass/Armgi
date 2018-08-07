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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCenter.starList.count
    }

    var starList: [String] = []
    
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let WordTVC = segue.destination as? WordTableViewController
        WordTVC?.delegate = self
    }
}
