//
//  ViewController.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import UIKit

protocol UserDelegate {
    func didSelectCell(_ login: String)
}

class UserView: UIView {
    
    let userCellId = "UserCellId"
    var isPaging = false
    
    let viewModel = UserViewModel()
    var delegate: UserDelegate?
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(UserCell.self, forCellReuseIdentifier: userCellId)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let activityView: UIView = {
        let activity = UIActivityIndicatorView()
        activity.frame.size = CGSize(width: 0, height: 80)
        activity.startAnimating()
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initLayout()
        initViewModel()
        viewModel.getUsers(page: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    private func initViewModel() {
        viewModel.users.bind { [ weak self ] _ in
            if let $self = self {
                DispatchQueue.main.async {
                    $self.isPaging = false
                    $self.tableView.tableFooterView = nil
                    $self.tableView.reloadData()
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentSize.height - scrollView.frame.height) < 0 { return }
        if (scrollView.contentOffset.y + 150 ) > (scrollView.contentSize.height - scrollView.frame.height) {
            if let count = viewModel.users.value?.count , !isPaging {
                isPaging = true
                tableView.tableFooterView = activityView
                viewModel.getUsers(page: count + 15)
            }
        }
    }
}

extension UserView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath) as! UserCell
        cell.user = viewModel.users.value?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = viewModel.users.value?[indexPath.row], let login = user.login {
            delegate?.didSelectCell(login)
        }
    }
   
}
