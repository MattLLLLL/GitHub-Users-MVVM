//
//  Main.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

class MainView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let CellId = "CellId"
    let items = [ITEM_TYPE.USER, ITEM_TYPE.MINE]
    
    
    lazy var user: UserView = {
        let u = UserView()
        u.delegate = self
        return u
    }()
    
    let mine: MineView = {
       let m = MineView()
        return m
    }()
    
    lazy var customTabBar: CustomTabBar = {
        let view = CustomTabBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.didSelectItem = { [ weak self ] index in
            if let $self = self {
                $self.movePage(index: index)
            }
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        view.addSubview(customTabBar)
        NSLayoutConstraint.activate([
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 2),
            customTabBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -2),
            customTabBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 2),
            customTabBar.heightAnchor.constraint(equalToConstant: 80),
            
        ])
    }
    
    private func movePage(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellId)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath)
  
        switch items[indexPath.row] {
        case .USER:
            cell.backgroundView = user
        case .MINE:
            cell.backgroundView = mine.view
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        customTabBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension MainView: UserDelegate {
    
    func didSelectCell(_ login: String) {
        DispatchQueue.main.async {
            let info = InfoView()
            info.login = login
            self.present(info, animated: true, completion: nil)
        }
    }
    
}
