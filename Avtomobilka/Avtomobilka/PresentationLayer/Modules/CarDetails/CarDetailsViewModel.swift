//
//  CarDetailsViewModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import UIKit
import DITranquillity
import Combine

final class CarDetailsViewModel {
    
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
        input.carID.publisher
            .sink { [weak self] carID in
                guard let self = self else { return }
                self.getCar(carID: carID)
            }
            .store(in: &bag)
        
        output.$item
            .sink { [weak self] item in
                guard let self = self else { return }
                guard let id = item?.car.id else { return }
                self.getPost(carID: id)
            }
            .store(in: &bag)
    }

    // MARK: - Private Methods
    private func getCar(carID: Int) {
        self.publicationService.FetchDetailCar(carID: carID)
            .apiAnyPublisher()
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.message)
                }
            } receiveValue: { [weak self] item in
                guard let self = self else { return }
                self.output.item = item
                self.output.images = item.car.images
            }
            .store(in: &bag)
    }
    
    private func getPost(carID: Int, with posts: Bool = false) {
        self.publicationService.FetchPosts(carID: carID)
            .apiAnyPublisher()
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.message)
                }
            } receiveValue: { [weak self] posts in
                guard let self = self else { return }
                self.output.posts = posts
            }
            .store(in: &bag)
    }
}

extension CarDetailsViewModel {
    final class Input {
        var didLoad: PublishedAction<Void> = .init()
        var carID: PublishedAction<Int> = .init()
    }
    
    final class Output {
        @PublishedProperty var item: CarDetailsModelData? = nil
        @PublishedProperty var images: [ImageModel] = []
        @PublishedProperty var posts: PostsModelData? = nil
    }
}
