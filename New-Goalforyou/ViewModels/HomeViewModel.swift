//
//  HomeViewModel.swift
//  New-Goalforyou
//
//  Created by KIM Hyung Jun on 1/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    let selectedDate = PublishSubject<Date>()
    let calendarEvents = BehaviorSubject<[CalendarEvent]>(value: [])
    
    func selectDate(_ date: Date) {
        selectedDate.onNext(date)
    }

}
