//
//  LikeView.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 28.07.2023.
//

import UIKit

final class LikeView: LoadableView {
    
    // MARK: - Properties
    private lazy var like = UIButton().apply {
        $0.setImage(UIImage(named: "redHeart"), for: .normal)
    }
    
    private lazy var countViev = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .lightGray
        $0.numberOfLines = 1
    }
    
    // MARK: - Inherited Methods
    override func setup() {
        [like, countViev].forEach {
            addSubview($0)
        }
        
        layoutConstraint()
    }
    
    // MARK: - Methods
    func configure(model: PostModelData) {
        countViev.text = String(model.likeCount)
    }
    
    func likeTap() {
        self.like.isHighlighted.toggle()
    }
    
    // MARK: - layoutConstraints
    private func layoutConstraint() {
        like.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        countViev.snp.makeConstraints {
            $0.top.equalTo(like.snp.top)
            $0.left.equalTo(like.snp.right).offset(4)
        }
    }
}
