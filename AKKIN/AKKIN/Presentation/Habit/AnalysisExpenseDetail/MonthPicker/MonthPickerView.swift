//
//  MonthPickerView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/28/24.
//

import UIKit

class MonthPickerView: BaseView, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerView = UIPickerView()
    var selectedYear = Calendar.current.component(.year, from: Date())
    var selectedMonth = Calendar.current.component(.month, from: Date())

    let years = Array(2021...2024)
    let months = Array(1...12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPickerView()
    }

    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self

        addSubview(pickerView)

        pickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // 현재 년, 월 설정
        if let monthIndex = months.firstIndex(of: selectedMonth),
           let yearIndex = years.firstIndex(of: selectedYear) {
            pickerView.selectRow(monthIndex, inComponent: 0, animated: false)
            pickerView.selectRow(yearIndex, inComponent: 1, animated: false)
        }
    }

    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return months.count
        } else {
            return years.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }

    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(months[row])월"
        } else {
            return "\(years[row])"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedMonth = months[row]
        } else {
            selectedYear = years[row]
        }

        print("Selected Month: \(selectedMonth), Year: \(selectedYear)")
    }
}
