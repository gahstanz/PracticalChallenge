//
//  UsersViewController.swift
//  PracticalChallenge
//
//  Created by Deane Karsten on 11/08/22.
//

import UIKit

class UsersViewController: UIViewController {

    let usersTableView = UITableView()
    
    let genderPlaceHolderImage = UIImage(named: "missingGenderIcon.png")
    let genderFemaleImage = UIImage(named: "femaleIcon.png")
    let genderMaleImage = UIImage(named: "maleIcon.png")
    
    let thumbnailPlaceHolderImage = UIImage(named: "userPlaceHolder.png")
    
    enum TableSection: Int {
        case userList
        case loader
    }
    
    private let pageLimit = 10
    private var currentPage: Int? = 1
    
    
    private var users = [User]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.usersTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
        layouts()
        setUpNavigation()
        fetchData()
    }
    
    func setUpNavigation() {
        navigationItem.title = "Users"
        navigationItem.setHidesBackButton(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.white,
            NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)
        ]
    }
}

// Styles and Layouts
extension UsersViewController {
    private func styles() {
        view.backgroundColor = .systemOrange
        view.addSubview(usersTableView)
        
        // userTableView
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.rowHeight = 75
        usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
       
        
        
    }
    
    private func layouts() {
        
        // userTableView
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

// Fetch Data
extension UsersViewController {
    private func fetchData(completed: ((Bool) -> Void)? = nil) {
        RandomUserAPIManager.shared.getUsers(page: currentPage, results: pageLimit) { [weak self] result in
            switch result {
            case .success(let users):
                
                self?.users.append(contentsOf: users)
                
                guard let pageNumber = self?.currentPage else {
                    return
                }
                self?.currentPage = (pageNumber + 1)

                completed?(true)
            case .failure(let error):
                print(error.localizedDescription)
                completed?(false)
            }
        }
    }
}


// Tableview
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return users.count
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .userList:
            return users.count
        case .loader:
            return users.count >= pageLimit ? 1 : 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        
        //let userDetailNavigationController = UINavigationController(rootViewController: userDetailViewController)
        let userDetailViewController = UserDetailViewController(user: user)
        
        //userDetailNavigationController.modalPresentationStyle = .fullScreen
        //present(userDetailNavigationController, animated: true, completion: nil)
        
        userDetailViewController.modalPresentationStyle = .popover
        present(userDetailViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        
        
        switch section {
        case .userList:
            let user = users[indexPath.row]

            cell.titleLabel.text = user.name.title
            cell.nameLabel.text = "\(user.name.first) \(user.name.last)"
            if user.gender == "male" {
                cell.genderImageView.image = genderMaleImage
            } else if user.gender == "female" {
                cell.genderImageView.image = genderFemaleImage
            } else {
                cell.genderImageView.image = genderPlaceHolderImage
            }
            
            RandomUserAPIManager.shared.getImageByURL(imageURL: user.picture.thumbnail, imageView: cell.thumbnailImageView)
            
            
            // TODO: Add thumbnail image
            cell.thumbnailImageView.image = thumbnailPlaceHolderImage
        case .loader:
            cell.nameLabel.text = "Loading..."
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !users.isEmpty else { return }

        if section == .loader {
            print("loading new data..")
            fetchData { [weak self] success in
                if !success {
                    self?.hideBottomLoader()
                }
            }
        }
    }
    
    private func hideBottomLoader() {
            DispatchQueue.main.async {
                let lastListIndexPath = IndexPath(row: self.users.count - 1, section: TableSection.userList.rawValue)
                self.usersTableView.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
        }
    }
    
    
}





