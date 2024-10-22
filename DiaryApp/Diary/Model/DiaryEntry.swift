//
//  DiaryEntry.swift
//  aidiary
//
//  Created by 박지원 on 8/21/24.
//

import SwiftUI

struct DiaryEntry: Identifiable, Codable, Hashable {
    var id = UUID()
    var date: Date
    var emotion : String
    var content: String
}
