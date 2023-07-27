//
//  DetailCarModelData.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import UIKit

final class DetailCarModelData: NSObject, Codable {
    var car: CarModel
    var user: UserModel
    
    init(car: CarModel, user: UserModel) {
        self.car = car
        self.user = user
    }
}

extension DetailCarModelData {
    private enum CodingKeys: String, CodingKey {
        case car
        case user
    }
}

