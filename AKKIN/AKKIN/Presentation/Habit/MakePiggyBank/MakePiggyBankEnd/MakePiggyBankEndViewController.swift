//
//  MakePiggyBankEndViewController.swift
//  AKKIN
//
//  Created by 신종원 on 9/14/24.
//

import UIKit

final class MakePiggyBankEndViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate {

    // MARK: UI Components
    private let makePiggyBankEndView = MakePiggyBankEndView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        router.viewController = self
        adjustCompleteButtonUI(isKeyboardVisible: false)

        makePiggyBankEndView.nameTextField.delegate = self
        makePiggyBankEndView.memoTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(makePiggyBankEndView)
        hideKeyboard()

        makePiggyBankEndView.backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
        makePiggyBankEndView.tapPiggyBankNextButton = { [weak self] in
            guard let self else { return }
            router.popToMakePiggyBankCompleteViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        makePiggyBankEndView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: Event
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            moveCompleteButtonAboveKeyboard(keyboardHeight)
        }
        adjustCompleteButtonUI(isKeyboardVisible: true)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        resetCompleteButtonPosition()
        adjustCompleteButtonUI(isKeyboardVisible: false)
    }
    func resetCompleteButtonPosition() {
        UIView.animate(withDuration: 0.3) {
            self.makePiggyBankEndView.piggyBankNextButton.transform = .identity
        }
    }

    // 완료 버튼을 키보드 위로 이동 - 조정 필요
    func moveCompleteButtonAboveKeyboard(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.makePiggyBankEndView.piggyBankNextButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 108)
        }
    }

   // 완료 버튼의 UI를 키보드 상태에 맞게 조정
   func adjustCompleteButtonUI(isKeyboardVisible: Bool) {
       if isKeyboardVisible {
           makePiggyBankEndView.piggyBankNextButton.setCompleteButton(inputTitle: "다음")
           makePiggyBankEndView.piggyBankNextButton.snp.updateConstraints {
               $0.horizontalEdges.equalToSuperview()
           }
           makePiggyBankEndView.piggyBankNextButton.isEnabled = makePiggyBankEndView.confirmState
       } else {
           makePiggyBankEndView.piggyBankNextButton.setGuideButton("완료")
           makePiggyBankEndView.piggyBankNextButton.snp.updateConstraints {
               $0.bottom.equalToSuperview().inset(24)
               $0.horizontalEdges.equalToSuperview().inset(20)
           }
           makePiggyBankEndView.piggyBankNextButton.isEnabled = makePiggyBankEndView.confirmState
       }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == makePiggyBankEndView.nameTextField {
            makePiggyBankEndView.nameCountLabel.isHidden = false
            makePiggyBankEndView.memoTextField.snp.updateConstraints {
                $0.top.equalTo(makePiggyBankEndView.nameTextField.snp.bottom).offset(38)
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == makePiggyBankEndView.nameTextField {
            makePiggyBankEndView.nameCountLabel.isHidden = true
        } else if textField == makePiggyBankEndView.memoTextField {
            makePiggyBankEndView.memoCountLabel.isHidden = true
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxNameCharCount = 15
        let maxMemoCharCount = 40
        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        if textField == makePiggyBankEndView.nameTextField {
            if updatedText.count <= maxNameCharCount {
                makePiggyBankEndView.nameCountLabel.text = "\(updatedText.count)/\(maxNameCharCount)"
                let attributedString = NSMutableAttributedString(string: "\(updatedText.count)/\(maxNameCharCount)")
                attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: NSRange(location: 0, length: "\(updatedText.count)".count))
                attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: "\(updatedText.count)".count, length: "/\(maxMemoCharCount)".count))
                makePiggyBankEndView.nameCountLabel.attributedText = attributedString
                return true
            } else {
                return false
            }
        }
        if textField == makePiggyBankEndView.memoTextField {
            if updatedText.count <= maxMemoCharCount {
                makePiggyBankEndView.memoCountLabel.text = "\(updatedText.count)/\(maxMemoCharCount)"
                let attributedString = NSMutableAttributedString(string: "\(updatedText.count)/\(maxMemoCharCount)")
                attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: NSRange(location: 0, length: "\(updatedText.count)".count))
                attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: "\(updatedText.count)".count, length: "/\(maxMemoCharCount)".count))
                makePiggyBankEndView.memoCountLabel.attributedText = attributedString
                return true
            } else {
                return false
            }
        }
        return false
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if
            textView == makePiggyBankEndView.memoTextField {
            makePiggyBankEndView.memoCountLabel.isHidden = false
            makePiggyBankEndView.memoTextField.snp.updateConstraints {
                $0.top.equalTo(makePiggyBankEndView.nameTextField.snp.bottom).offset(12)
            }
            textView.text = ""
            textView.textColor = .black
            textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
        makePiggyBankEndView.confirmState = !(makePiggyBankEndView.nameTextField.text?.isEmpty ?? true) && !textView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "절약 다짐(선택)"
            textView.textColor = .akkinGray6
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        let maxMemoCharCount = 40
        let currentText = textView.text ?? ""
        if currentText.count > maxMemoCharCount {
            textView.text = String(currentText.prefix(maxMemoCharCount))
        }
        makePiggyBankEndView.confirmState = !(makePiggyBankEndView.nameTextField.text?.isEmpty ?? true) && !textView.text.isEmpty
        makePiggyBankEndView.piggyBankNextButton.isEnabled = makePiggyBankEndView.confirmState
        print("텍필뷰: \(makePiggyBankEndView.nameTextField.text?.isEmpty ?? true)")
        print("텍뷰: \(textView.text.isEmpty)")
        updateMemoCountLabel()
    }
    private func updateMemoCountLabel() {
        let maxMemoCharCount = 40
        let currentText = makePiggyBankEndView.memoTextField.text ?? ""
        makePiggyBankEndView.memoCountLabel.text = "\(currentText.count)/\(maxMemoCharCount)"

        let attributedString = NSMutableAttributedString(string: "\(currentText.count)/\(maxMemoCharCount)")
        attributedString.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: NSRange(location: 0, length: "\(currentText.count)".count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: "\(currentText.count)".count, length: "/\(maxMemoCharCount)".count))
        makePiggyBankEndView.memoCountLabel.attributedText = attributedString
    }
}
