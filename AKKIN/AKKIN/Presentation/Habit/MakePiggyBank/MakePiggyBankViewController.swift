//
//  MakePiggyBankViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class MakePiggyBankViewController: BaseViewController, UITextFieldDelegate {

    // MARK: UI Components
    private let makePiggyBankStartView = MakePiggyBankStartView()
    private let makePiggyBankEndView = MakePiggyBankEndView()
    private let makePiggyBankCompleteView = MakePiggyBankCompleteView()

    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    // MARK: Environment
    private let router = BaseRouter()

    let segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["First View", "Second View"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return sc
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setupLayout()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(makePiggyBankStartView)

        backButton.tap = { [self] in
            router.popToRootViewController()
        }
        makePiggyBankStartView.tapPiggyBankNextButton = { [weak self] in
            guard let self else { return }

        }
    }
    func setupLayout() {
        // Add UISegmentedControl to view
        view.addSubview(segmentControl)
        segmentControl.frame = CGRect(x: 50, y: 100, width: view.frame.width - 100, height: 40)
    }

    // MARK: Layout
    override func makeConstraints() {
        makePiggyBankStartView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        self.navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "저금통"

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .akkinWhite
        appearance.shadowColor = nil

        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    // MARK: Event
    @objc func segmentChanged() {
        if segmentControl.selectedSegmentIndex == 0 {
            // 첫 번째 뷰를 보여줌
            switchToView(makePiggyBankStartView)
        } else {
            // 두 번째 뷰를 보여줌
            switchToView(makePiggyBankEndView)
        }
    }
    func switchToView(_ toView: UIView) {
        // 기존 서브뷰들을 모두 제거하고 새로운 뷰를 추가
        view.subviews.forEach { subview in
            if subview != segmentControl {
                subview.removeFromSuperview()
            }
        }
        view.addSubview(toView)
        view.bringSubviewToFront(segmentControl)

        // 새로 추가된 뷰의 프레임을 설정
        toView.frame = view.bounds
        toView.frame.origin.y = segmentControl.frame.maxY + 20
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        makePiggyBankStartView.piggyBankNextButton.isEnabled = !currentText.isEmpty 
        // 텍스트가 비어있지 않을 때만 버튼 활성화
        return true
    }
}
