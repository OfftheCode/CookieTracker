//
//  CookieViewController.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class CookieViewController: UIViewController {
    
    // MARK: Properties
    
    private var cookiesAmount: Int = 10 {
        didSet {
            guard 0...10 ~= cookiesAmount else { cookiesAmount = oldValue; return }
            cookieView.configure(with: cookiesAmount)
        }
    }
    
    // MARK: Subviews
    
    var cookieView: CookieView { view as! CookieView }
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = CookieView(eatCookieAction: { [unowned self] in
            self.eatCookie()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cookieView.configure(with: cookiesAmount)
    }

    // MARK: Actions
    
    private func eatCookie() {
        cookiesAmount -= 1
    }

}

extension CookieView {
    
    func configure(with cookiesAmount: Int) {
        cookieCounterLabel.text = String("\(cookiesAmount) 🍪")
    }
    
}
