////
////  PhotoReviewController.swift
////  kokopokePJ
////
////  Created by 金濱利来 on 2020/01/22.
////  Copyright © 2020 Saki Nakayama. All rights reserved.
////
//
//import UIKit
//import FirebaseStorage
//import FirebaseFirestore
//
//class PhotoReviewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet weak var imageView: UIImageView!
//    let imagePicker = UIImagePickerController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imagePicker.delegate = self
//    }
//
//    @IBAction func presentImagePicker(_ sender: Any) {
//        imagePicker.allowsEditing = true //画像の切り抜きが出来るようになります。
//        imagePicker.sourceType = .photoLibrary //画像ライブラリを呼び出します
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    @IBAction func startUpload(_ sender: Any) {
//        saveToFireStorage()
//    }
//
//    fileprivate func upload(completed: @escaping(_ url: String?) -> Void) {
//        let date = NSDate()
//        let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
//        let storageRef = Storage.storage().reference().child("images").child("\(currentTimeStampInSecond).jpg")
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpg"
//        if let uploadData = self.imageView.image?.jpegData(compressionQuality: 0.9) {
//            storageRef.putData(uploadData, metadata: metaData) { (metadata , error) in
//                if error != nil {
//                    print("error: \(error?.localizedDescription)")
//                }
//                storageRef.downloadURL(completion: { (url, error) in
//                    if error != nil {
//                        print("error: \(error?.localizedDescription)")
//                    }
//                    completed("url: \(url?.absoluteString)")
//                })
//            }
//        }
//    }
//
//    fileprivate func saveToFireStore(){
//        var data: [String : Any] = [:]
//        upload(){ url in
//            guard let url = url else {return }
//            data["image"] = url
//            Firestore.firestore().collection("images").document().setData(data){ error in
//                if error != nil {
//                    print("error: \(error?.localizedDescription)")
//                }
//                print("image saved!")
//            }
//        }
//    }
//}
//extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//}
