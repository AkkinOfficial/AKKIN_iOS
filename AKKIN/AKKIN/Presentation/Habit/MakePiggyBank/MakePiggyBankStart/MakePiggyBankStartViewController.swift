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

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(makePiggyBankStartView)

        makePiggyBankStartView.backButton.tapBack = { [self] in
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

    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height

            // 키보드 위에 완료 버튼 위치 설정
            UIView.animate(withDuration: 0.3) {
                self.makePiggyBankStartView.piggyBankNextButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 144)
            }
        }
    }

    // 키보드가 사라질 때 호출되는 메서드
    @objc func keyboardWillHide(_ notification: NSNotification) {
        // 완료 버튼 원래 위치로 복원
        UIView.animate(withDuration: 0.3) {
            self.makePiggyBankStartView.piggyBankNextButton.transform = .identity
        }
    }
}
