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
    
    var fireUploadDic: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let databaseRef = Database.database().reference().child("UserPostImage")
        
        databaseRef.observe(.value, with: { [weak self] (snapshot) in
            
            if let uploadDataDic = snapshot.value as? [String:Any] {
                
                self?.fireUploadDic = uploadDataDic
                self?.tableView!.reloadData()
            }
        })
    }




    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let dataDic = fireUploadDic {
            
            return dataDic.count
        }
        
        return 0
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPageTableViewCell", for: indexPath) as? MainPageTableViewCell
        // Configure the cell
        if let dataDic = fireUploadDic {
            let keyArray = Array(dataDic.keys)
            if let imageUrlString = dataDic[keyArray[indexPath.row]] as? String {
                if let imageUrl = URL(string: imageUrlString) {
                    
                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            
                            print("Download Image Task Fail: \(error!.localizedDescription)")
                        }
                        else if let imageData = data {
                            
                            DispatchQueue.main.async {
                                
                                cell?.mainPageImageView.image = UIImage(data: imageData)
                            }
                        }
                        
                    }).resume()
                }
            }
        }
        
        return cell!
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "標題", message: "你確定要把我丟掉嗎？", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "嘿丟", style: .default, handler: { (action) in
                // Delete the row from the data source
                if indexPath.section == 0 {
                    if let dataDic = self.fireUploadDic {
                        var keyArray = Array(dataDic.keys)
                        if (dataDic[keyArray[indexPath.row]] as? String) != nil {
                            keyArray.remove(at: indexPath.row)
                        }
                    }
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
    
        }
    }
}
