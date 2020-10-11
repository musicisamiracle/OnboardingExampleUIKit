//
//  OnboardingVCFactory.swift
//  OnboardingExampleUIKit
//
//  Created by Dane Thomas on 10/11/20.
//
import UIKit

struct OnboardingVCFactory {

    private static let storyboardName = "Onboarding"
    
    static func makeMainNav() -> UINavigationController {
        let nav = UINavigationController()
        nav.navigationBar.isHidden = true
        return nav
    }

    static func makeFirstOnboardingVC(navController: UINavigationController) -> OnboardingViewController {
        let onbVC = UIViewController.makeErrorableInstance(type: OnboardingViewController.self,
                                                           identifier: "OnboardingVC",
                                                           storyboardName: storyboardName)
        let presenter = FirstOnboardingPresenter(output: onbVC,
                                                   locationManager: LocationManager(), navController: navController)
        onbVC.presenter = presenter

        return onbVC
    }

    static func makeSecondOnboardingVC(navController: UINavigationController) -> OnboardingViewController {
        let onbVC = UIViewController.makeErrorableInstance(type: OnboardingViewController.self,
                                                           identifier: "OnboardingVC",
                                                           storyboardName: storyboardName)
        let presenter = SecondOnboardingPresenter(output: onbVC, navController: navController)
        onbVC.presenter = presenter

        return onbVC
    }

    static func makeThirdOnboardingVC(navController: UINavigationController) -> OnboardingViewController {
        let onbVC = UIViewController.makeErrorableInstance(type: OnboardingViewController.self,
                                                           identifier: "OnboardingVC",
                                                           storyboardName: storyboardName)
        let presenter = ThirdOnboardingPresenter(output: onbVC, navController: navController)
        onbVC.presenter = presenter
        return onbVC
    }
}
