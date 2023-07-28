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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            .apply {
                $0.scrollDirection = .horizontal
                let widthItem = UIScreen.main.bounds.width - 19
                $0.itemSize = CGSize(width: widthItem, height: 210)
            }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .apply {
                $0.showsLargeContentViewer = true
                $0.backgroundColor = .none
                $0.dataSource = self
                $0.delegate = self
                $0.isScrollEnabled = true
                $0.showsHorizontalScrollIndicator = false
                $0.register(of: CarImageCell.self)
                $0.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
            }
        
        return view
    }()
    
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
        view.addSubview(collectionView)
    }
    
    private func bindViewToViewModel() {}
    
    private func bindViewModelToView() {}
    
    // MARK: - layoutConstraints
    private func layoutConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension CarDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(of: CarImageCell.self, at: indexPath)
        return cell
    }
}

extension CarDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CarImageCell else { return }
        let item = viewModel.output.images[indexPath.row]
        cell.configure(item)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let item = viewModel.output.images[indexPath.row]
//        print("\(item.id) selected")
//    }
}

