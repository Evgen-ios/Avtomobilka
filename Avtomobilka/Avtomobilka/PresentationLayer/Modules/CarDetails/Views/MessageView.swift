//
//  MessageView.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 29.07.2023.
//

import UIKit

final class MessageView: LoadableView {
    
    // MARK: - Properties
    private lazy var message = UIButton().apply {
        $0.setImage(UIImage(named: "grayMessage"), for: .normal)
    }
    
    private lazy var countViev = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .lightGray
        $0.numberOfLines = 1
    }
    
    private var bag = CancelBag()
    
    // MARK: - Inherited Methods
    override func setup() {
        [message, countViev].forEach {
            addSubview($0)
        }
        
        layoutConstraint()
    }
    
    
    // MARK: - Methods
    func configure(model: PostModelData) {
        countViev.text = String(model.commentCount)
    }
    
    private func likeTap() {
        self.message.isHighlighted.toggle()
    }
    
    // MARK: - layoutConstraints
    private func layoutConstraint() {
        message.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        countViev.snp.makeConstraints {
            $0.centerY.equalTo(message.snp.centerY)
            $0.left.equalTo(message.snp.right).offset(4)
        }
    }
}
