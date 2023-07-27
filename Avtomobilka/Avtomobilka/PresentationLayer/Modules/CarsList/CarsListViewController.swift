//
//  CarsListViewController.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import UIKit
import SnapKit

// MARK: - View Controller
final class CarsListViewController: BaseViewController {

    var viewModel: CarsListViewModel!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            .apply {
                $0.scrollDirection = .vertical
                let widthItem = UIScreen.main.bounds.width
                $0.itemSize = CGSize(width: widthItem, height: 495)
            }
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .apply {
                $0.backgroundColor = .none
                $0.dataSource = self
                $0.delegate = self
                $0.isScrollEnabled = true
                $0.showsHorizontalScrollIndicator = false
                $0.register(of: CarCell.self)
                $0.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
            }
        
        return view
    }()
    
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
    
    private func bindViewToViewModel() {
        
    }
    
    private func bindViewModelToView() {
        
    }
    
    private func layoutConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension CarsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(of: CarCell.self, at: indexPath)
//        cell.configure(viewModel.output.items[indexPath.row].image)
        return cell
    }
}

extension CarsListViewController: UICollectionViewDelegate {
    
}
