//
//  BaseViewController.swift.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import UIKit

class BaseViewController: UIViewController {
    var bag = CancelBag()

    public var statusBarStyle: UIStatusBarStyle = .default
    
    deinit {
        print("[D] \(self) destroyed")
        NotificationCenter.default.removeObserver(self)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override func loadView() {
        super.loadView()
        view = UIView().apply {
            $0.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setupBackButton()
        self.setupStrings()
    }

    func initialize() {}

    func setupStrings() {}
    
    func addSubviews() {}

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    func setupBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }
}
