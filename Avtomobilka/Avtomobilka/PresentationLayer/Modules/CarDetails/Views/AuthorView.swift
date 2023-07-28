//
//  AuthorView.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 28.07.2023.
//

import UIKit

final class AuthorView: LoadableView {
    
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
    
    private lazy var about = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    func configure(model: UserModel?) {
        guard let model else { return }
        setAvatar(model: model)
        name.text = model.username
        about.text = model.about
    }
    
    private func setAvatar(model: UserModel) {
        guard let url = URL(string: model.avatar.url) else { return }
        avatar.load(url: url)
    }
    
    override func setup() {
        [avatar, name, about].forEach {
            addSubview($0)
        }
        
        layoutConstraint()
    }
    
    private func layoutConstraint() {
        avatar.snp.makeConstraints {
            $0.size.equalTo(55)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(avatar.snp.top)
            $0.left.equalTo(avatar.snp.right).offset(8)
            $0.height.equalTo(18)
        }
        
        about.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(2)
            $0.left.equalTo(avatar.snp.right).offset(8)
            $0.right.equalToSuperview()
        }
        
    }
}
