//
//  CarCell.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 26.07.2023.
//

import UIKit

final class CarCell: LoadableCollectionViewCell {
    private var bag = CancelBag()
    
    private lazy var photoImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .lightGray
    }
    
    // MARK: - Inherited Methods
    override func setup() {
        super.setup()
        
        [photoImageView].forEach {
            addSubview($0)
        }
        
        photoImageView.layer.cornerRadius = 0
        photoImageView.clipsToBounds = true
        
        layoutConstraints()
        bind()
    }
    
    private func bind() {}
    
    func configure(_ image: UIImage) {
        photoImageView.image = image
    }
    
    // MARK: - layoutConstraints
    private func layoutConstraints() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
