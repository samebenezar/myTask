//
//  AddUserViewController.swift
//  Task
//
//  Created by Sam Ebenezar on 16/11/21.
//

import UIKit
import TOCropViewController

protocol newUser{
    
    func userAdded()
}

class AddUserViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var firstName_txt: SkyFloatingLabelTextField!
    @IBOutlet weak var lastName_txt: SkyFloatingLabelTextField!
    @IBOutlet weak var email_txt: SkyFloatingLabelTextField!
    @IBOutlet weak var userImage_img: SetImage!
    
    //MARK:- variables
    var delegate: newUser?
    let imagePicker = UIImagePickerController()
    var cropViewController = TOCropViewController()
    var cropStyle : TOCropViewCroppingStyle?
    var imageData = Data()
    var viewModel : AddUserViewModel? = AddUserViewModel()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add User"
        
    }
    
    //MARK:- Actions
    @IBAction func tapAddImage(_ sender: UIButton) {
        
        imagePickerFunction()
        
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
     
        valid()
        
    }
}

//MARK:- imagePickerDelegates
extension AddUserViewController :UIImagePickerControllerDelegate ,TOCropViewControllerDelegate , UIScrollViewDelegate , UINavigationControllerDelegate {
    
    func imagePickerFunction() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.camera()
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.photoLibrary()
                
            }))
            
            
        } else {
            
            actionSheet.addAction(UIAlertAction(title: "Upload Photo", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.photoLibrary()
                
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)  {
            
            actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width, y: self.view.bounds.size.height, width: 1.0, height: 1.0)
            
        }
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func camera(){
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func photoLibrary() {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        cropStyle = TOCropViewCroppingStyle.default
        
        cropViewController = TOCropViewController(croppingStyle: cropStyle!, image: image)
        
        cropViewController.toolbar.clampButtonHidden = true
        
        cropViewController.toolbar.rotateClockwiseButtonHidden = true
        
        cropViewController.cropView.aspectRatioLockEnabled = true
        
        cropViewController.toolbar.rotateButton.isHidden = true
        
        cropViewController.toolbar.resetButton.isHidden = true
        
        cropViewController.delegate = self
        
        dismiss(animated: true, completion: nil)
        
        self.navigationController?.present(cropViewController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        
        imageData = image.jpegData(compressionQuality: 1.0)!
        
        self.userImage_img.image = image
        
        cropViewController.dismiss(animated: true, completion: nil)
        
        
    }
}

//MARK:- validate&SaveData
extension AddUserViewController{
    
    func valid(){
        
        viewModel?.isValid(firstName: firstName_txt.text ?? "", lastName: lastName_txt.text ?? "", email: email_txt.text ?? "", image: imageData, completion: { success, message in
            
            if success{
                
                CoreDataActions().storeSingleData(firstName: self.firstName_txt.text ?? "", lastName: self.lastName_txt.text ?? "", email: self.email_txt.text ?? "", image: self.imageData, userId: Int.random(in: 10...99))
                self.delegate?.userAdded()
                self.navigationController?.popViewController(animated: true)
                
            }else{
                
                self.showAlert("Demo", message: message)
                
            }
        })
    }
}
