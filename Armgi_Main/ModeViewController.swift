//
//  ModeViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/9/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class ModeViewController: UIViewController {

    var selectedSubject:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedSubject)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let UnitTVC = segue.destination as? UnitTableViewController
        UnitTVC?.selectedSubject = selectedSubject
    }
}
