//
//  Extensions.swift
//  OnboardingExampleUIKit
//
//  Created by Dane Thomas on 10/11/20.
//

import UIKit

extension UIViewController {
    static func makeErrorableInstance<T: UIViewController>(type: T.Type, identifier: String, storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: type.self))
        guard let newVC = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Unable to instantiate view controller with identifier: \(identifier)")
        }

        return newVC
    }
}

extension UIStackView {
    func clearArrangedSubviews(excluding view: UIView? = nil) {
        self.arrangedSubviews.forEach {
            guard $0 != view else { return }
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}

extension UIColor {
    static var activeGreen: UIColor {
        // #AFDB00
        return UIColor(red: 175/255, green: 219/255, blue: 0/255, alpha: 1)
    }
    
    static var inactiveTextColor: UIColor {
        // #DDDDDD
        return UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
    }

}
