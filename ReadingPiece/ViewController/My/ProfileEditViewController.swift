//
//  ProfileEditViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/22.
//

import UIKit

class ProfileEditViewController: UIViewController {
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    @IBOutlet weak var completeButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileEditButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameRemoveButton: UIButton!
    @IBOutlet weak var nameCountLabel: UILabel!
    
    @IBOutlet weak var resolutionTextField: UITextField!
    @IBOutlet weak var resolutionRemoveButton: UIButton!
    @IBOutlet weak var resolutionCountLabel: UILabel!
    
    let picker = UIImagePickerController()
    var pickedImage : UIImage?
    
    let maxLength = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        nameTextField.delegate = self
        resolutionTextField.delegate = self
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nameTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: resolutionTextField)
        
    }
    
    @IBAction func editCancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editCompleteButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func profileEditButtonTapped(_ sender: Any) {
        addImageAlertAction()
    }
    
    @IBAction func nameRemoveButtonTapped(_ sender: Any) {
        nameTextField.text = ""
    }
    
    @IBAction func resolutionRemoveButtonTapped(_ sender: Any) {
        resolutionTextField.text = ""
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }else{
            print("LOG - 카메라 로드 실패")
        }
    }
    
    func addImageAlertAction() {
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "갤러리 선택", style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "사진 촬영", style: .default) { (action) in
            self.openCamera()
        }
        let deleteImage =  UIAlertAction(title: "삭제", style: .destructive) { (action) in
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(deleteImage)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                if text.count > maxLength {
                    // 최대글자 넘어가면 자동으로 키보드 내려감
                    textField.resignFirstResponder()
                }
                
                // 초과되는 텍스트 제거
                if text.count >= maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
                if text.count <= maxLength {
                    if textField == nameTextField {
                        nameCountLabel.text = "\(text.count)"
                    }else{
                        resolutionCountLabel.text = "\(text.count)"
                    }
                }
            }
        }
    }
    
}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            setSelectedImage(image)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setSelectedImage(_ img: UIImage) {
        DispatchQueue.main.async {
            self.pickedImage = img
            self.profileImageView.image = self.pickedImage
        }
    }
}

extension ProfileEditViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        
        return true
        if textField == nameTextField {
            
        }
    }
}
