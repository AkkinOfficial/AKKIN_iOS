//
//  UITextField+Extension.swift
//  AKKIN
//
//  Created by 성현주 on 9/2/24.
//

import UIKit

extension UITextField {

    /// 글자 시작위치 변경
    func addLeftPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    /// border 설정
    func setRoundBorder() {
        layer.cornerRadius = 16
    }

    /// 좌측 이미지 추가
    func addLeftImage(image: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        leftImageView.image = image

        // 패딩 값 추가
        let padding: CGFloat = 16.0
        let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: leftImageView.frame.width + padding + 8.0 , height: leftImageView.frame.height ))
        leftImageView.frame.origin = CGPoint(x: padding, y: 0)
        leftImageView.contentMode = .scaleAspectFit

        paddingLeftView.addSubview(leftImageView)
        self.leftView = paddingLeftView
        self.leftViewMode = .always

    }

}
