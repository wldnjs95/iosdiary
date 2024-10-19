//
//  DayModel.swift
//  Playground
//
//  Created by LiYen Huang on 9/19/24.
//
import Foundation

struct DayModel: Identifiable {
    var id: UUID = UUID()
    
    var date: Date
    var hasEvent: Bool
   
    init(date: Date){
        self.date = date
        self.hasEvent = false
    }
}
