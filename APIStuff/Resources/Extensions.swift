//
//  Extensions.swift
//  APIStuff
//
//  Created by David Jabech on 7/20/22.
//

import UIKit

extension UIViewController {
    func presentAlert(alert: AlertModel, actions: [AlertActionModel]) {
        let alert = UIAlertController(title: alert.title,
                                      message: alert.message,
                                      preferredStyle: alert.style)
        for action in actions {
            alert.addAction(UIAlertAction(title: action.title,
                                          style: action.style,
                                          handler: action.handler))
        }
        present(alert, animated: true)
    }
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
    func centerY(in superView: UIView) {
        center.y = superView.center.y
    }
    
    func centerX(in superView: UIView ) {
        center.x = superView.center.x
    }
    
    func center(in superView: UIView) {
        center = superView.center
    }

    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
    
    var leading: CGFloat {
        return frame.origin.x
    }
    
    var trailing: CGFloat {
        return leading + width
    }
}

