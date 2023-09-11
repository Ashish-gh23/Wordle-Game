//
//  BoardViewController.swift
//  Wordle
//
//  Created by Ashish Ranjan on 05/09/23.
//

import UIKit

protocol BoardViewControllerDataSource: AnyObject {
    var currentGuesses: [[Character?]] { get }
    
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class BoardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var dataSource: BoardViewControllerDataSource?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        ])
    }
    
    func reloadData() {
        collectionView.reloadData()
    }

}

extension BoardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.currentGuesses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = dataSource?.currentGuesses ?? []
        return guesses[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        cell.backgroundColor = dataSource?.boxColor(at: indexPath)
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        cell.layer.borderWidth = 1
        
        let guesses = dataSource?.currentGuesses ?? []
        if let letter = guesses[indexPath.section][indexPath.item] {
            cell.configure(with: letter)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 2 * 10
        let size: CGFloat = (collectionView.frame.size.width - margin) / 5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
