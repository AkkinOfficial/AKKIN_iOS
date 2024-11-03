//
//  SetPeriodViewController.swift
//  AKKIN
//
//  Created by 성현주 on 8/16/24.
//

import UIKit

protocol SetPeriodViewControllerDelegate: AnyObject {
    func didSelectDates(startDate: String, endDate: String, duration: String)
}

final class SetPeriodViewController: BaseViewController {

    // MARK: UI Components
    private let setPeriodView = SetPeriodView()

    // MARK: Properties
    weak var delegate: SetPeriodViewControllerDelegate?
    private var selectedStartDate: String = ""
    private var selectedEndDate: String = ""
    private var selectedDuration: String = "ㅇㅇ"
    private let singleDate: Bool

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Initializer
    init(singleDate: Bool) {
        self.singleDate = singleDate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        if singleDate == true{
            setPeriodView.selectDateLabel.text = "지출 날짜를 선택해주세요."
            setPeriodView.dateDivideLabel.text = ""
        }
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(setPeriodView)
        setUpCalendarView()

        setPeriodView.tapConfirm = { [weak self] in
            guard let self = self else { return }
            router.dismissViewController()
            self.delegate?.didSelectDates(startDate: self.selectedStartDate,
                                          endDate: self.selectedEndDate,
                                          duration: self.selectedDuration)
            setPeriodView.calendarView.scrollToDate()
        }

        setPeriodView.tapToday = { [weak self] in
            guard let self = self else { return }
            setPeriodView.calendarView.scrollToDate()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        setPeriodView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Method
    func setUpCalendarView() {
        setPeriodView.calendarView.singleDate = singleDate
        setPeriodView.calendarView.onDatesSelected = { [weak self] selectedDates in
            guard let self = self else { return }
            print(selectedDates)
            self.handleDateSelection(selectedDates: selectedDates)
        }
    }

    private func handleDateSelection(selectedDates: [Date]) {
        switch selectedDates.count {
        case 0:
            resetDateSelection()
        case 1:
            handleSingleDateSelection(startDate: selectedDates.first)
        default:
            if !singleDate {
                handleRangeDateSelection(startDate: selectedDates.first, endDate: selectedDates.last)
            }
        }
    }

    private func resetDateSelection() {
        setPeriodView.confirmButton.isEnabled = false
        setPeriodView.startDateLabel.text = ""
        setPeriodView.endDateLabel.text = ""
        setPeriodView.selectDateLabel.text = "시작일을 선택해주세요"
    }

    private func handleSingleDateSelection(startDate: Date?) {
        didUpdateDates(startDate: startDate, endDate: nil)
        if(singleDate == true){
            setPeriodView.confirmButton.isEnabled = true
        }else{
            setPeriodView.confirmButton.isEnabled = false
        }
        setPeriodView.selectDateLabel.text = singleDate ? "지출 날짜를 선택해주세요." : "종료일을 선택해주세요."
    }

    private func handleRangeDateSelection(startDate: Date?, endDate: Date?) {
        didUpdateDates(startDate: startDate, endDate: endDate)
        setPeriodView.confirmButton.isEnabled = true
    }
}

extension SetPeriodViewController: SetPeriodViewDelegate {
    func didUpdateDates(startDate: Date?, endDate: Date?) {
        let viewDateFormatter = DateFormatter()
        viewDateFormatter.dateFormat = "MM월 dd일"

        let passDateFormatter = DateFormatter()
        passDateFormatter.dateFormat = "YYYY-MM-dd"

        selectedStartDate = startDate.map { passDateFormatter.string(from: $0) } ?? ""
        selectedEndDate = endDate.map { passDateFormatter.string(from: $0) } ?? ""
        selectedDuration = calculateDuration(from: startDate, to: endDate)

        setPeriodView.startDateLabel.text = startDate.map { viewDateFormatter.string(from: $0) } ?? ""
        setPeriodView.endDateLabel.text = endDate.map { viewDateFormatter.string(from: $0) } ?? ""
        setPeriodView.endDateLabel.text = selectedEndDate.isEmpty ? "" : "\(viewDateFormatter.string(from: endDate!)) (\(selectedDuration))"
    }


    private func calculateDuration(from startDate: Date?, to endDate: Date?) -> String {
        guard let startDate = startDate, let endDate = endDate else {
            return ""
        }
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return "\(days + 1)일"
    }
}

