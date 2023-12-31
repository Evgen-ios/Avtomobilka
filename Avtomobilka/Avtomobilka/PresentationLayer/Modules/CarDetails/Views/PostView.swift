//
//  PostView.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 28.07.2023.
//

import UIKit

final class PostView: LoadableView {
    
    // MARK: - Properties
    private lazy var avatar = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }

    private lazy var name = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 1
    }
    
    private lazy var message = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    private lazy var time = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .light)
        $0.textColor = .gray
        $0.numberOfLines = 1
    }
    
    private lazy var separatedView = UIView().apply {
        $0.backgroundColor = .systemGray.withAlphaComponent(0.3)
    }
    
    private lazy var likeView = LikeView()
    private lazy var messageView = MessageView()
    
    // MARK: - Inherited Methods
    override func setup() {
        [avatar, name, message, time, likeView, messageView, separatedView].forEach {
            addSubview($0)
        }
        
        layoutConstraint()
    }
    
    // MARK: - Methods
    func configure(model: PostModelData?) {
        guard let model else { return }
        setAvatar(model: model.author)
        likeView.configure(model: model)
        messageView.configure(model: model)
        name.text = model.author.username
        message.text = model.text
        time.text = model.createdAt
        
    }
    
    private func setAvatar(model: AuthorModel) {
        guard let url = URL(string: model.avatar.url) else { return }
        avatar.load(url: url)
    }
    
    func getHeight() -> CGFloat {
        message.bounds.size.height
    }
    
    // MARK: - layoutConstraints
    private func layoutConstraint() {
        avatar.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(avatar.snp.top)
            $0.left.equalTo(avatar.snp.right).offset(8)
        }
        
        time.snp.makeConstraints {
            $0.bottom.equalTo(name.snp.bottom)
            $0.right.equalToSuperview().inset(8)
        }
        
        message.snp.makeConstraints {
            $0.top.equalTo(avatar.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalToSuperview().inset(8)
        }
        
        likeView.snp.makeConstraints {
            $0.top.equalTo(message.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(8)
            $0.height.equalTo(24)
        }
        
        messageView.snp.makeConstraints {
            $0.centerY.equalTo(likeView.snp.centerY)
            $0.left.equalTo(likeView.snp.leftMargin).inset(50)
            $0.height.equalTo(24)
        }
        
        separatedView.snp.makeConstraints  {
            $0.top.equalTo(likeView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(2)
            $0.right.equalToSuperview().inset(2)
            $0.height.equalTo(2)
        }
    }
}
