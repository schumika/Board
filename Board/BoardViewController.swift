//
//  BoardViewController.swift
//  Board
//
//  Created by Anca Julean on 14/09/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        //collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
        cell.scoreLabel.text = "2"
        return cell
    }
}
