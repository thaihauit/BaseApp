//
//  Navigator.swift
//  gear
//
//  Created by Alton on 9/26/16.
//  Copyright © 2016 Symphony Creative Solutions. All rights reserved.
//

import Foundation
import UIKit

// Control the app navigation from screen to screen or popup dialog
class Navigator {

    static let sharedInstance = Navigator()
    
    func getTopViewController() -> UIViewController? {
        if let topViewController = getRootViewController()?.childViewControllers.last {
            return topViewController
        }
        return nil
    }
    
    func getRootViewController() -> UIViewController? {
        return UIApplication.shared.windows.first?.rootViewController
    }
    
}

extension UIViewController {
    
    func isPresentedAsModal() -> Bool {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.first != self {
                return false
            }
        }
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    func close(withAnimation animated: Bool = true, completion: (() -> Void)? = nil) {
        if isPresentedAsModal() {
            self.dismiss(animated: animated, completion: completion)
        } else {
            _ = navigationController?.popViewController(animated: animated)
            completion?()
        }
    }
    
    func navigateToScreen(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func moveScreenOnTop() {
        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.keyWindow?.rootViewController =  navigationController
    }
    
    func moveScreenToFrontAndClearTop() {
        if var childViewControllers = Navigator.sharedInstance.getRootViewController()?.childViewControllers {
            var index = 0
            var isExistInList = false
            for controller in childViewControllers {
                if controller == self {
                    isExistInList = true
                    break
                }
                index += 1
            }
            if isExistInList && index != childViewControllers.count - 1 {
                let from = index + 1
                let to = childViewControllers.count - 1
                for i in from...to {
                    let controller = childViewControllers[i]
                    controller.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                if let navigationController = self.navigationController {
                    navigationController.popToViewController(self, animated: false)
                }
            }
        }
    }
    
    func presentScreen(_ viewController: UIViewController, animated: Bool = true, completion: (()->())? = nil) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: animated, completion: completion)
    }
    
    func presentDialog(_ viewController: UIViewController, animated: Bool = true, completion: (()->())? = nil) {
        self.present(viewController, animated: animated, completion: completion)
    }
}
