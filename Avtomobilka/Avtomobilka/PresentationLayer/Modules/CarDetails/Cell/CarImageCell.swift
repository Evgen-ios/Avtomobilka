//
//  CarImageCell.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 28.07.2023.
//

import UIKit

final class CarImageCell: LoadableCollectionViewCell {
    private var bag = CancelBag()
    private var model: ImageModel!
    
    // MARK: - Properties
    private lazy var photoImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    // MARK: - Inherited Methods
    override func setup() {
        super.setup()
        
        [photoImageView].forEach {
            addSubview($0)
        }
        
        photoImageView.layer.cornerRadius = 16
        photoImageView.clipsToBounds = true
        
        layoutConstraints()
        bind()
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
        super.prepareForReuse()
    }
    
    private func bind() {}
    
    func configure(_ model: ImageModel) {
        self.model = model
        guard let url = URL(string: model.image500) else { return }
    }
    
    // MARK: - layoutConstraints
    private func layoutConstraints() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
