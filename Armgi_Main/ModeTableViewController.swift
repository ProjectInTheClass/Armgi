//
//  ModeTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/4/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class ModeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
