import SwiftUI

struct DiaryEntryDetailView: View {
    @Binding var entry: DiaryEntry // 바인딩을 통해 데이터 수정 가능

    @State private var isEditing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(entry.date, style: .date)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text("Emotion: \(entry.emotion)")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            Text(entry.content)
                .font(.body)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Diary Entry")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    isEditing = true
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditDiaryEntryView(diaryEntry: $entry)
        }
    }
}

struct DiaryEntryDetailView_Previews: PreviewProvider {
    @State static var sampleEntry = DiaryEntry(date: Date(), emotion: "Happy", content: "Today was a great day!")

    static var previews: some View {
        DiaryEntryDetailView(entry: $sampleEntry)
    }
}
