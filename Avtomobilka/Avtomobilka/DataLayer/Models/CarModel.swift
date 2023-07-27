//
//  CarModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation

struct CarModel: Codable, Equatable {
    var id: Int
    var forSale: Int
    var brandName: String
    var modelName: String
    var year: Int
    var price: Double?
    var brandID: Int
    var modelID: Int
    var engineID: Int
    var transmissionID: Int
    var placeID: String
    var name: String
    var cityName: String
    var countryName: String
    var transmissionName: String
    var placeName: String
    var images: [ImageModel]
    var inSelectionCount: Int
    var followersCount: Int
    var follow: Bool
    var engine: Double
    var engineName: String
    var engineVolume: String
    var isModerated: Bool
    
    init(id: Int, forSale: Int, brandName: String, modelName: String, year: Int, price: Double? = nil, brandID: Int, modelID: Int, engineID: Int, transmissionID: Int, placeID: String, name: String, cityName: String, countryName: String, transmissionName: String, placeName: String, images: [ImageModel], inSelectionCount: Int, followersCount: Int, follow: Bool, engine: Double, engineName: String, engineVolume: String, isModerated: Bool) {
        self.id = id
        self.forSale = forSale
        self.brandName = brandName
        self.modelName = modelName
        self.year = year
        self.price = price
        self.brandID = brandID
        self.modelID = modelID
        self.engineID = engineID
        self.transmissionID = transmissionID
        self.placeID = placeID
        self.name = name
        self.cityName = cityName
        self.countryName = countryName
        self.transmissionName = transmissionName
        self.placeName = placeName
        self.images = images
        self.inSelectionCount = inSelectionCount
        self.followersCount = followersCount
        self.follow = follow
        self.engine = engine
        self.engineName = engineName
        self.engineVolume = engineVolume
        self.isModerated = isModerated
    }
}

extension CarModel {
    private enum CodingKeys: String, CodingKey {
        case id
        case forSale = "for_sale"
        case brandName = "brand_name"
        case modelName = "model_name"
        case year
        case price
        case brandID = "brand_id"
        case modelID = "model_id"
        case engineID = "engine_id"
        case transmissionID = "transmission_id"
        case placeID = "place_id"
        case name
        case cityName = "city_name"
        case countryName = "country_name"
        case transmissionName = "transmission_name"
        case placeName = "place_name"
        case images
        case inSelectionCount = "in_selection_count"
        case followersCount = "followers_count"
        case follow
        case engine
        case engineName = "engine_name"
        case engineVolume = "engine_volume"
        case isModerated = "is_moderated"
    }
}
