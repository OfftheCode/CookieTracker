//
//  IntentViewController.swift
//  ViewCookiesUI
//
//  Created by Piotr Szadkowski on 18/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import IntentsUI
import CookieKit

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    lazy var cookiesSummaryView: CookiesSummaryView = {
        let view = CookiesSummaryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return numberFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // MARK: - INUIHostedViewControlling
    
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        switch interaction.intentResponse {
        case let response as ViewMyCookiesIntentResponse:
            guard interaction.intentHandlingStatus == .success else {
                completion(false, parameters, self.desiredSize)
                return
            }
            
            let amount = Int(response.amount ?? "0") ?? 0
            viewMyCookies(with: amount)
            completion(true, parameters, self.desiredSize)
        
        case let _ as AddCookieIntentResponse:
            if interaction.intentHandlingStatus == .ready {
                let amount: Int
                
                if let cookieIntent = interaction.intent as? AddCookieIntent,
                   let number = numberFormatter.number(from: cookieIntent.cookiesAmount?.lowercased() ?? "one") {
                    amount = number.intValue
                } else {
                    amount = 1
                }
                
                viewMyCookies(with: amount, andTitle: "You're adding")
                completion(true, parameters, self.desiredSize)
            } else if interaction.intentHandlingStatus == .success {
                viewMyCookies(with: CookiesStore().cookiesAmount)
                completion(true, parameters, self.desiredSize)
            } else {
                completion(false, parameters, self.desiredSize)
            }
        default:
            completion(false, parameters, self.desiredSize)
        }
        
    }
    
    private func viewMyCookies(with amount: Int, andTitle title: String? = nil) {
        view.addSubview(cookiesSummaryView)
        
        NSLayoutConstraint.activate([
            cookiesSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cookiesSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cookiesSummaryView.topAnchor.constraint(equalTo: view.topAnchor),
            cookiesSummaryView.heightAnchor.constraint(equalToConstant: CookiesSummaryView.suggestedHeight)
        ])
        
        if let title = title {
            cookiesSummaryView.configure(withTitle: title, andCookiesAmount: amount)
        } else {
            cookiesSummaryView.configure(withCookiesAmount: amount)
        }
        
        cookiesSummaryView.setNeedsLayout()
        cookiesSummaryView.layoutIfNeeded()
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
