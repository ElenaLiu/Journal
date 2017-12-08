//
//  MainPageTableViewController.swift
//  Journal
//
//  Created by 劉芳瑜 on 2017/12/8.
//  Copyright © 2017年 Fang-Yu. Liu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MainPageTableViewController: UITableViewController {
    @IBOutlet weak var receivingTitleLabel: UILabel!
    
    var titleArray = [""]
    
    func userDidPost(data: Any) {
        receivingTitleLabel.text = data as? String
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPageTableViewCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    


}
