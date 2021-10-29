//
//  CustomTabBar.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class CustomTabBar: UIView {
    
    let ColId = "ColId"
    let images = ["person.fill", "info.circle.fill"]
    
    var didSelectItem: ((Int) -> ())?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .init(), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(BarItemCell.self, forCellWithReuseIdentifier: ColId)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.borderColor = UIColor.systemGray.cgColor
        collection.layer.borderWidth = 0.5
        collection.backgroundColor = .white
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTabBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColId, for: indexPath) as! BarItemCell
        cell.imageView.image = UIImage(systemName: images[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
