//
//  MakePiggyBankEndViewController.swift
//  AKKIN
//
//  Created by 신종원 on 9/14/24.
//

import UIKit

final class MakePiggyBankEndViewController: BaseViewController, UITextFieldDelegate {

    // MARK: UI Components
    private let makePiggyBankEndView = MakePiggyBankEndView()

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
        view.addSubview(makePiggyBankEndView)

        makePiggyBankEndView.backButton.tapBack = { [self] in
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
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: Event

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        makePiggyBankEndView.piggyBankNextButton.isEnabled = !currentText.isEmpty
        // 텍스트가 비어있지 않을 때만 버튼 활성화
        return true
    }
}
