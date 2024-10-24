import SwiftUI

struct DailyView: View {
    var date: Date
    @State var diaryManager = DiaryManager.shared
    
    
    var diaryEntries: [DiaryEntry] {
        return diaryManager.getEntries(for: date)
    }

    var body: some View {
        ZStack {
            // Background Content ScrollView
            ScrollView {
                VStack(spacing: 16) {
                    if diaryEntries.isEmpty {
                        Text("No entries for today.")
                            .foregroundColor(.gray)
                    }
                    else {
                        ForEach(diaryEntries.indices, id: \.self) { index in
                            var diaryEntry = diaryEntries[index]
                            DiaryEntryRow(entry: .constant(diaryEntry))
                        }
                    }
                }
                .padding()
            }

            // Floating '+' Button to add a new entry
            VStack {
                Spacer()
                Button(action: {
                    // TODO: call new diary entry form
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.bottom, 30)
            }
        }

    }
}

#Preview {
    DailyView(date: Date())
}
