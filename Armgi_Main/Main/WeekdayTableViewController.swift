//
//  WeekdayTableViewController.swift
//  Armgi_Main
//
//  Created by CAUAD09 on 2018. 8. 14..
//  Copyright © 2018년 sspog. All rights reserved.
//

import UIKit

class WeekdayTableViewController: UITableViewController {
    
    var weekdays:[Int] = []
    var delegate:AddTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.repeatWeekdays = weekdays
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        for weekday in weekdays {
            if weekday == (indexPath.row + 1) {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if let index = weekdays.index(of: (indexPath.row + 1)) {
            weekdays.remove(at: index)
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: false)
            cell?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            weekdays.append(indexPath.row + 1)
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: false)
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
}

extension WeekdayTableViewController {
    static func repeatText(weekdays: [Int]) -> String {
        if weekdays.count == 7 {
            return "매일"
        }
        
        if weekdays.isEmpty {
            return "없음"
        }
        
        var ret = String()
        var weekdaysSorted:[Int] = [Int]()
        
        weekdaysSorted = weekdays.sorted(by: <)
        
        for day in weekdaysSorted {
            switch day{
            case 1:
                ret += "일 "
            case 2:
                ret += "월 "
            case 3:
                ret += "화 "
            case 4:
                ret += "수 "
            case 5:
                ret += "목 "
            case 6:
                ret += "금 "
            case 7:
                ret += "토 "
            default:
                //throw
                break
            }
        }
        return ret
    }
}

