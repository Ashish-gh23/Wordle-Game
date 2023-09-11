//
//  KeyboardViewController.swift
//  Wordle
//
//  Created by Ashish Ranjan on 05/09/23.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject {
    func keyboradViewController(_ vc: KeyboardViewController, didTapKey letter: Character)
}
class KeyboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let letters = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
    private var keys: [[Character]] = []
    
    weak var delegate: KeyboardViewControllerDelegate?
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        for row in letters {
            let chars = Array(row)
            keys.append(chars)
        }
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        ])
        
    }

}

extension KeyboardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        let letter = keys[indexPath.section][indexPath.item]
        cell.configure(with: letter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 2 * 10
        let size: CGFloat = (collectionView.frame.size.width - margin) / 10
        return CGSize(width: size, height: size * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin: CGFloat = 2 * 10
        let size: CGFloat = (collectionView.frame.size.width - margin) / 10
        
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))
        
        let inset: CGFloat = (collectionView.frame.size.width - count * size - 2 * count) / 2
        let left = inset
        let right = inset
        
        
        return UIEdgeInsets(top: 2, left: left, bottom: 2, right: right)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let letter = keys[indexPath.section][indexPath.item]
        delegate?.keyboradViewController(self, didTapKey: letter)
    }
    
}
