//
//  ProfileUpdateVC.swift
//  Ecommerce
//
//  Created by smit on 09/01/25.
//

import UIKit
import SDWebImage

class ProfileUpdateVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    private let UserResource = User.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfile()
        profileImg.layer.cornerRadius = 20
        profileImg.layer.borderWidth = 5
        profileImg.layer.borderColor = UIColor.blue.cgColor
    }
    
    func loadProfile(){
        UserResource.getUserProfile { [weak self ] gender , img in
            guard let self = self else {return }
            self.profileImg.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "profile"))
            
        }
    }
    func updateProfile(){
        UserResource.userProfileUpdate("male", profileImg.image!){ [weak self] valid in
            guard let self = self else { return  }
            if  valid {
                self.showToast(msg: "sucess update profile")
                
            }else {
                self.showToast(msg: "Somthing Went wrong..")
                
            }
        }
    }
        @IBAction func onBtnUpdateImg(_ sender: UIButton) {
            let UIImagePickCtr = UIImagePickerController()
            UIImagePickCtr.sourceType = UIImagePickerController.SourceType.photoLibrary
            UIImagePickCtr.delegate = self
            self.present(UIImagePickCtr, animated: true)
        }
        
    }
    
    extension ProfileUpdateVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image  =  info[.originalImage] as? UIImage {
                print("--->",image)
                profileImg.image = image
                updateProfile()
            }
            
            picker.dismiss(animated: true)
            
        }
        
        
        
    }

