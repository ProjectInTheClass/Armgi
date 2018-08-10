//
//  IncorrectViewController.swift
//  Armgi_Main
//
//  Created by CAUAD09 on 2018. 8. 10..
//  Copyright © 2018년 sspog. All rights reserved.
//

import UIKit

class IncorrectViewController: UIViewController {

    @IBOutlet weak var oneTime: UIView!
    @IBOutlet weak var twoTime: UIView!
    @IBOutlet weak var threeTime: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        oneTime.layer.borderColor = UIColor.black.cgColor
        oneTime.layer.borderWidth = 0.5
        twoTime.layer.borderColor = UIColor.black.cgColor
        twoTime.layer.borderWidth = 0.5
        threeTime.layer.borderColor = UIColor.black.cgColor
        threeTime.layer.borderWidth = 0.5
        
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
