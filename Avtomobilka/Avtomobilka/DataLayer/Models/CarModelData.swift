//
//  CarModelData.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 24.07.2023.
//

import Foundation

final class CarModelData: NSObject, Codable {
    var id: Int
    var forSale: Int
    var brandName: String
    var modelName: String
    var engineName: String
    var year: Int
    var price: Double?
    var brandID: Int
    var modelID: Int
    var engineID: Int
    var transmissionID: Int
    var placeID: String
    var name: String
    var image: String
    var thumbnail: String
    var cityName: String
    var countryName: String
    var transmissionName: String
    var engineVolume: String
    var placeName: String
    var images: [ImageModel]
    var engine: String
    
    init(id: Int, forSale: Int, brandName: String, modelName: String, engineName: String, year: Int, price: Double?, brandID: Int, modelID: Int, engineID: Int, transmissionID: Int, placeID: String, name: String, image: String, thumbnail: String, cityName: String, countryName: String, transmissionName: String, engineVolume: String, placeName: String, images: [ImageModel], engine: String) {
        self.id = id
        self.forSale = forSale
        self.brandName = brandName
        self.modelName = modelName
        self.engineName = engineName
        self.year = year
        self.price = price
        self.brandID = brandID
        self.modelID = modelID
        self.engineID = engineID
        self.transmissionID = transmissionID
        self.placeID = placeID
        self.name = name
        self.image = image
        self.thumbnail = thumbnail
        self.cityName = cityName
        self.countryName = countryName
        self.transmissionName = transmissionName
        self.engineVolume = engineVolume
        self.placeName = placeName
        self.images = images
        self.engine = engine
    }
}

extension CarModelData {
    private enum CodingKeys: String, CodingKey {
        case id
        case forSale = "for_sale"
        case brandName = "brand_name"
        case modelName = "model_name"
        case engineName = "engine_name"
        case year
        case price
        case brandID = "brand_id"
        case modelID = "model_id"
        case engineID = "engine_id"
        case transmissionID = "transmission_id"
        case placeID = "place_id"
        case name
        case image
        case thumbnail
        case cityName = "city_name"
        case countryName = "country_name"
        case transmissionName = "transmission_name"
        case engineVolume = "engine_volume"
        case placeName = "place_name"
        case images
        case engine
    }
}
