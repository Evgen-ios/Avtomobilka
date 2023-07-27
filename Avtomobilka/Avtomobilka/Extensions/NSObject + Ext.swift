//
//  NSObject + Ext.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 26.07.2023.
//

import Foundation

extension NSObjectProtocol {
    @discardableResult
    func apply(_ closure: (Self) -> () ) -> Self {
        { closure(self) }()
        return self
    }
}
