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
    
    weak var delegate: AddPostDelegate?

    @IBOutlet weak var addPostImageView: UIImageView!
    
    @IBOutlet weak var addTitleField: UITextField!
    
    @IBOutlet weak var addContentField: UITextView!
    
    
    @IBAction func addSavePostButton(_ sender: UIButton) {
        if delegate != nil {
            if (addTitleField.text != nil), addContentField.text != nil {
                let data = addTitleField.text
                delegate?.userEditingPost(data: data!)
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    
    let picker = UIImagePickerController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    }
    
    func setUpPickPhotoFromGallary()
    {
        
        // 設定影像來源 這裡設定為相簿
        picker.sourceType = .photoLibrary
        // 設置 delegate
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        // 設定選完照片後可以編輯
        picker.allowsEditing = true
        // 顯示相簿
        self.present(self.picker, animated: true, completion: nil)
        
    }
    
    // 取得選取後的照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        picker.dismiss(animated: true, completion: nil) // 關掉
        self.addPostImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage // 從Dictionary取出原始圖檔
        self.addPostImageView.contentMode = .scaleAspectFit
        
        
    }
    
    // 圖片picker控制器任務結束回呼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        
        picker.dismiss(animated: true, completion: nil)
        
    }

}



