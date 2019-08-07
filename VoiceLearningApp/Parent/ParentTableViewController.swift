//
//  ParentTableViewController.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 04/04/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit

class ParentTableViewController: UITableViewController {

    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "TableVieCellForParent", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CellForParent")
        LogEventData.get { (hasResults) in
            while !hasResults{
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.2, execute: {})
            }
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: NSIndexPath(row: LogEventData.arrayResults.count-1, section: 0) as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
        }
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LogEventData.arrayResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForParent", for: indexPath) as! TableVieCellForParent
        count = 0
        let array = LogEventData.arrayResults.keys.sorted { (obj1, obj2) -> Bool in
            return obj1<obj2
        }
        for key in array{
            if(count==indexPath.row){
                print("\(key) : \(LogEventData.arrayResults[key])")
                cell.dateLAble.text = key
                cell.eventLable.text = LogEventData.arrayResults[key]
            }
            count+=1
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
