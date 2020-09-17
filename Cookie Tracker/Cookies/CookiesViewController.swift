//
//  CookiesViewController.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import CookieKit

class CookieViewController: UIViewController {
    
    // MARK: Properties
    
    private let store: CookiesStorable
    
    // MARK: Subviews
    
    var cookieView: CookieView { view as! CookieView }
    
    // MARK: Init
    
    init(store: CookiesStorable) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented!")
    }
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = CookieView(eatCookieAction: { [unowned self] in
            self.eatCookie()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cookieView.configure(with: store.cookiesAmount)
        connectWithStore()
    }

    // MARK: State Updates

    private func connectWithStore() {
        store.cookiesAmountDidChange = { [weak self] cookiesAmount in
            self?.cookieView.configure(with: cookiesAmount)
        }
    }
    
    // MARK: Actions
    
    private func eatCookie() {
        store.eatCookie()
    }

}

extension CookieView {
    
    func configure(with cookiesAmount: Int) {
        cookieCounterLabel.text = String("\(cookiesAmount) 🍪")
    }
    
}

