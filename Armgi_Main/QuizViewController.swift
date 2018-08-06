//
//  QuizViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/2/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBAction func decreaseGoalVal(_ sender: Any) {
        dataCenter.goalData.currentGoalVal += 1
        print(dataCenter.goalData.currentGoalVal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
