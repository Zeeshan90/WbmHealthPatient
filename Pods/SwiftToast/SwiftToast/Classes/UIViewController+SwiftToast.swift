//
//  UIViewController+SwiftToast.swift
//  Pods
//
//  Created by Daniele Boscolo on 22/05/17.
//
//

import UIKit

public extension UIViewController {
    
    func present(_ toast: SwiftToastProtocol, animated: Bool) {
        SwiftToastController.shared.present(toast, swiftToastView: SwiftToastView(), animated: animated)
    }
    
    func present(_ toast: SwiftToastProtocol, withCustomSwiftToastView customToastView: SwiftToastViewProtocol, animated: Bool) {
        SwiftToastController.shared.present(toast, swiftToastView: customToastView, animated: animated)
    }
    
    func dismissSwiftToast(_ animated: Bool) {
        SwiftToastController.shared.dismiss(animated)
    }
}
