//
//  BaseCalendarView.swift
//  AKKIN
//
//  Created by 성현주 on 9/7/24.
//

import UIKit
import FSCalendar
import SnapKit

enum CalendarMode {
    case plan
    case calendar
}

class BaseCalendarView: UIView {

    private var firstDate: Date?    // 배열 중 첫번째 날짜
    private var lastDate: Date?     // 배열 중 마지막 날짜
    private var datesRange: [Date] = [] // 선택된 날짜 배열
    var singleDate: Bool = false

    var savingsData: [Savings] = []

    var calendarMode: CalendarMode = .plan
    var onDatesSelected: (([Date]) -> Void)?
    var onDateSelected: ((Date) -> Void)?

    let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)

        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = .systemBackground
        calendar.scrollEnabled = true
        calendar.scrollDirection = .vertical

        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleAlignment = .left
        calendar.headerHeight = 40.0

        calendar.appearance.titleTodayColor = .akkinGreen
        calendar.appearance.todayColor = .clear
        calendar.appearance.selectionColor = .clear
        calendar.appearance.titleSelectionColor = .black
        calendar.appearance.weekdayTextColor = .akkinGray7.withAlphaComponent(0.3)

        calendar.appearance.titleFont =  UIFont.systemFont(ofSize: 18, weight: .medium)
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20, weight: .medium)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 18, weight: .medium)


        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.allowsMultipleSelection = true

        return calendar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.description())

        calendar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setSavingsData(data: [Savings]) {
        savingsData = data
        calendar.reloadData()
    }

    func resetSelection() {
        for day in datesRange {
            calendar.deselect(day)
        }
        firstDate = nil
        lastDate = nil
        datesRange = []
        calendar.reloadData()
    }

    func scrollToDate() {
        let formatter = DateFormatter()
        calendar.setCurrentPage(Date(), animated: true)
    }
}

// 날짜 선택 따른 뒷배경 설정을 위한 enum 정의했습니다
enum SelectedDateType {
    case singleDate    // 날짜 하나만 선택된 경우 (원 모양 배경)
    case firstDate     // 여러 날짜 선택 시 맨 처음 날짜
    case middleDate    // 여러 날짜 선택 시 맨 처음, 마지막을 제외한 중간 날짜
    case lastDate      // 여러 날짜 선택 시 맨 마지막 날짜
    case notSelected   // 선택되지 않은 날짜
}

// FSCalendarDataSource 구현
extension BaseCalendarView: FSCalendarDataSource {
    func typeOfDate(_ date: Date) -> SelectedDateType {
        if !datesRange.contains(date) {
            return .notSelected
        }

        if datesRange.count == 1 && date == firstDate {
            return .singleDate
        }

        if date == firstDate {
            return .firstDate
        }

        if date == lastDate {
            return .lastDate
        }

        return .middleDate
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.description(), for: date, at: position) as? CalendarCell else {
            return FSCalendarCell()
        }
        switch calendarMode {
        case .plan:
            cell.expenseLabel.isHidden = true
            cell.updateBackImage(typeOfDate(date))
        case .calendar:
            cell.updateBackImage(.notSelected)

            let matchingSavings = savingsData.first { savings in
                Calendar.current.isDate(DateFormatter.localizedStringToDate(savings.date) ?? Date(), inSameDayAs: date)
            }

            cell.configureExpenseLabel(for: matchingSavings)
        }
        return cell
    }
}

extension BaseCalendarView: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        switch calendarMode {
        case .calendar:
            onDateSelected?(date)
        case .plan:
            if singleDate {
                resetSelection()
                firstDate = date
                datesRange = [firstDate!]
                calendar.select(firstDate!)
                onDatesSelected?(datesRange)
                calendar.reloadData()
                return
            }

            // case 1. 현재 아무것도 선택되지 않은 경우
            if firstDate == nil {
                firstDate = date
                datesRange = [firstDate!]
                onDatesSelected?(datesRange)
                calendar.reloadData()
                return
            }

            if singleDate {
                resetSelection()
                firstDate = date
                datesRange = [firstDate!]
                calendar.select(firstDate!)
                onDatesSelected?(datesRange)
                calendar.reloadData()
                return
            }

            // case 2. 현재 firstDate 하나만 선택된 경우
            if firstDate != nil && lastDate == nil {
                if date < firstDate! {
                    calendar.deselect(firstDate!)
                    firstDate = date
                    datesRange = [firstDate!]
                    onDatesSelected?(datesRange)
                    calendar.reloadData()
                    return
                }
            }

            // case 2. 현재 firstDate 하나만 선택된 경우
            if firstDate != nil && lastDate == nil {
                if date < firstDate! {
                    calendar.deselect(firstDate!)
                    firstDate = date
                    datesRange = [firstDate!]
                    onDatesSelected?(datesRange)
                    calendar.reloadData()
                    return
                } else {
                    var range: [Date] = []
                    var currentDate = firstDate!
                    while currentDate <= date {
                        range.append(currentDate)
                        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                    }

                    for day in range {
                        calendar.select(day)
                    }

                    lastDate = range.last
                    datesRange = range
                    onDatesSelected?(datesRange)
                    calendar.reloadData()
                    return
                }
            }

            // case 3. 두 개가 모두 선택되어 있는 상태 -> 현재 선택된 날짜 모두 해제 후 선택 날짜를 firstDate로 서정
            if firstDate != nil && lastDate != nil {
                for day in calendar.selectedDates {
                    calendar.deselect(day)
                }

                lastDate = nil
                firstDate = date
                calendar.select(date)
                datesRange = [firstDate!]
                onDatesSelected?(datesRange)
                calendar.reloadData()
                return
            }
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        resetSelection()
        onDatesSelected?(datesRange)
    }
}
