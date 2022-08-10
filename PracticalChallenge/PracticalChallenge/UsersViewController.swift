//
//  ViewController.swift
//  PracticalChallenge
//
//  Created by Deane Karsten on 10/08/22.
//

import UIKit

class UsersViewController: UIViewController {

    let usersTableView = UITableView()
    
    enum TableSection: Int {
        case userList
        case loader
    }
    
    private let pageLimit = 25
    private var currentPage: Int? = nil
    
    
    private var users = [User]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.usersTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
        fetchData()
    }
}


extension UsersViewController {
    private func fetchData(completed: ((Bool) -> Void)? = nil) {
        RandomUserAPIManager.shared.getUsers(page: currentPage, results: pageLimit) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users.append(contentsOf: users)
                //TODO: self?.currentPage = self?.currentPage ?? 0 + 1
                //self?.users = users
                completed?(true)
            case .failure(let error):
                print(error.localizedDescription)
                completed?(false)
            }
        }
    }
}

// Styles and Layouts
extension UsersViewController {
    private func style() {
        view.backgroundColor = .red
        view.addSubview(usersTableView)
        
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
       
        
        
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        //let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        //cell.textLabel?.text = users[indexPath.row]
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UserCell")
        //let user = users[indexPath.row]
        //cell.textLabel?.text = user.gender
        
        switch section {
        case .userList:
            let user = users[indexPath.row]
            cell.textLabel?.text = user.gender
        case .loader:
            cell.textLabel?.text = "Loading..."
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !users.isEmpty else { return }

        if section == .loader {
            print("load new data..")
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



