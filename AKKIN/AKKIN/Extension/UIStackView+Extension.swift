//
//  UIStackView+Extension.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
