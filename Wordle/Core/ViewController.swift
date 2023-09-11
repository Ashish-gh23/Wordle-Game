//
//  ViewController.swift
//  Wordle
//
//  Created by Ashish Ranjan on 05/09/23.
//

import UIKit

class ViewController: UIViewController, KeyboardViewControllerDelegate, BoardViewControllerDataSource {
    
    let boardVC = BoardViewController()
    let keyboardVC = KeyboardViewController()
    
    let answers = ["lying", "tough", "later", "asset", "treat"]
    var answer = ""
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        answer = answers.randomElement() ?? "float"
        addChildren()
    }
    
    func addChildren() {
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.dataSource = self
        view.addSubview(boardVC.view)
        
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardVC.delegate = self
        view.addSubview(keyboardVC.view)
        
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor, constant: 0),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
        ])
    }
}

extension ViewController {
    func keyboradViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        boardVC.reloadData()
    }
    
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let answerArray = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.item],
              answerArray.contains(letter) else {
            return nil
        }
        
        let count = guesses[indexPath.section].compactMap({$0}).count
        guard count == 5 else {
            return nil
        }
        
        
        if answerArray[indexPath.item] == letter {
            return .systemGreen
        }
        return .systemOrange
        
    }
}

