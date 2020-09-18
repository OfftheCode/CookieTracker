//
//  CookiesSummaryView.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

public class CookiesSummaryView: UIView {
    
    // MARK: Properties
    
    public static let suggestedHeight: CGFloat = 111
    
    // MARK: Subviews & Layers
    
    private var shadowLayer: CAShapeLayer!
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var youHaveLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.text = "You Have"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cookiesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cookieBackgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.clipsToBounds = false
        backgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        backgroundView.backgroundColor = UIColor(red: 0.05, green: 0.78, blue: 1.00, alpha: 1.00)
        backgroundView.layer.cornerRadius = 9
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    lazy var cookieIcon: UILabel = {
        let label = UILabel()
        label.text = "🍪"
        label.font = .systemFont(ofSize: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    // MARK: Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
          
            shadowLayer.path = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 9).cgPath

            shadowLayer.shadowColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 18)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 9
            shadowLayer.masksToBounds = false

            layer.insertSublayer(shadowLayer, below: containerView.layer)
        }
    }
    
    private func setupLayout() {
        
        addSubview(containerView)
        containerView.addSubviews(youHaveLabel, cookiesLabel, cookieBackgroundView, cookieIcon)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            youHaveLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 27),
            youHaveLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 19),

            cookiesLabel.topAnchor.constraint(equalTo: youHaveLabel.bottomAnchor, constant: 8),
            cookiesLabel.leadingAnchor.constraint(equalTo: youHaveLabel.leadingAnchor),
            
            cookieBackgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cookieBackgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cookieBackgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cookieBackgroundView.widthAnchor.constraint(equalToConstant: Self.suggestedHeight),

            cookieIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cookieIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -36)
        ])

    }
    
}

public extension CookiesSummaryView {
    
    func configure(withCookiesAmount cookiesAmount: Int) {
        cookiesLabel.text = "\(cookiesAmount) Cookies"
    }
    
}

extension UIView {
    func addSubviews(_ views: UIView...) { views.forEach(addSubview(_:)) }
}
