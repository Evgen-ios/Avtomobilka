//
//  CarCell.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 26.07.2023.
//

import UIKit

final class CarCell: LoadableCollectionViewCell {
    private var bag = CancelBag()
    private var model: CarModelData!
    
    // MARK: - Properties
    private lazy var brandNameLabel = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 15
    }
    
    private lazy var photoImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    // MARK: - Inherited Methods
    override func setup() {
        super.setup()
        
        [photoImageView, brandNameLabel].forEach {
            addSubview($0)
        }
        
        photoImageView.layer.cornerRadius = 16
        photoImageView.clipsToBounds = true
        
        layoutConstraints()
        bind()
    }
    
    override func prepareForReuse() {
        brandNameLabel.text = nil
        photoImageView.image = nil
        super.prepareForReuse()
    }
    
    private func bind() {}
    
    func configure(_ model: CarModelData) {
        self.model = model
        guard let url = URL(string: model.image) else { return }
        photoImageView.load(url: url)
        brandNameLabel.text = model.name
    }
    
    // MARK: - layoutConstraints
    private func layoutConstraints() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        brandNameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
        }
    }
}
