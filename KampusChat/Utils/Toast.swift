//
//  Toast.swift
//  KampusChat
//
//  Created by Burak on 11.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class Toast{
    
    func showToast(message: String, font: UIFont,viewController:UIViewController) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let maxTitleSize = CGSize(width: viewController.view.bounds.size.width * maxWidthPercentage, height: viewController.view.bounds.size.height * maxWidthPercentage)
        var titleSize = toastLabel.sizeThatFits(maxTitleSize)
        titleSize.width += 20
        titleSize.height += 10
        toastLabel.frame = CGRect(x: viewController.view.frame.size.width / 2 - titleSize.width / 2, y: viewController.view.frame.size.height - 100, width: titleSize.width+10, height: titleSize.height+10)
        
        viewController.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
}


