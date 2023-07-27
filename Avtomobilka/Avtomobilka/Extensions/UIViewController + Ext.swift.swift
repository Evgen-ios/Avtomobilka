//
//  UIViewController + Ext.swift.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import UIKit

extension UIViewController {
    static func loadFromNib(_ name: String? = nil) -> Self {
        return self.init(nibName: name, bundle: nil)
    }
}
