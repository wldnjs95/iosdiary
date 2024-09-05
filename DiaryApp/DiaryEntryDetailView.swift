import SwiftUI

struct DiaryEntryDetailView: View {
    var entry: DiaryEntry // diary to read

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
    }
}

struct DiaryEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryEntryDetailView(entry: DiaryEntry(date: Date(), emotion: "Happy", content: "Today was a great day!"))
    }
}
