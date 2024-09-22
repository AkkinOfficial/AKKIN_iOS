//
//  MakePiggyBankCompleteViewController.swift
//  AKKIN
//
//  Created by 신종원 on 9/14/24.
//

import UIKit

final class MakePiggyBankCompleteViewController: BaseViewController, UITextFieldDelegate {

    // MARK: UI Components
    private let makePiggyBankCompleteView = MakePiggyBankCompleteView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(makePiggyBankCompleteView)


        makePiggyBankCompleteView.emojiTextField.delegate = self
        makePiggyBankCompleteView.backButton.tap = { [self] in
            router.popViewController()
        }
        makePiggyBankCompleteView.tapOutButton = { [weak self] in
            guard let self else { return }
            navigationController?.popToRootViewController(animated: true)
        }
        makePiggyBankCompleteView.piggyBankCompleteButton.tap = { [weak self] in
            guard let self else { return }
            navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        makePiggyBankCompleteView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: Event
    func textFieldDidBeginEditing(_ textField: UITextField) {
        makePiggyBankCompleteView.emojiTextField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            makePiggyBankCompleteView.emojiTextField.text = "💰"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 1
    }
}
