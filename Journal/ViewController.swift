//
//  ViewController.swift
//  Journal
//
//  Created by 劉芳瑜 on 2017/12/8.
//  Copyright © 2017年 Fang-Yu. Liu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage




class ViewController: UIViewController {
    

    @IBOutlet weak var addPostImageView: UIImageView!
    
    @IBOutlet weak var addTitleField: UITextField!
    
    @IBOutlet weak var addContentField: UITextView!
    
    @IBAction func addSavePostButton(_ sender: UIButton) {
        
        guard
            let title = addTitleField.text,
            let content = addContentField.text
            else {
                print("Form is not valid")
                return
        }
        
        let ref = Database.database().reference().child("posts").childByAutoId()
        let childUpdates = ["title": title, "content": content]
        ref.updateChildValues(childUpdates)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        addPostImageView.isUserInteractionEnabled = true
        addPostImageView.addGestureRecognizer(tapGestureRecognizer)
       
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let imagePickerAlertController = UIAlertController(title: "上傳圖片",
                                                           message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        
        
        let imageFromLibAction = UIAlertAction(title: "照片圖庫",
                                               style: .default) { (Void) in
            
           
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController,
                             animated: true,
                             completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "相機",
                                                  style: .default)
        { (Void) in
            
           
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                
                imagePickerController.sourceType = .camera
                self.present(imagePickerController,
                             animated: true,
                             completion: nil)
            }
        }
        
        
        let cancelAction = UIAlertAction(title: "取消",
                                         style: .cancel)
        { (Void) in
            
            imagePickerAlertController.dismiss(animated: true,
                                               completion: nil)
        }
        
        
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        
        present(imagePickerAlertController,
                animated: true,
                completion: nil)
        
    }
   
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        var selectedImageFromPicker: UIImage?
        
       
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            
            selectedImageFromPicker = pickedImage
        }
        
        
        let uniqueString = NSUUID().uuidString
        
        
        if let selectedImage = selectedImageFromPicker
        {
            
            let storageRef = Storage.storage().reference()
                .child("UserPostImage")
                .child("\(uniqueString).png")
            
            if let uploadData = UIImagePNGRepresentation(selectedImage)
            {
                
                storageRef.putData(uploadData,
                                   metadata: nil,
                                   completion:
                    {
                        (data, error) in
   
                    if error != nil
                        
                    {
                        
                        print("Error: \(error!.localizedDescription)")
                        
                        return
                    }
                    
                    
                    if let uploadImageUrl = data?.downloadURL()?.absoluteString
                    {
                        
                        print("Photo Url: \(uploadImageUrl)")
                        
                        let databaseRef = Database.database().reference()
                            .child("UserPostImage")
                            .child(uniqueString)
                        
                        databaseRef.setValue(uploadImageUrl,
                                             withCompletionBlock:
                            {
                                (error, dataRef) in
                            
                            if error != nil
                                
                            {
                                
                                print("Database Error: \(error!.localizedDescription)")
                            }
                            else {
                                
                                print("圖片已儲存")
                            }
                            
                        })
                    }
                })
            }
        }
        
        dismiss(animated: true, completion: nil)
    }

}



