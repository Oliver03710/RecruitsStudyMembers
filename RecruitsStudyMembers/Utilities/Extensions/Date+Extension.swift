//
//  Date+Extension.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/12.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
    func toCalendar() -> (year: Int?, month: Int?, day: Int?) {
        let year = Calendar.current.dateComponents([.year], from: self).year
        let month = Calendar.current.dateComponents([.month], from: self).month
        let day = Calendar.current.dateComponents([.day], from: self).day
        
        return (year: year, month: month, day: day)
    }
    
    func calculateDates() -> (year: Int, month: Int, day: Int) {
        guard let targetYear = self.toCalendar().year,
              let targetMonth = self.toCalendar().month,
              let targetDay = self.toCalendar().day,
              let currentYear = Date().toCalendar().year,
              let currentMonth = Date().toCalendar().month,
              let currentDay = Date().toCalendar().day else {
            return (-1, -1 ,-1)
        }
        
        let yearInterval = currentYear - targetYear
        let monthInterval = currentMonth - targetMonth
        let dayInterval = currentDay - targetDay
        
        return (year: yearInterval, month: monthInterval, day: dayInterval)
    }
}
