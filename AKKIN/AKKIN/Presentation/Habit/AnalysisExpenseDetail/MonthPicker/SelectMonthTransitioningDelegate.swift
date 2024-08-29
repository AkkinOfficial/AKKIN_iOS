//
//  SelectMonthTransitioningDelegate.swift
//  AKKIN
//
//  Created by 박지윤 on 8/28/24.
//

import UIKit

final class SelectMonthTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return SelectMonthPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}
