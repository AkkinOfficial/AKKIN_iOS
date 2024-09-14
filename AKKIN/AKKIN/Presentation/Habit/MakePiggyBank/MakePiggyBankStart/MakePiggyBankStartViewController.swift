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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        makePiggyBankStartView.piggyBankNextButton.isEnabled = !currentText.isEmpty 
        // 텍스트가 비어있지 않을 때만 버튼 활성화
        return true
    }
}
