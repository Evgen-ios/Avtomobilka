//
//  CarsListViewModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import UIKit
import DITranquillity
import Combine

final class CarsListViewModel {
    
    // MARK: - Properties
    private var bag = CancelBag()
    private var publicationService: PublicationService!
    
    let input = Input()
    let output = Output()
    
    // MARK: - Init
    init(publicationService: PublicationService) {
        self.publicationService = publicationService
        self.setUpBindings()
    }
    
    // MARK: - SetUp Bindings
    private func setUpBindings() {
        input.didLoad.publisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                input.loadMore.send()
            }
            .store(in: &bag)
        
        input.loadMore.publisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.getItems(page: self.input.page)
            }
            .store(in: &bag)
    }
    
    // MARK: - Private Methods
    private func getItems(page: Int) {
        self.publicationService.FetchCars(page: page)
            .apiAnyPublisher()
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.message)
                }
            } receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.output.insertItems = items
                self.input.page += 1
            }
            .store(in: &bag)
    }
}

extension CarsListViewModel {
    final class Input {
        var didLoad: PublishedAction<Void> = .init()
        var loadMore: PublishedAction<Void> = .init()
        var openCarDetails: PublishedAction<CarModelData> = .init()
        var page: Int = 1
    }
    
    final class Output {
        @PublishedProperty var items: [CarModelData] = []
        @PublishedProperty var insertItems: [CarModelData] = []
    }
}

