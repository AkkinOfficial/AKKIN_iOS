//
//  SelectMonthViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/28/24.
//

import UIKit

protocol SelectMonthViewControllerDelegate: AnyObject {
    func dismissButtonTapped()
}

final class SelectMonthViewController: BaseViewController {
    weak var delegate: SelectMonthViewControllerDelegate?
    private let customTransitioningDelegate = SelectMonthTransitioningDelegate()

    private let monthDatePicker = MonthPickerView()
    private let selectMonthNavigationBar = SelectMonthNavigationBar()

    init() {
        super.init(nibName: nil, bundle: nil)
        setupModalStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        view.addSubview(selectMonthNavigationBar)
        view.addSubview(monthDatePicker)

        selectMonthNavigationBar.tapDismissButton = { [weak self] in
            guard let self else { return }
            delegate?.dismissButtonTapped()

            router.dismissViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        selectMonthNavigationBar.snp.makeConstraints {
            $0.top.width.equalToSuperview()
        }

        monthDatePicker.snp.makeConstraints {
            $0.top.equalTo(selectMonthNavigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupModalStyle() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .coverVertical
        transitioningDelegate = customTransitioningDelegate
    }
}
