//
//  UserDetailViewController.swift
//  PracticalChallenge
//
//  Created by Deane Karsten on 11/08/22.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    private let user: User

    let profileImageView = UIImageView()
    let userNameLabel = UILabel()
    let genderLabel = UILabel()
    let ageLabel = UILabel()
    let emailLabel = UILabel()
    let mobileLabel = UILabel()
    
    let stackView = UIStackView()

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styles()
        layouts()
        setFields()
    }
    
    func setFields() {
        RandomUserAPIManager.shared.getImageByURL(imageURL: user.picture.large, imageView: profileImageView)
        self.userNameLabel.text = "\(self.user.name.title) \(self.user.name.first) \(self.user.name.last)"
        self.genderLabel.text = "Gender: \(self.user.gender)"
        self.ageLabel.text = "Age: \(self.user.dob.age.description)"
        self.emailLabel.text = "Email: \(self.user.email)"
        self.mobileLabel.text = "Mobile: \(self.user.cell)"
    }

}

// Styles and Layouts
extension UserDetailViewController {
    func styles() {
        view.backgroundColor = .systemGray6

        
        // profileImageView
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.borderColor = UIColor.systemTeal.cgColor
        profileImageView.layer.masksToBounds = false
        profileImageView.clipsToBounds = true
        
        
        //userNameLabel
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textAlignment = .center
        userNameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        userNameLabel.adjustsFontForContentSizeCategory = true
        //userNameLabel.text = "Mr John Doe"
        userNameLabel.textColor = .systemGray
        userNameLabel.backgroundColor = .systemTeal
        userNameLabel.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.textAlignment = .center
        genderLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.textAlignment = .center
        ageLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        mobileLabel.translatesAutoresizingMaskIntoConstraints = false
        mobileLabel.textAlignment = .center
        mobileLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    }
    
    func layouts() {
        view.addSubview(profileImageView)
        view.addSubview(userNameLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(mobileLabel)
        
        
        // profileImageView
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor )
        ])
        
        // userNameLabel
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    
    }
}
