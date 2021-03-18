//
//  DailyDiaryWrittenViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/06.
//

import UIKit

class DaillyReadingWritenViewController: UIViewController {
    let cellId = ReviewImageCell.identifier
    let picker = UIImagePickerController()
    var pickedImage : UIImage?

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var bookInfoView: UIView!
    @IBOutlet weak var bookThumbnailImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var readingPageInputButton: UIButton!
    @IBOutlet weak var readingPercentInputButton: UIButton!
    @IBOutlet weak var publicPostButton: UIButton!
    @IBOutlet weak var privatePostButton: UIButton!
    @IBOutlet weak var postDairyButton: UIButton!
    @IBOutlet weak var commentLengthLabel: UILabel!
    @IBOutlet weak var reviewImageHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewImagePopButton: UIButton! {
        didSet {
            reviewImagePopButton.isHidden = !reviewImagePopButton.isHidden
        }
    }
    
    // 구현 편의상 버튼으로 구현, 따로 연결된 Action은 없음
    // UI셋업만 진행하고, 연결된 로직은 없는 컴포넌트
    @IBOutlet weak var readingStatusButton: UIButton!
    @IBOutlet weak var totalReadingTimeButton: UIButton!
    @IBOutlet weak var readingAmountTitleLabel: UILabel!
    @IBOutlet weak var commentTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        picker.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = "독서 일지"
    }
    
    @objc func postDiary(sender: UIBarButtonItem) {
        // 챌린지 달성 여부에 따른 화면 분기 필요
//        let writeReviewVC = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(withIdentifier: "writeReviewVC") as! ReviewWrittenViewController
//        self.navigationController?.pushViewController(writeReviewVC, animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        addImageAlertAction()
    }
    
    @IBAction func popImage(_ sender: UIButton) {
        reviewImageHeight.constant = 0
        reviewImagePopButton.isHidden = true
        pickedImage = nil
    }
    @IBAction func pageSelect(_ sender: UIButton) {
        let inputReadingStatusVC = self.storyboard?.instantiateViewController(withIdentifier: InputReadingStatusPopupViewController.storyobardId)
        inputReadingStatusVC?.modalTransitionStyle = .crossDissolve
        self.present(inputReadingStatusVC!, animated: true, completion: nil)
    }
    
    @IBAction func percentSelect(_ sender: UIButton) {
        let inputReadingPercentVC = self.storyboard?.instantiateViewController(withIdentifier: InputReadingPercentPopupViewController.storyobardId)
        inputReadingPercentVC?.modalTransitionStyle = .crossDissolve
        self.present(inputReadingPercentVC!, animated: true, completion: nil)
    }
    
    @IBAction func makePublicPost(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "challengeCompletionVC") as! ChallengeCompletionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func makePrivatePost(_ sender: UIButton) {
        print("pageSelect")

    }
    
    @IBAction func postDiary(_ sender: UIButton) {
        print("pageSelect")

    }

    private func setupUI() {
        setNavBar()
        bookInfoView.layer.addBorder([.bottom], color: .middlegrey2, width: 0.5)
        readingStatusButton.makeRoundedTagButtnon("읽는 중", titleColor: .middlegrey1, borderColor: UIColor.middlegrey1.cgColor, backgroundColor: .white)
        totalReadingTimeButton.makeRoundedTagButtnon(" 00분", titleColor: .middlegrey1, borderColor: UIColor.lightgrey1.cgColor, backgroundColor: .lightgrey1)
        postDairyButton.makeRoundedButtnon("완료", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        readingPageInputButton.makeSmallRoundedButtnon("00p", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        readingPercentInputButton.makeSmallRoundedButtnon("00%", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)
        publicPostButton.makeSmallRoundedButtnon("전체 공개", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
        privatePostButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        reviewImagePopButton.isHidden = true
        bookTitleLabel.textColor = .darkgrey
        bookAuthorLabel.textColor = .darkgrey
        commentTextField.contentVerticalAlignment = .top
        commentTextField.textColor = .charcoal
        commentTextField.backgroundColor = .lightgrey1
        commentLengthLabel.textColor = .darkgrey
        
    }
    
    private func setNavBar() {
        self.navigationItem.title = "독서 일지"
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(postDiary(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .main
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}



extension DaillyReadingWritenViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            DispatchQueue.main.async {
                self.reviewImageHeight.constant = 75
                self.pickedImage = image
                self.reviewImagePopButton.isHidden = false
                self.reviewImageView.image = image
            }
         }
        dismiss(animated: true, completion: nil)
     }
}

extension DaillyReadingWritenViewController {
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
    
    @objc func open() {
        addImageAlertAction()
    }
    
    func addImageAlertAction() {
        let alert =  UIAlertController(title: "이미지 선택", message: "일지에 첨부할 이미지를 선택해주세요.", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "갤러리 선택", style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "사진 촬영", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
