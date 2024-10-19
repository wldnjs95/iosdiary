import SwiftUI

struct DailyView: View {
    var date: Date
    @State var diaryManager = DiaryManager()
    
    var body: some View {
        VStack {
            if let diaryEntry = diaryManager.getEntry(for: date) {
                DiaryEntryRow(entry: .constant(diaryEntry)) // Binding으로 전달
            }
            Spacer()
        }
    }
}

#Preview {
    DailyView(date: Date())
}
