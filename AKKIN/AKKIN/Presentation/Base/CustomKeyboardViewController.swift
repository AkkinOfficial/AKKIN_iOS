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

    private let predefinedAmountsStackView = createStackView(axis: .horizontal, spacing: 8)
    private let keypadStackView = createStackView(axis: .vertical, spacing: 8)
    private let operationsStackView = createStackView(axis: .vertical, spacing: 0)

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
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.75)
        }

        operationsStackView.snp.makeConstraints { make in
            make.leading.equalTo(keypadStackView.snp.trailing).offset(8)
            make.trailing.equalTo(view)
            make.top.bottom.equalTo(keypadStackView)
        }
    }

    // MARK: - Event
    @objc private func amountButtonTapped(_ sender: UIButton) {
        guard let amountText = sender.title(for: .normal) else { return }
        let amount = convertPredefinedAmountToNumber(amountText)
        currentInput = "\(amount)"
        addCommas()
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
        addCommas()
    }

    @objc private func operationButtonTapped(_ sender: UIButton) {
        guard let operationValue = sender.title(for: .normal) else { return }

        updateOperationButtonSelection(sender)

        if operationValue == "=" {
            if let first = firstOperand, let second = Int(currentInput), let op = operation {
                let result = performOperation(op: op, first: first, second: second)
                currentInput = "\(result)"
                addCommas()
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

    // MARK: - Function
    private func performOperation(op: String, first: Int, second: Int) -> Int {
        switch op {
        case "+": return first + second
        case "-": return first - second
        case "×": return first * second
        case "÷":
            if second == 0 {
                showAlertForDivisionByZero()
                return first
            }
            return first / second
        default: return second
        }
    }

    //TODO: divisionZero 예외처리 논의해서 반영하기
    private func showAlertForDivisionByZero() {
        let alert = UIAlertController(title: "오류", message: "0으로 나눌수 없어요😭", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
            previousButton.setTitleColor(.akkinGray2, for: .normal)
        }

        selectedButton.backgroundColor = .akkinGreen
        selectedButton.setTitleColor(.white, for: .normal)
        selectedOperationButton = selectedButton
    }

    private func resetOperationButtonSelection() {
        selectedOperationButton?.backgroundColor = .white
        selectedOperationButton?.setTitleColor(.akkinGray2, for: .normal)
        selectedOperationButton = nil
    }

    private static func createStackView(axis: NSLayoutConstraint.Axis, spacing: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = CGFloat(spacing)
        stackView.distribution = .fillEqually
        return stackView
    }

    private func addRow(to stackView: UIStackView, titles: [String], action: Selector?) {
        let rowStackView = CustomKeyboardViewController.createStackView(axis: .horizontal, spacing: 8)
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
        button.layer.cornerRadius = 8

        if numbers.flatMap({ $0 }).contains(title) || operations.compactMap({ $0 }).contains(title) {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            button.layer.borderWidth = 0
            button.layer.cornerRadius = 0
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        if  operations.compactMap({ $0 }).contains(title) {
            button.setTitleColor(.akkinGray2, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        }


        if let action = action {
            button.addTarget(self, action: action, for: .touchUpInside)
        }

        return button
    }


    private func addCommas() {
        let formattedAmount = addCommas(to: currentInput)
        delegate?.customKeyboard(self, didEnterAmount: formattedAmount)
    }

    private func addCommas(to amount: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","

        let cleanedText = amount.replacingOccurrences(of: ",", with: "")
        if let number = Double(cleanedText) {
            return numberFormatter.string(from: NSNumber(value: number)) ?? amount
        }
        return amount
    }
}
