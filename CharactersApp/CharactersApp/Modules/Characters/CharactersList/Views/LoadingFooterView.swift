//
//  LoadingFooterView.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import UIKit

class LoadingFooterView: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        
        // Add layout constraints for activityIndicator here
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
