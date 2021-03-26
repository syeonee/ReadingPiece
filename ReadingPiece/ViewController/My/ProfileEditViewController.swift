//
//  ProfileEditViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/22.
//

import UIKit
import KeychainSwift

class ProfileEditViewController: UIViewController {
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    @IBOutlet weak var completeButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileEditButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameCountLabel: UILabel!
    @IBOutlet weak var nameDuplicateCheckButton: UIButton!
    
    @IBOutlet weak var resolutionTextField: UITextField!
    @IBOutlet weak var resolutionRemoveButton: UIButton!
    @IBOutlet weak var resolutionCountLabel: UILabel!
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    let picker = UIImagePickerController()
    var pickedImage : UIImage?
    
    let maxLength = 30
    var isNameCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        nameTextField.delegate = self
        resolutionTextField.delegate = self
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        if let data = UserDefaults.standard.data(forKey: "profileImageData"){
            let decodedimage = UIImage(data: data as Data)
            profileImageView.image = decodedimage
            pickedImage = decodedimage
        }
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nameTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: resolutionTextField)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nameTextField)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: resolutionTextField)
    }
    
    @IBAction func editCancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editCompleteButtonTapped(_ sender: Any) {
        if isNameCheck {
            self.showIndicator()
            guard let token = keychain.get(Keys.token) else { return }
            print("send name is \(nameTextField.text!)")
            Network.request(req: EditProfileRequest(token: token, name: nameTextField.text!, profileImage: pickedImage?.jpegData(compressionQuality: 0.3)?.base64EncodedString() ?? nil, resolution: resolutionTextField.text!)) { [self] result in
                self.dismissIndicator()
                switch result {
                case .success(let response):
                    self.dismissIndicator()
                    let result = response.code
                    if result == 1000 {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.presentAlert(title: response.message, isCancelActionIncluded: false) {_ in
                        }
                    }
                case .cancel(let cancelError):
                    self.dismissIndicator()
                    print(cancelError as Any)
                case .failure(let error):
                    self.dismissIndicator()
                    print(error as Any)
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false) {_ in
                    }
                }
            }
        } else {
            self.presentAlert(title: "닉네임 중복체크를 해주세요.", isCancelActionIncluded: false) {_ in
            }

        }
        
        
    }
    @IBAction func profileEditButtonTapped(_ sender: Any) {
        addImageAlertAction()
    }
    
    @IBAction func nameDuplicateCheckButtonTapped(_ sender: Any) {
        if let nameText = nameTextField.text, nameText != "" {
            isNameCheck = false
            self.showIndicator()
            guard let token = keychain.get(Keys.token) else { return }
            print("send name is \(nameTextField.text!)")
            Network.request(req: NameDuplicateRequest(token: token, name: nameTextField.text!)) { [self] result in
                self.dismissIndicator()
                switch result {
                case .success(let response):
                    self.dismissIndicator()
                    let result = response.code
                    if result == 1000 {
                        isNameCheck = true
                    }
                    self.presentAlert(title: response.message, isCancelActionIncluded: false) {_ in
                    }
                case .cancel(let cancelError):
                    self.dismissIndicator()
                    print(cancelError as Any)
                case .failure(let error):
                    self.dismissIndicator()
                    print(error as Any)
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false) {_ in
                    }
                }
            }
        }else{
            self.presentAlert(title: "닉네임을 입력해주세요", isCancelActionIncluded: false) {_ in
            }
        }
        
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
            self.pickedImage = nil
            UserDefaults.standard.removeObject(forKey: "profileImageData")
            self.profileImageView.image = UIImage(named: "defaultProfile")
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
                isNameCheck = false
            }
        }
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height // 새 이미지 확대/축소 비율
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage(named: "defaultProfile")! }
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            setSelectedImage(resizeImage(image: image, newHeight: 330))
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
    }
}

