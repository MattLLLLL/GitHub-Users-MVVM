//
//  Mine.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import UIKit

class MineView: UITableViewController {
    
   
    let mineCellId = "mineCellId"
    let viewModel = UserViewModel()
    
    let avatar: CacheImage = {
        let imageView = CacheImage()
        imageView.layer.cornerRadius = 100 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MineCell.self, forCellReuseIdentifier: mineCellId)
        tableView.separatorStyle = .none
        initViewModel()
        
        viewModel.getUserInfo(login: "MattLLLLL")
    }
    
    private func initViewModel() {
        viewModel.userInfo.bind { [weak self] _ in
            if let $self = self {
                DispatchQueue.main.async {
                    $self.avatar.loadImage(url: $self.viewModel.userInfo.value?.avatar_url ?? "")
                    $self.tableView.reloadData()
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCellId, for: indexPath) as! MineCell
        cell.info = viewModel.userInfo.value
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .black
        let backgroundView = UIView()
        backgroundView.addSubview(subView)
        subView.addSubview(avatar)
        
        NSLayoutConstraint.activate([
            subView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.8),
            subView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 1.0),
            avatar.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 32),
            avatar.centerYAnchor.constraint(equalTo: subView.bottomAnchor, constant: 0),
            avatar.heightAnchor.constraint(equalToConstant: 100),
            avatar.widthAnchor.constraint(equalToConstant: 100)
        ])
        return backgroundView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
}
