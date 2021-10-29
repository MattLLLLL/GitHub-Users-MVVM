//
//  ManeCell.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class MineCell: UITableViewCell {
    
    var info: UserInfo? {
        didSet {
            if let i = info {
                nameLabel.text = i.name ?? ""
                loginLabel.text = i.login ?? ""
                followeLabel.icon = UIImage(systemName: "person.3.fill")
                followeLabel.text = "\(i.followers ?? 0) followers ・ \(i.following ?? 0) following"
                
                emailLabel.icon = UIImage(systemName: "envelope.fill")
                emailLabel.text = i.email ?? ""
            }
        }
    }
    
    lazy var mainVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [subVStack])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var subVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, loginLabel, followeLabel, emailLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    
    let loginLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()
    
    let followeLabel: IconLabel = {
        let iconLabel = IconLabel()
        return iconLabel
    }()
    
    let emailLabel: IconLabel = {
        let iconLabel = IconLabel()
        return iconLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(mainVStack)
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainVStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            mainVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
