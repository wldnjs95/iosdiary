//
//  DiaryManager.swift
//  DiaryApp
//
//  Created by LiYen Huang on 10/3/24.
//
import Foundation

@Observable
class DiaryManager{
    var diaryEntries: [DiaryEntry] = load("DiaryContent.json")
    
    // Get entry for exact date
    func getEntry(for date: Date) -> DiaryEntry? {
        let calendar = Calendar.current
        return diaryEntries.first { entry in
            calendar.isDate(entry.date, inSameDayAs: date)
        }
    }
}


func load<T: Decodable>(_ filename: String) -> T { // generic type T must conform Decodable protocol
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            // guard statement checks if the file URL was found. If it's nil (file not found), the program will display the message and terminate
            // guard is used to check a condition and ensure that requirements are met early in the function
            // the underscore (_) is used to omit the argument label when calling the function
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load\(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

