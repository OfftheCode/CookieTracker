//
//  HomeView.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

class HomeView: UIView {
    
    // MARK: Properties
    private let eatCookieAction: Tap
    private let showMyCookiesAction: Tap
    
    private let addViewMyCookiesToSiriAction: Tap
    private let addEatCookieToSiriAction: Tap
    
    var viewCookiesShortcut: INShortcut? {
        didSet {
            guard let shorcut = viewCookiesShortcut else { return }
            addViewMyCookiesSiriShortcutsButton.shortcut = shorcut
        }
    }
    
    var eatCookieShortcut: INShortcut? {
        didSet {
            guard let shorcut = eatCookieShortcut else { return }
            addEatCookieSiriShorcutsButton.shortcut = shorcut
        }
    }
    
    private let padding: CGFloat = 16
    
    // MARK: Subviews
    
    lazy var showMyCookieScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show my Cookies", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        button.clipsToBounds = false
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showMyCookiesButtonTapped(_:)), for: .touchUpInside)
        return button
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
    
    lazy var addViewMyCookiesSiriShortcutsButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addShowMyCookiesToSiriButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var addEatCookieSiriShorcutsButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addEatCookieToSiriButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: Init
    
    init(eatCookieAction: @escaping Tap, showMyCookiesAction: @escaping Tap,
         addViewMyCookiesToSiriAction: @escaping Tap, addEatCookieToSiriAction: @escaping Tap) {
        self.eatCookieAction = eatCookieAction
        self.showMyCookiesAction = showMyCookiesAction
        self.addViewMyCookiesToSiriAction = addViewMyCookiesToSiriAction
        self.addEatCookieToSiriAction = addEatCookieToSiriAction
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
    
    @objc private func showMyCookiesButtonTapped(_ sender: UIButton) {
        showMyCookiesAction()
    }
    
    @objc private func addShowMyCookiesToSiriButtonTapped(_ sender: UIButton) {
        addViewMyCookiesToSiriAction()
    }
    
    @objc private func addEatCookieToSiriButtonTapped(_ sender: UIButton) {
        addEatCookieToSiriAction()
    }

    // MARK: Layout
    
    private func setupLayout() {
        addSubviews(showMyCookieScreenButton, eatCookieButton, addViewMyCookiesSiriShortcutsButton, addEatCookieSiriShorcutsButton)
        
        NSLayoutConstraint.activate([
            showMyCookieScreenButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            showMyCookieScreenButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showMyCookieScreenButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            showMyCookieScreenButton.heightAnchor.constraint(equalToConstant: 50),
            
            eatCookieButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            eatCookieButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            eatCookieButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            eatCookieButton.heightAnchor.constraint(equalToConstant: 50),
            
            addViewMyCookiesSiriShortcutsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding * 2.5),
            addViewMyCookiesSiriShortcutsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            addEatCookieSiriShorcutsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding * 2.5),
            addEatCookieSiriShorcutsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
}

extension UIView {
    func addSubviews(_ views: UIView...) { views.forEach(addSubview(_:)) }
}
