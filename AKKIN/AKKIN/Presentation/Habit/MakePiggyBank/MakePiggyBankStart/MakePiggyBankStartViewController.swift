//
//  MakePiggyBankStartViewController.swift
//  AKKIN
//
//  Created by 신종원 on 9/14/24.
//

import UIKit

final class MakePiggyBankStartViewController: BaseViewController, UITextFieldDelegate {

    // MARK: UI Components
    private let makePiggyBankStartView = MakePiggyBankStartView()


    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        router.viewController = self
        adjustCompleteButtonUI(isKeyboardVisible: false)

        makePiggyBankStartView.periodTextField.delegate = self
        makePiggyBankStartView.budgetTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(makePiggyBankStartView)

        makePiggyBankStartView.backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
        makePiggyBankStartView.tapPiggyBankNextButton = { [weak self] in
            guard let self else { return }
            router.popToMakePiggyBankEndViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        makePiggyBankStartView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: Event
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            moveCompleteButtonAboveKeyboard(keyboardHeight)
        }
        adjustCompleteButtonUI(isKeyboardVisible: true)
    }

    // 키보드가 사라질 때 호출되게함
    @objc func keyboardWillHide(_ notification: Notification) {
        resetCompleteButtonPosition()
        adjustCompleteButtonUI(isKeyboardVisible: false)
    }
    func resetCompleteButtonPosition() {
        UIView.animate(withDuration: 0.3) {
            self.makePiggyBankStartView.piggyBankNextButton.transform = .identity
        }
    }

    // 완료 버튼을 키보드 위로 이동 - 조정 필요
    func moveCompleteButtonAboveKeyboard(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.makePiggyBankStartView.piggyBankNextButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 108)
        }
    }

   // 완료 버튼의 UI를 키보드 상태에 맞게 조정
   func adjustCompleteButtonUI(isKeyboardVisible: Bool) {
       if isKeyboardVisible {
           makePiggyBankStartView.piggyBankNextButton.setCompleteButton(inputTitle: "다음")
           makePiggyBankStartView.piggyBankNextButton.isEnabled = false
           makePiggyBankStartView.piggyBankNextButton.snp.updateConstraints {
               $0.horizontalEdges.equalToSuperview()
           }
       } else {
           makePiggyBankStartView.piggyBankNextButton.setGuideButton("완료")
           makePiggyBankStartView.piggyBankNextButton.isEnabled = false
           makePiggyBankStartView.piggyBankNextButton.snp.updateConstraints {
               $0.bottom.equalToSuperview().inset(24)
               $0.horizontalEdges.equalToSuperview().inset(20)
           }

       }
   }
}
