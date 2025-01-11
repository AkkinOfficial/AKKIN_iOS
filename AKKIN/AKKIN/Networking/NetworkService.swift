//
//  NetworkService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    let auth = AuthService()
    let main = MainService()
    let home = HomeService()
    let piggyBank = PiggyBankService()
    let gulbis = GulbiService()
    let weekly = WeeklyService()
    let monthly = MonthlyService()
    let analysis = MonthlyAnalysisService()
    let savings = SavingsService()
    let calendar = CalendarService()
    let users = UsersService()
}
