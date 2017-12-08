//
//  ViewController.swift
//  Journal
//
//  Created by 劉芳瑜 on 2017/12/8.
//  Copyright © 2017年 Fang-Yu. Liu. All rights reserved.
//

import UIKit
import CoreData

protocol AddPostDelegate: class {
    func userEditingPost(data: Any)
    }

class ViewController: UIViewController {

    @IBOutlet weak var addPostImageView: UIImageView!
    
    @IBOutlet weak var addTitleField: UITextField!
    
    @IBOutlet weak var addContentField: UITextView!
    
    @IBOutlet weak var addSavePostButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    }

}



