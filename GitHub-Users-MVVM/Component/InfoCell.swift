//
//  InfoCell.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class InfoCell: UITableViewCell {
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(icon)
        addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            
            subLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            subLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
