//
//  OnboardingViewController.swift
//  OnboardingExampleUIKit
//
//  Created by Dane Thomas on 10/11/20.
//

import UIKit

class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresentable!

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var bodyStackView: UIStackView!
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        self.cardView.layer.cornerRadius = 16
        self.titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        self.titleLabel.textColor = .white
        self.styleActionButton()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func styleActionButton() {
        self.actionButton.backgroundColor = UIColor.activeGreen
        self.actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        self.actionButton.setTitleColor(.white, for: [.normal])
        self.actionButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.actionButton.layer.cornerRadius = 10
        self.actionButton.layer.cornerCurve = .continuous
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        self.presenter.buttonAction()
    }

    func configureView(with config: OnboardingViewConfiguration) {
        self.bodyStackView.clearArrangedSubviews()
        self.backgroundImageView.image = config.backgroundImage
        self.iconImageView.image = config.iconImage
        self.titleLabel.text = config.title
        let bodyLabels = self.makeBodyLabels(with: config.bodyTexts)
        bodyLabels.forEach { (label) in
            label.translatesAutoresizingMaskIntoConstraints = false
            self.bodyStackView.addArrangedSubview(label)
        }
        self.actionButton.setTitle(config.buttonTitle, for: .normal)
    }

    func makeBodyLabels(with texts: [String]) -> [UILabel] {
        var labels: [UILabel] = []
        texts.forEach { (text) in
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            label.textColor = UIColor.inactiveTextColor
            label.text = text
            labels.append(label)
        }
        return labels
    }
}
