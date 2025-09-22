//
//  modalUnitTest.swift
//  modalUnitTest
//
//  Created by 성현주 on 1/15/25.
//

import XCTest
@testable import AKKIN

final class ModalUnitTest: XCTestCase {
    override func setUpWithError() throws {
        // 테스트 초기화
        UserDefaultHandler.dismissModalTime = Date()
    }

    override func tearDownWithError() throws {
        // 테스트 종료 후 정리
        UserDefaultHandler.dismissModalTime = Date()
    }

    func testModalDoesNotTriggerBefore24Hours() throws {
        // 현재 시간을 설정
        let currentTime = Date()

        // 24시간 후의 시간을 dismissModalTime에 설정
        let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: currentTime)!
        UserDefaultHandler.dismissModalTime = futureDate

        // 현재 시간이 24시간 이내인 경우 모달이 호출되지 않아야 함
        XCTAssertFalse(shouldTriggerModal(currentTime: currentTime),
                       "Modal should not trigger before 24 hours.")
    }

    func testModalTriggersAfter24Hours() throws {
        // 현재 시간을 설정
        let currentTime = Date()

        // 24시간 전의 시간을 dismissModalTime에 설정
        let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: currentTime)!
        UserDefaultHandler.dismissModalTime = pastDate

        // 현재 시간이 24시간 이후인 경우 모달이 호출되어야 함
        XCTAssertTrue(shouldTriggerModal(currentTime: currentTime),
                      "Modal should trigger after 24 hours.")

    }

    func testModalTriggersExactlyAt24Hours() throws {
        // 현재 시간을 설정
        let currentTime = Date()

        // 정확히 24시간 전의 시간을 dismissModalTime에 설정
        let exact24HoursAgo = Calendar.current.date(byAdding: .day, value: -1, to: currentTime)!
        UserDefaultHandler.dismissModalTime = exact24HoursAgo

        // 현재 시간이 24시간 이후이므로 모달이 호출되어야 함
        XCTAssertTrue(shouldTriggerModal(currentTime: currentTime),
                      "Modal should trigger exactly 24 hours after the last dismiss time.")
    }

    // Helper Method to Test Modal Triggering Logic
    private func shouldTriggerModal(currentTime: Date) -> Bool {
        let storedTime = UserDefaultHandler.dismissModalTime
        return currentTime > storedTime
    }
}
