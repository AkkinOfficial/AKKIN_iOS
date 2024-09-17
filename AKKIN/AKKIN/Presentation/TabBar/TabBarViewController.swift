//
//  TabBarViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

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
    let homeViewController = EmptyHomeViewController()
    let habitViewController = HabitViewController()
    let calendarViewController = CalendarViewController()
    let myPageViewController = MyPageViewController()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarViewController()
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
    private func setupTabBarViewController() {
        homeViewController.title = "홈"
        habitViewController.title = "소비습관"
        calendarViewController.title = "캘린더"
        myPageViewController.title = "MY"
        
        setupTabBarItem(for: homeViewController, image: AkkinIcon.home, selectedImage: AkkinIcon.homeFilled.withRenderingMode(.alwaysOriginal))
        setupTabBarItem(for: habitViewController, image: AkkinIcon.habit, selectedImage: AkkinIcon.habitFilled.withRenderingMode(.alwaysOriginal))
        setupTabBarItem(for: calendarViewController, image: AkkinIcon.calendar, selectedImage: AkkinIcon.calendarFilled.withRenderingMode(.alwaysOriginal))
        setupTabBarItem(for: myPageViewController, image: AkkinIcon.my, selectedImage: AkkinIcon.myFilled)

        let navigationHome = UINavigationController(rootViewController: homeViewController)
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
}
