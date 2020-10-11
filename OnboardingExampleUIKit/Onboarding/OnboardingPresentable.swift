//
//  OnboardingPresentable.swift
//  OnboardingExampleUIKit
//
//  Created by Dane Thomas on 10/11/20.
//

import UIKit

protocol OnboardingPresentable {
    func viewDidLoad()
    func buttonAction()
}

final class FirstOnboardingPresenter: OnboardingPresentable {

    weak var output: OnboardingViewController?
    let locationManager: LocationManager
    unowned var navController: UINavigationController

    init(output: OnboardingViewController, locationManager: LocationManager, navController: UINavigationController) {
        self.output = output
        self.locationManager = locationManager
        self.navController = navController
    }

    func viewDidLoad() {
        let bgImage = UIImage(named: "bg1")
        let iconImage = UIImage(systemName: "location.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let title = "Ask for Location"
        let body = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."]
        let buttonTitle = "First Button"
        let viewConfig = OnboardingViewConfiguration(backgroundImage: bgImage, iconImage: iconImage,
                                                     title: title, bodyTexts: body, buttonTitle: buttonTitle)
        self.output?.configureView(with: viewConfig)
    }

    func buttonAction() {
        self.locationManager.requestAuthorization { [weak self] (_) in
            guard let self = self else { return }
            let onb2 = OnboardingVCFactory.makeSecondOnboardingVC(navController: self.navController)
            self.navController.pushViewController(onb2, animated: true)
        }
    }
}

final class SecondOnboardingPresenter: OnboardingPresentable {

    weak var output: OnboardingViewController?
    unowned var navController: UINavigationController

    init(output: OnboardingViewController, navController: UINavigationController) {
        self.output = output
        self.navController = navController
    }

    func viewDidLoad() {
        let bgImage = UIImage(named: "bg2")
        let iconImage = UIImage(systemName: "sun.max.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let title = "Onboarding 2"
        let body = ["Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."]
        let buttonTitle = "Second Button"
        let viewConfig = OnboardingViewConfiguration(backgroundImage: bgImage, iconImage: iconImage,
                                                     title: title, bodyTexts: body, buttonTitle: buttonTitle)
        self.output?.configureView(with: viewConfig)
    }

    func buttonAction() {
        let onb3 = OnboardingVCFactory.makeThirdOnboardingVC(navController: self.navController)
        self.navController.pushViewController(onb3, animated: true)
    }
}

final class ThirdOnboardingPresenter: OnboardingPresentable {

    weak var output: OnboardingViewController?
    unowned var navController: UINavigationController

    init(output: OnboardingViewController, navController: UINavigationController) {
        self.output = output
        self.navController = navController
    }

    func viewDidLoad() {
        let bgImage = UIImage(named: "bg3")
        let iconImage = UIImage(systemName: "car.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let title = "Onboarding 3"
        let body = ["Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
                    "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
                    "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem."]
        let buttonTitle = "3rd Button"
        let viewConfig = OnboardingViewConfiguration(backgroundImage: bgImage, iconImage: iconImage,
                                                     title: title, bodyTexts: body, buttonTitle: buttonTitle)
        self.output?.configureView(with: viewConfig)
    }

    func buttonAction() {
        self.navController.popToRootViewController(animated: true)
    }
}
