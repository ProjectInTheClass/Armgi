//
//  SegmentViewController.swift
//  amgi
//
//  Created by CAUAD09 on 2018. 7. 30..
//  Copyright © 2018년 NEURRRI. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {
    
    var selectedUnit:OneUnit?
   
    @IBOutlet weak var sentencesView: UIView!
    @IBOutlet weak var wordsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            wordsView.alpha = 1
            sentencesView.alpha = 0
        } else {
            wordsView.alpha = 0
            sentencesView.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toWordsView" {
            let nextController = segue.destination as? WordTableViewController
            nextController?.selectedUnit = self.selectedUnit
        }else if segue.identifier == "toSentencesView" {
            let nextController = segue.destination as? SentenceTableViewController
            nextController?.selectedUnit = self.selectedUnit
        }
    }
}
