//
//  CarDetailsViewController.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import UIKit
import SnapKit

final class CarDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: CarDetailsViewModel!
    
    private lazy var containerView = UIView().apply {
        $0.backgroundColor = .clear
    }
    
    private lazy var scrollView = UIScrollView().apply {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var stackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            .apply {
                $0.scrollDirection = .horizontal
                let widthItem = UIScreen.main.bounds.width - 19
                $0.itemSize = CGSize(width: widthItem, height: 350)
            }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .apply {
                $0.showsLargeContentViewer = true
                $0.backgroundColor = .none
                $0.dataSource = self
                $0.isScrollEnabled = true
                $0.showsHorizontalScrollIndicator = false
                $0.register(of: CarImageCell.self)
                $0.contentInset = UIEdgeInsets(top: 0,left: 8,bottom: 0,right: 8)
            }
        
        return view
    }()
    
    private lazy var photoImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    private lazy var authorView = AuthorView()
        
    // MARK: - Inherited Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        layoutConstraints()
        viewModel.input.didLoad.send()
    }
    
    // MARK: - SetUp Bindings
    private func setupBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func setupViews() {
        [authorView, collectionView, stackView].forEach {
            containerView.addSubview($0)
        }
        
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
    }
    
    private func bindViewToViewModel() {}
    
    private func bindViewModelToView() {
        viewModel.output.$item
            .sink { [weak self] item in
                guard let self else { return }
                authorView.configure(model: item?.user)
                collectionView.reloadData()
            }
            .store(in: &bag)
        
        viewModel.output.$posts
            .sink { [weak self] posts in
                guard let self, let posts else { return }
                configurePosts(model: posts)
            }
            .store(in: &bag)
    }
    
    private func configurePosts(model: PostsModelData) {
        model.posts.forEach {
            let message = PostView()
            guard !$0.text.isEmpty else { return }
            message.configure(model: $0)
            let height = estimatedLabelHeight(text: $0.text, width: view.safeAreaLayoutGuide.layoutFrame.maxX - 36, font: UIFont.systemFont(ofSize: 13, weight: .regular))
            
            message.snp.remakeConstraints() {
                $0.height.equalTo(height + 80)
            }
            
            stackView.addArrangedSubview(message)
        }
    }
    
    private func estimatedLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: 20000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        return rectangleHeight
    }
    
    // MARK: - layoutConstraints
    private func layoutConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(scrollView).priority(.low)
        }
        
        authorView.snp.makeConstraints {
            $0.top.equalTo(scrollView).inset(18)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalToSuperview().inset(8)
            $0.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(authorView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(350)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(18)
            $0.left.right.equalToSuperview().inset(8)
            $0.bottom.equalTo(scrollView.snp.bottom).inset(18)
        }
    }
}

extension CarDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(of: CarImageCell.self, at: indexPath)
        let item = viewModel.output.images[indexPath.row]
        cell.configure(item)
        return cell
    }
}

