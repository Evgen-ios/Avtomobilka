//
//  CarsListViewModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import UIKit
import DITranquillity
import Combine

// MARK: - View Model

final class CarsListViewModel {
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
                print("Did load")
                self.getItems(page: 1)
            }
            .store(in: &bag)
    }
    
    private func getItems(page: Int) {
        self.publicationService.FetchCars(page: page)
            .apiAnyPublisher()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print(error.message)
                }
            } receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.output.insertItems = items
            }
            .store(in: &bag)
    }
}

extension CarsListViewModel {
    final class Input {
        var didLoad: PublishedAction<Void> = .init()
    }
    
    final class Output {
        @PublishedProperty var items: [CarModelData] = []
        @PublishedProperty var insertItems: [CarModelData] = [] {
            didSet {
                print(insertItems)
            }
        }
    }
}

