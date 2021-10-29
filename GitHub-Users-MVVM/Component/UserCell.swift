//
//  UserCell.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    
    var user: Users? {
        didSet {
            if let data = user {
                avatar.loadImage(url: data.avatar_url ?? "")
                loginLabel.text = data.login
                typeLabel.text = data.type
            }
        }
    }
    
    lazy var mainHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [avatar, subVStack])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var subVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginLabel, typeLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    let avatar: CacheImage = {
        let imageView = CacheImage()
        imageView.layer.cornerRadius = 60 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let loginLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(mainHStack)
        
        NSLayoutConstraint.activate([
            
            avatar.widthAnchor.constraint(equalToConstant: 60),
            mainHStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainHStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            mainHStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
