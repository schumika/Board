//
//  BoardCollectionView.swift
//  Board
//
//  Created by Anca Julean on 06/07/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class BoardCollectionView: UICollectionView {

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        // For use in code
        super.init(frame: frame, collectionViewLayout: layout)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        self.backgroundColor = UIColor.blue
    }

}
