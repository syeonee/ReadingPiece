//
//  DailyDiaryWrittenViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/06.
//

import UIKit
protocol ReadingStatusDelegate {
    func setReadingPage(_ page: Int)
    func setReadingPercent(_ percent: Int)
}
class DaillyReadingWritenViewController: UIViewController {
    let cellId = ReviewImageCell.identifier
    let picker = UIImagePickerController()
    var pickedImage : UIImage?
    var readingPercent: Int = 0
    var readingPage: Int = 0
    var isPublic: Bool? {
        didSet {
            isValidatePost()
        }
    }

    @IBOutlet weak var commentTextView: UITextView!
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
        commentTextView.delegate = self
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
        guard let inputReadingStatusVC = self.storyboard?.instantiateViewController(withIdentifier: InputReadingStatusPopupViewController.storyobardId) as? InputReadingStatusPopupViewController else { return }
        inputReadingStatusVC.readingStatusDelegate = self
        inputReadingStatusVC.modalTransitionStyle = .crossDissolve
        self.present(inputReadingStatusVC, animated: true, completion: nil)
    }
    
    @IBAction func percentSelect(_ sender: UIButton) {
        guard let inputReadingPercentVC = self.storyboard?.instantiateViewController(withIdentifier: InputReadingPercentPopupViewController.storyobardId) as? InputReadingPercentPopupViewController else { return }
        inputReadingPercentVC.readingStatusDelegate = self
        inputReadingPercentVC.modalTransitionStyle = .crossDissolve
        self.present(inputReadingPercentVC, animated: true, completion: nil)
    }
    
    @IBAction func makePublicPost(_ sender: UIButton) {
        isPublic = true
        DispatchQueue.main.async {
            self.publicPostButton.makeSmallRoundedButtnon("전체 공개", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
            self.privatePostButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        }
    }
        
    @IBAction func makePrivatePost(_ sender: UIButton) {
        isPublic = false
        DispatchQueue.main.async {
            self.publicPostButton.makeSmallRoundedButtnon("전체 공개", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
            self.privatePostButton.makeSmallRoundedButtnon("나만 보기", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
        }
    }
    
    @IBAction func postDiary(_ sender: UIButton) {
        if isValidatePost() == true {
            // API 호출
        }
    }

    private func setupUI() {
        setNavBar()
        bookInfoView.layer.addBorder([.bottom], color: .middlegrey2, width: 0.5)
        readingStatusButton.makeRoundedTagButtnon("읽는 중", titleColor: .middlegrey1, borderColor: UIColor.middlegrey1.cgColor, backgroundColor: .white)
        totalReadingTimeButton.makeRoundedTagButtnon(" 00분", titleColor: .middlegrey1, borderColor: UIColor.lightgrey1.cgColor, backgroundColor: .lightgrey1)
        postDairyButton.makeRoundedButtnon("완료", titleColor: .darkgrey, borderColor: UIColor.fillDisabled.cgColor, backgroundColor: .fillDisabled)
        readingPageInputButton.makeSmallRoundedButtnon("00p", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        readingPercentInputButton.makeSmallRoundedButtnon("00%", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)
        publicPostButton.makeSmallRoundedButtnon("전체 공개", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
        privatePostButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        reviewImagePopButton.isHidden = true
        bookTitleLabel.textColor = .darkgrey
        bookAuthorLabel.textColor = .darkgrey
        commentTextView.textColor = .charcoal
        commentTextView.backgroundColor = .lightgrey1
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
    
    func isValidatePost() -> Bool {
        var validationResult = false
        if self.commentTextView.text.count > 1 && self.readingPage > 1 && self.readingPercent > 1 && isPublic != nil {
            validationResult = true
            DispatchQueue.main.async {
                self.postDairyButton.makeRoundedButtnon("완료", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
            }
        } else {
            DispatchQueue.main.async {
                self.postDairyButton.makeRoundedButtnon("완료", titleColor: .darkgrey, borderColor: UIColor.fillDisabled.cgColor, backgroundColor: .fillDisabled)
            }
        }
        
        return validationResult
    }
}


extension DaillyReadingWritenViewController: ReadingStatusDelegate {
    func setReadingPage(_ page: Int) {
        print("LOG - 읽은 페이지 수 저장 완료")
        readingPage = page
        readingPageInputButton.setTitle("\(page) p", for: .normal)
    }
    
    func setReadingPercent(_ percent: Int) {
        print("LOG - 읽은 % 저장 완료")
        readingPercent = percent
        readingPercentInputButton.setTitle("\(percent) %", for: .normal)
    }
}

extension DaillyReadingWritenViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if let char = text.cString(using: String.Encoding.utf8) {
            commentLengthLabel.text = "\(textView.text.count) / 100"
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textView.text!.count < 100 else { return false }
        return true

    }
    
    // UITextView Placeholder 설정
    func textViewSetupView() {
        if commentTextView.text == "기억에 남는 문구, 소감을 기록하세요!" {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.black
        } else if commentTextView.text == "" {
            commentTextView.text = "기억에 남는 문구, 소감을 기록하세요!"
            commentTextView.textColor = .middlegrey1
        }
    }
    
    // 편집이 시작될때
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    // 편집이 종료될때
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text == "" {
            textViewSetupView()
        }
    }
}

extension DaillyReadingWritenViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            setSelectedImage(image)
         }
        dismiss(animated: true, completion: nil)
     }
    
    func setSelectedImage(_ img: UIImage) {
        DispatchQueue.main.async {
            self.reviewImageHeight.constant = 75
            self.pickedImage = img
            self.reviewImagePopButton.isHidden = false
            self.reviewImageView.image = img
        }
    }
}

// 카메라, 갤러리 이미지 관련 함수 모음
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
