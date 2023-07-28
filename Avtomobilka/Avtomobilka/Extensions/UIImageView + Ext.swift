//
//  UIImageView + Ext.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    func load(url: URL?, placeholder: UIImage? = nil) {
        
        self.image = placeholder
        let options: SDWebImageOptions =  [.allowInvalidSSLCertificates, .retryFailed, .continueInBackground]
        SDWebImageManager.shared.loadImage(with: url, options: options, progress: nil) { image, data, error, cacheType, completed, url in
            guard let image else { return }
            self.image = image
        }
    }
}
