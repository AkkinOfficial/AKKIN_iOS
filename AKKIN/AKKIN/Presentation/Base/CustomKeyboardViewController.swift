//
//  CustomKeyboardViewController.swift
//  AKKIN
//
//  Created by 성현주 on 9/15/24.
//

import UIKit
import SnapKit

protocol CustomKeyboardDelegate: AnyObject {
    func customKeyboard(_ keyboard: CustomKeyboardViewController, didEnterAmount amount: String)
}

class CustomKeyboardViewController: UIViewController {

    weak var delegate: CustomKeyboardDelegate?

    private let predefinedAmounts = ["5천", "1만", "5만", "10만", "50만"]
    private let numbers = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["00", "0", "⌫"]
    ]
    private let operations = ["+", "-", "×", "÷", "="]
    private var currentInput = ""
    private var operation: String?
    private var firstOperand: Int?
    private var secondOperand: Int?

    private var selectedOperationButton: UIButton?

    private let predefinedAmountsStackView = createStackView(axis: .horizontal)
    private let keypadStackView = createStackView(axis: .vertical)
    private let operationsStackView = createStackView(axis: .vertical)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        addButtons(to: predefinedAmountsStackView, titles: predefinedAmounts, action: #selector(amountButtonTapped(_:)))
        numbers.forEach { addRow(to: keypadStackView, titles: $0, action: #selector(keypadButtonTapped(_:))) }
        addButtons(to: operationsStackView, titles: operations, action: #selector(operationButtonTapped(_:)))

        [predefinedAmountsStackView, keypadStackView, operationsStackView].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        predefinedAmountsStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.leading.trailing.equalTo(view).inset(16)
        }

        keypadStackView.snp.makeConstraints { make in
            make.top.equalTo(predefinedAmountsStackView.snp.bottom).offset(16)
            make.leading.equalTo(view).offset(16)
            make.width.equalTo(view).multipliedBy(0.75)
        }

        operationsStackView.snp.makeConstraints { make in
            make.leading.equalTo(keypadStackView.snp.trailing).offset(8)
            make.trailing.equalTo(view).offset(-16)
            make.top.bottom.equalTo(keypadStackView)
        }
    }

    // MARK: - Event: Number Input
    @objc private func amountButtonTapped(_ sender: UIButton) {
        // Convert predefined amount to numeric value
        guard let amountText = sender.title(for: .normal) else { return }
        let amount = convertPredefinedAmountToNumber(amountText)
        currentInput = "\(amount)"
        delegate?.customKeyboard(self, didEnterAmount: currentInput)
    }

    @objc private func keypadButtonTapped(_ sender: UIButton) {
        guard let value = sender.title(for: .normal) else { return }
        if value == "⌫" {
            if !currentInput.isEmpty {
                currentInput.removeLast()
            }
        } else {
            currentInput += value
        }
        delegate?.customKeyboard(self, didEnterAmount: currentInput)
    }

    // MARK: - Event: Operation Input
    @objc private func operationButtonTapped(_ sender: UIButton) {
        guard let operationValue = sender.title(for: .normal) else { return }

        // Change the selected operation button background color
        updateOperationButtonSelection(sender)

        // If '=' is pressed, perform the calculation
        if operationValue == "=" {
            if let first = firstOperand, let second = Int(currentInput), let op = operation {
                let result = performOperation(op: op, first: first, second: second)
                currentInput = "\(result)"
                delegate?.customKeyboard(self, didEnterAmount: currentInput)
                firstOperand = nil
                secondOperand = nil
                operation = nil
                resetOperationButtonSelection()
            }
        } else {
            if let first = Int(currentInput) {
                firstOperand = first
                operation = operationValue
                currentInput = ""
            }
        }
    }

    // MARK: - Helper Functions
    private func performOperation(op: String, first: Int, second: Int) -> Int {
        switch op {
        case "+": return first + second
        case "-": return first - second
        case "×": return first * second
        case "÷": return first / second
        default: return second
        }
    }

    private func convertPredefinedAmountToNumber(_ amount: String) -> Int {
        switch amount {
        case "5천": return 5000
        case "1만": return 10000
        case "5만": return 50000
        case "10만": return 100000
        case "50만": return 500000
        default: return 0
        }
    }

    private func updateOperationButtonSelection(_ selectedButton: UIButton) {
        if let previousButton = selectedOperationButton {
            previousButton.backgroundColor = .white
        }

        selectedButton.backgroundColor = .akkinGreen
        selectedOperationButton = selectedButton
    }

    private func resetOperationButtonSelection() {
        selectedOperationButton?.backgroundColor = .white
        selectedOperationButton = nil
    }

    private static func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }

    private func addRow(to stackView: UIStackView, titles: [String], action: Selector?) {
        let rowStackView = CustomKeyboardViewController.createStackView(axis: .horizontal)
        addButtons(to: rowStackView, titles: titles, action: action)
        stackView.addArrangedSubview(rowStackView)
    }

    private func addButtons(to stackView: UIStackView, titles: [String], action: Selector?) {
        titles.forEach { title in
            let button = createButton(title: title, action: action)
            stackView.addArrangedSubview(button)
        }
    }

    private func createButton(title: String, action: Selector?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        if let action = action {
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        return button
    }
}
