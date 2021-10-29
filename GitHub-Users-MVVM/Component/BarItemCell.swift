//
//  BarItemCell.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class BarItemCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .black : .systemGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .black : .systemGray
        }
    }
    
    let imageView: UIImageView = {
       let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = .systemGray
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 26),
            imageView.widthAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
