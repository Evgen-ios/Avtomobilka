//
//  UIWindow + Ext.swift.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import UIKit

extension UIWindow {
    
    func changeRootViewController(to controller: UIViewController) {
        if self.rootViewController == nil {
            self.rootViewController = controller
            return
        }
        
        let windowSnapshot = self.snapshotView(afterScreenUpdates: true)
        self.rootViewController?.dismiss(animated: false, completion: nil)
        
        guard let snapshot = windowSnapshot else {
            self.rootViewController = controller
            return
        }
        
        controller.view.addSubview(snapshot)
        self.rootViewController = controller
        
        UIView.animate(withDuration: 0.1, animations: {
            snapshot.layer.opacity = 0
        }, completion: { finished in
            if finished {
                snapshot.removeFromSuperview()
            }
        })
    }
}
