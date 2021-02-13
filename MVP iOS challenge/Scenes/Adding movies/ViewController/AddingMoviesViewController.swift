//
//  AddingMoviesViewController.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/19/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class AddingMoviesViewController: UIViewController, AddingMoviesView {
    
     var presenter: AddingMoviesPresenter?
    
    // MARK: VIEWS
    private  lazy var imagePicker: UIImagePickerController = {
        let imagerPicker = UIImagePickerController()
        imagerPicker.sourceType = .savedPhotosAlbum
        imagerPicker.allowsEditing = false
        return imagerPicker
    }()
    
    private lazy var addImageButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "Poster"), for: .normal)
        button.addTarget(self, action: #selector(addImageButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleTextField: UITextField = {
        let textfield  = UITextField(frame: .zero)
        textfield.layer.borderWidth = 0
        textfield.placeholder = "Title"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var overviewTextField: UITextField = {
        let textfield  = UITextField(frame: .zero)
        textfield.layer.borderWidth = 0
        textfield.placeholder = "Overview"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var dateTextField: UITextField = {
        let textfield  = UITextField(frame: .zero)
        textfield.layer.borderWidth = 0
        textfield.placeholder = "Date"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var textFieldsStackView:UIStackView = {
        let stackVIew = UIStackView()
        stackVIew.axis = .vertical
        stackVIew.alignment = .fill
        stackVIew.distribution = .fill
        stackVIew.spacing = 40
        stackVIew.translatesAutoresizingMaskIntoConstraints = false
        return stackVIew
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var overViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separator2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separator3: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var movieDatePicker: UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        return datepicker
    }()
    
    private lazy var addMovieButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Add movie", for: .normal)
        button.addTarget(self, action: #selector(addMovieButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: ViewControllerLfeCycle
    override func viewDidLoad() {
        addSubViews()
        allConstrains()
        self.view.backgroundColor = .white
    }
    
    //MARK: Constrains
    func addImageButtonConstrains(){
        addImageButton.heightAnchor.constraint(equalToConstant: 130).isActive = true
        addImageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    func textFieldsConstraints(){
        titleTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        overviewTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func separatorConstrains(){
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator3.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func textFieldsStacksConstraints() {
        textFieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textFieldsStackView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 50).isActive = true
    }
    func addMovieButtonConstraints() {
        addMovieButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20).isActive = true
        addMovieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addMovieButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        addMovieButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    func allConstrains(){
        addImageButtonConstrains()
        separatorConstrains()
        textFieldsConstraints()
        textFieldsStacksConstraints()
        addMovieButtonConstraints()
    }
    
    //MARK: ADDING SUBVIEWS
    func addSubViews(){
        view.addSubview(addImageButton)
        overViewStackView.addArrangedSubview(overviewTextField)
        overViewStackView.addArrangedSubview(separator2)
        titleStackView.addArrangedSubview(titleTextField)
        titleStackView.addArrangedSubview(separator)
        dateStackView.addArrangedSubview(dateTextField)
        dateStackView.addArrangedSubview(separator3)
        textFieldsStackView.addArrangedSubview(titleStackView)
        textFieldsStackView.addArrangedSubview(overViewStackView)
        textFieldsStackView.addArrangedSubview(dateStackView)
        view.addSubview(addMovieButton)
        view.addSubview(textFieldsStackView)
        addDatePicker()
    }
    
    func addDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = movieDatePicker
    }
    
    //MARK:-Actions:
    @objc  func addImageButtonDidTap(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func addMovieButtonDidTap (){
        guard let title = titleTextField.text, !title.isEmpty,
            let overview = overviewTextField.text, !overview.isEmpty,
            let date = dateTextField.text, !date.isEmpty,
            let image = addImageButton.currentImage
            else {return}
        presenter?.addMovieButtonDidTap(title: title, overview: overview, date: date, image: image)
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        dateTextField.text = formatter.string(from: movieDatePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

extension AddingMoviesViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            addImageButton.setImage(image, for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
}







