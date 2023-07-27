//
//  LoadableCollectionViewCell.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 26.07.2023.
//

import UIKit

open class LoadableCollectionViewCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    open func setup() {
    }
}
