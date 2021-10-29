//
//  IconLabel.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class IconLabel: UIView {
    
    var icon: UIImage? {
        didSet {
            imageView.image = icon
        }
    }
    var text: String = "" {
        didSet {
            subLabel.text = text
        }
    }
    
    private let imageView: UIImageView = {
       let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = .systemGray
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let subLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            
            subLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12),
            subLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
