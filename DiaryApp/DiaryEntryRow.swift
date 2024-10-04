import SwiftUI

struct DiaryEntryRow: View {
    var detailView: DiaryEntryDetailView // diary to read

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.2))
            .frame(height: 120)
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(detailView.entry.date, style: .date)
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(detailView.entry.content)
                        .font(.body)
                        .foregroundColor(.black)
                        .lineLimit(2)
                }
                .padding()
            )
    }
}


#Preview{
    DiaryEntryRow( detailView: DiaryEntryDetailView(entry: DiaryEntry(date: Date(), emotion: "Happy", content: "Today was a great day!")) )
}
