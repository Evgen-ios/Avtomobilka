//
//  CarDetailsModelData.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import UIKit

final class CarDetailsModelData: NSObject, Codable {
    var car: CarModel
    var user: UserModel
    
    init(car: CarModel, user: UserModel) {
        self.car = car
        self.user = user
    }
}

extension CarDetailsModelData {
    private enum CodingKeys: String, CodingKey {
        case car
        case user
    }
}

