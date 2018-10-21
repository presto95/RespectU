//
//  Date+.swift
//  RespectU
//
//  Created by Presto on 21/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import Foundation

extension Date {
    static func day(beforeDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -beforeDays, to: Date()) ?? Date()
    }
    
    static func day(afterDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: afterDays, to: Date()) ?? Date()
    }
    
    static func start(of day: Date) -> Date {
        return Calendar.current.startOfDay(for: day)
    }
    
    static func end(of day: Date) -> Date {
        let components = DateComponents(day: 1, second: -1)
        return Calendar.current.date(byAdding: components, to: day) ?? Date()
    }
}
