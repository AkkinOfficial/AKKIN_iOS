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
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: image.size.height))
        leftImageView.image = image

        // 패딩 값 추가
        let padding: CGFloat = 16.0
        let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: leftImageView.frame.width + padding + 8.0 , height: 20 ))
        leftImageView.frame.origin = CGPoint(x: padding, y: 0)
        leftImageView.contentMode = .scaleAspectFit

        paddingLeftView.addSubview(leftImageView)
        self.leftView = paddingLeftView
        self.leftViewMode = .always

    }
    
    /// 우측 글자 추가
    func addRightLabel(text: String, textColor: UIColor = .akkinGreen) {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 18)
        label.textColor = textColor
        label.sizeToFit()

        let padding: CGFloat = 16.0

        let labelWidth = label.frame.width + padding
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height))
        label.frame.origin = CGPoint(x: 0, y: (self.frame.height - label.frame.height) / 2)

        rightView.addSubview(label)
        self.rightView = rightView
        self.rightViewMode = .always
    }

    /// 좌측 글자 추가
    func addLeftLabel(text: String) {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()

        let padding: CGFloat = 16.0

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: label.frame.width + padding + 8.0, height: self.frame.height))
        label.frame.origin = CGPoint(x: padding, y: (self.frame.height - label.frame.height) / 2)

        leftView.addSubview(label)
        self.leftView = leftView
        self.leftViewMode = .always
    }



    /// 숫자를 세 자리마다 쉼표 추가
    func addCommas() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","

        let cleanedText = self.text?.replacingOccurrences(of: ",", with: "")
        if let number = Double(cleanedText ?? "") {
            self.text = numberFormatter.string(from: NSNumber(value: number))
        }
        self.addTarget(self, action: #selector(formatNumberWithCommasOnChange), for: .editingChanged)
    }

    @objc private func formatNumberWithCommasOnChange() {
        _ = self.text
        addCommas()
    }

    func setUnderLine() {
        let underline = CALayer()
        
        underline.borderWidth = 1.0
        underline.borderColor = UIColor.red.cgColor
        
        underline.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        
        self.layer.addSublayer(underline)
        self.borderStyle = .none
    }
}
