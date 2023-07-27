//
//  CarsListViewController.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import UIKit
import SnapKit
import UIScrollView_InfiniteScroll

final class CarsListViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: CarsListViewModel!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            .apply {
                $0.scrollDirection = .vertical
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
                $0.register(of: CarCell.self)
                $0.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
                $0.infiniteScrollDirection = .vertical
                $0.addInfiniteScroll() { [weak self] collectionView in
                    self?.viewModel.input.loadMore.send()
                }
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
    
    private func bindViewModelToView() {
        viewModel.output.$insertItems
            .sink { [weak self] insertItems in
                guard let self = self else { return }
                let newItems = viewModel.output.items + insertItems
                
                let start = viewModel.output.items.endIndex
                let end = insertItems.count + start
                
                let indices = Array(start..<end).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                viewModel.output.items = newItems
                collectionView.insertItems(at: indices)
                collectionView.finishInfiniteScroll()
            }
            .store(in: &bag)
        
        viewModel.output.$items
            .sink { [weak self] items in
                guard let self = self else { return }
            }
            .store(in: &bag)
    }
    
    // MARK: - layoutConstraints
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
        return viewModel.output.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(of: CarCell.self, at: indexPath)
        return cell
    }
}

extension CarsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CarCell else { return }
        let item = viewModel.output.items[indexPath.row]
        cell.configure(item)
    }
}
