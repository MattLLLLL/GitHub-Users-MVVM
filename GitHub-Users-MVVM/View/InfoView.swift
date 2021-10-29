//
//  Info.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class InfoView: UITableViewController {
    
    let viewModel = UserViewModel()
    
    var login: String? {
        didSet {
            viewModel.getUserInfo(login: login ?? "")
        }
    }
    
    var data: [[String:String]] = [[:]]
    let tableCellId = "tableCellId"
    
    let closeBut: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    let avatar: CacheImage = {
        let imageView = CacheImage()
        imageView.layer.cornerRadius = 150 / 2
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
        tableView.register(InfoCell.self, forCellReuseIdentifier: tableCellId)
        initViewModel()
    }
    
    private func initViewModel() {
        viewModel.userInfo.bind { [weak self] _ in
            if let $self = self {
                let info = $self.viewModel.userInfo.value
                
                $self.data.append(["person.fill":info?.name ?? ""])
                $self.data.append(["location.fill":info?.location ?? ""])
                $self.data.append(["link":info?.blog ?? ""])
                $self.data.remove(at: 0)
                
                DispatchQueue.main.async {
                    $self.avatar.loadImage(url: info?.avatar_url ?? "")
                    $self.nameLabel.text = info?.name
                    $self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! InfoCell
        cell.imageView?.image = UIImage(systemName: data[indexPath.row].first?.key ?? "")
        cell.subLabel.text = data[indexPath.row].first?.value
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let subView = UIView()
        subView.addSubview(closeBut)
        subView.addSubview(avatar)
        subView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            closeBut.topAnchor.constraint(equalTo: subView.topAnchor, constant: 18),
            closeBut.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 18),
            
            avatar.centerXAnchor.constraint(equalTo: subView.centerXAnchor, constant: 0),
            avatar.centerYAnchor.constraint(equalTo: subView.centerYAnchor, constant: 0),
            avatar.heightAnchor.constraint(equalToConstant: 150),
            avatar.widthAnchor.constraint(equalToConstant: 150),
            
            nameLabel.centerXAnchor.constraint(equalTo: subView.centerXAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 20)
        ])
        return subView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

