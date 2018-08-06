//
//  WritingViewController.swift
//  Mosaic_iOS
//
//  Created by 이광용 on 2018. 7. 20..
//  Copyright © 2018년 Zedd. All rights reserved.
//

import UIKit

//https://stackoverflow.com/questions/46282987/iphone-x-how-to-handle-view-controller-inputaccessoryview
//http://ahbou.org/post/165762292157/iphone-x-inputaccessoryview-fix
//https://medium.com/code-brew-com/dynamic-height-of-accessory-view-in-ios-bf0c2efe6da8
class WritingViewController: ViewController, KeyboardControlService {
    //MARK: - Property
    //MARK: UI
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var accessoryView: AccessoryView!
    //MARK: Constraint
    @IBOutlet weak var imageCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var accessoryViewHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var accessoryViewBottomConstraint: NSLayoutConstraint!
    //MARK: Stored or Computed
    var images: [UIImage] = [] {
        didSet {
//            showImageCollectionView(!images.isEmpty)
        }
    }
    
    //MARK: - Method
    //MARK: Initialize
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpKeyboard()
        setUpAccessoryView()
        setUpImageCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAccessoryViewContraint(height: AccessoryView.height + bottomInset, bottom: 0)
    }
    
    deinit {
        self.removeKeyboardControl()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //MARK: Set Up Keyboard
    func setUpKeyboard() {
        self.setKeyboardControl(willShow: { [weak self] (rect, duration) in
            guard let `self` = self else {return}
            UIView.animate(withDuration: duration, animations: {
                self.setAccessoryViewContraint(height: AccessoryView.height, bottom: rect.height)
            })
        }, willHide: { [weak self] (rect, duration) in
            guard let `self` = self else {return}
            UIView.animate(withDuration: duration, animations: {
                self.setAccessoryViewContraint(height: AccessoryView.height + bottomInset, bottom: 0)
            })
        })
    }
    
    //MARK: Set Up AccessoryView
    func setUpAccessoryView() {
        self.accessoryView.addTarget(self, selector: #selector(showImagePicker))
    }
    
    func setAccessoryViewContraint(height: CGFloat, bottom: CGFloat) {
        self.accessoryViewHeightConstaint.constant = height
        self.accessoryViewBottomConstraint.constant =  bottom
        self.view.layoutIfNeeded()
    }
    
    //MARK: Set Up ImageCollectionView
    func setUpImageCollectionView() {
        self.imageCollectionView.setUp(target: self, cell: ImageCollectionViewCell.self)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.imageCollectionView.collectionViewLayout = layout
    }
    
    func showImageCollectionView(_ value: Bool) {
        UIView.animate(withDuration: 1) {
            self.imageCollectionViewHeightConstraint.constant = value ? 60.0 : 0.0
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Action
    @objc func showImagePicker() {
        showImagePickerController()
    }
}

//MARK: - Extension
//MARK: ImagePickerControllerPresentable
extension WritingViewController: ImagePickerControllerPresentable {
    func imagePickerController(_ picker: UIImagePickerController, selectedImage image: UIImage) {
        self.images.append(image)
        self.imageCollectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension WritingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.images.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
}
