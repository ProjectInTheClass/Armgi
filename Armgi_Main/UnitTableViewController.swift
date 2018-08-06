//
//  unitTableViewController.swift
//  Armgi_Main
//
//  Created by Tars on 8/4/18.
//  Copyright © 2018 sspog. All rights reserved.
//

import UIKit

class unitTableViewController: UITableViewController {

    var unitList:[OneUnit] = []

    @IBOutlet weak var newUnitName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let rowCount = unitList.count
        return rowCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unitCells", for: indexPath)
        let unit = unitList[indexPath.row]
        cell.textLabel?.text = unit.unitName
        cell.detailTextLabel?.text = "\(unit.allWords.count + unit.allSentences.count)"
        return cell

    }

    @IBAction func addNewUnit(_ sender: Any) {
        if let newUnit = newUnitName.text {
            if newUnit == "" {
                return
            } else {
                unitList.append(OneUnit(unitName: newUnit))
            }
        }
        self.newUnitName.text = nil
        self.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        // 제거할 때 한 번 더물어보기.
        let deleteAlert = UIAlertController(title:"정말?", message:"단원을 삭제하시겠습니까?\r\n삭제시 내용 복구가 불가능합니다.", preferredStyle: .alert)
        let deleteOk = UIAlertAction(title:"확인", style: .destructive) { (action : UIAlertAction) in
            self.unitList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let deleteCancel = UIAlertAction(title:"취소", style: .cancel, handler:nil)
        deleteAlert.addAction(deleteOk)
        deleteAlert.addAction(deleteCancel)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nextViewcontroller = segue.destination as? SegmentViewController
        let selectedIndexPath = self.tableView.indexPathForSelectedRow
        if let indexPath = selectedIndexPath {
            nextViewcontroller?.selectedUnit = unitList[indexPath.row]
        }
    }

}
