//
//  TabBarViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit
import Moya

class TabBarViewController: UITabBarController {

    // MARK: Constants
    private enum Metric {
        static let tabBarHeight: CGFloat = 90.0
        static let titleFontSize: CGFloat = 11.0
        static let imageTopInset: CGFloat = 0.0
        static let imageBottomInset: CGFloat = -4.0
        static let titleVerticalOffset: CGFloat = 3.0
    }

    // MARK: UI Components
    let emptyHomeViewController = EmptyHomeViewController()
    let homeViewController = HomeViewController()
    let habitViewController = HabitViewController()
    let calendarViewController = CalendarViewController()
    let myPageViewController = MyPageViewController()
    
    // MARK: Environment
    let provider = MoyaProvider<HomeAPI>()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchExpenseSummary()
        setupTabBarViewController(showingEmptyHome: false)
        setupTabBarUI()
    }

    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var tabFrame = tabBar.frame
        tabFrame.size.height = Metric.tabBarHeight
        tabFrame.origin.y = view.frame.size.height - Metric.tabBarHeight
        tabBar.frame = tabFrame
    }

    // MARK: TabBar
    private func setupTabBarViewController(showingEmptyHome: Bool) {
        emptyHomeViewController.title = "홈"
        homeViewController.title = "홈"
        habitViewController.title = "소비습관"
        calendarViewController.title = "캘린더"
        myPageViewController.title = "MY"

        setupTabBarItem(for: emptyHomeViewController, image: AkkinIcon.home, selectedImage: AkkinIcon.homeFilled.withRenderingMode(.alwaysOriginal))
        setupTabBarItem(for: homeViewController, image: AkkinIcon.home, selectedImage: AkkinIcon.homeFilled.withRenderingMode(.alwaysOriginal))
        setupTabBarItem(for: habitViewController, image: AkkinIcon.habit, selectedImage: AkkinIcon.habitFilled.withRenderingMode(.alwaysOriginal))
        setupTabBarItem(for: calendarViewController, image: AkkinIcon.calendar, selectedImage: AkkinIcon.calendarFilled.withRenderingMode(.alwaysOriginal))
        setupTabBarItem(for: myPageViewController, image: AkkinIcon.my, selectedImage: AkkinIcon.myFilled)

        let navigationHome = UINavigationController(rootViewController: showingEmptyHome ? emptyHomeViewController : homeViewController)
        let navigationHabit = UINavigationController(rootViewController: habitViewController)
        let navigationCalendar = UINavigationController(rootViewController: calendarViewController)
        let navigationMyPage = UINavigationController(rootViewController: myPageViewController)

        setViewControllers([navigationHome,
                            navigationHabit,
                            navigationCalendar,
                            navigationMyPage], animated: false)
    }

    private func setupTabBarItem(for viewController: UIViewController, image: UIImage, selectedImage: UIImage) {
        let tabBarItem = UITabBarItem(title: viewController.title, image: image, selectedImage: selectedImage)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: Metric.titleFontSize)], for: .normal)
        tabBarItem.imageInsets = UIEdgeInsets(top: Metric.imageTopInset, left: 0, bottom: Metric.imageBottomInset, right: 0)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: Metric.titleVerticalOffset)
        viewController.tabBarItem = tabBarItem
    }

    private func setupTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .akkinGreen
        tabBar.unselectedItemTintColor = .akkinGray5

        tabBar.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        tabBar.layer.borderWidth = 1

        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }

    private func fetchExpenseSummary() {
        provider.request(.getExpenseSummary(type: "daily")) { [weak self] result in
            switch result {
            case .success(let response):
                if response.statusCode == 404 {
                    print("🍎404")
                    self?.setupTabBarViewController(showingEmptyHome: true)
                } else {
                    print("✅success")
                    self?.setupTabBarViewController(showingEmptyHome: false)
                }
            case .failure(let error):
                print("Error fetching expense summary: \(error.localizedDescription)")
                //TODO: 네트워크 에러뷰 처리
                self?.setupTabBarViewController(showingEmptyHome: true)
            }
        }
    }
}
