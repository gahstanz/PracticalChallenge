//
//  UserTableViewCell.swift
//  PracticalChallenge
//
//  Created by Deane Karsten on 11/08/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let thumbnailImageView = UIImageView()
    let genderImageView = UIImageView()
    
    let containerView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(thumbnailImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(nameLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(genderImageView)
        
        styles()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Styles and Layouts
extension UserTableViewCell {
    func styles() {
        
        // thumbnailImageView
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        thumbnailImageView.layer.cornerRadius = 35
        thumbnailImageView.clipsToBounds = true
        
        
        // titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor =  .systemGray4
        titleLabel.clipsToBounds = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // nameLabel
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .systemGray
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // genderImageView
        genderImageView.contentMode = .scaleAspectFill
        genderImageView.translatesAutoresizingMaskIntoConstraints = false
        genderImageView.clipsToBounds = true
        
        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        
        
    }
    
    func layout() {
        
        // thumbnailImageView
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 70),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        
        // containerView
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo:self.thumbnailImageView.trailingAnchor, constant:10),
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10),
            containerView.heightAnchor.constraint(equalToConstant:40)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor)
        ])
        
        // genderImageView
        NSLayoutConstraint.activate([
            genderImageView.widthAnchor.constraint(equalToConstant:26),
            genderImageView.heightAnchor.constraint(equalToConstant:26),
            genderImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20),
            genderImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor)
        ])
        
        
        

    }
    
}


