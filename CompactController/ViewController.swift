//
//  ViewController.swift
//  CompactController
//
//  Created by Бучевский Андрей on 15.04.2024.
//

import UIKit

final class ViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }

    @objc
    func didTapButton(_ sender: UIButton) {
        let vc = PopoverViewController()
        vc.preferredContentSize = .init(width: 300, height: 280)
        vc.modalPresentationStyle = .popover
        let popover = vc.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = sender
        present(vc, animated: true)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

final class PopoverViewController: UIViewController {

    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["280 pt", "150 pt"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        return segmentControl
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        let config = UIButton.Configuration.borderless()

        button.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(UIColor.gray).withRenderingMode(.alwaysOriginal), for: .normal)

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(segmentControl)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            closeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc
    func didTapButton() {
        dismiss(animated: true)
    }

    @objc
    func didChangeSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            preferredContentSize = .init(width: 300, height: 280)
        case 1:
            preferredContentSize = .init(width: 300, height: 150)
        default:
            break
        }
    }
}
