//
//  CookieView.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import CookieKit

class CookieView: UIView {
    
    // MARK: Properties
    private let eatCookieAction: Tap
    
    private let padding: CGFloat = 16
    
    // MARK: Subviews
    
    lazy var cookiesSummaryView: CookiesSummaryView = {
        let cookiesSummaryView = CookiesSummaryView()
        cookiesSummaryView.translatesAutoresizingMaskIntoConstraints = false
        return cookiesSummaryView
    }()
    
    lazy var eatCookieButton: UIButton = {
        let button = UIButton()
        button.setTitle("Eat Cookie", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        button.clipsToBounds = false
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(eatCookieButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: Init
    
    init(eatCookieAction: @escaping Tap) {
        self.eatCookieAction = eatCookieAction
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Handlers
    
    @objc private func eatCookieButtonTapped(_ sender: UIButton) {
        eatCookieAction()
    }

    // MARK: Layout
    
    private func setupLayout() {
        addSubviews(cookiesSummaryView, eatCookieButton)
        
        NSLayoutConstraint.activate([
            cookiesSummaryView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cookiesSummaryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cookiesSummaryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cookiesSummaryView.heightAnchor.constraint(equalToConstant: 110),
            
            eatCookieButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding * 3),
            eatCookieButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            eatCookieButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            eatCookieButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
