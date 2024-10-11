import SwiftUI

struct DiaryEntryFormTest: View {
    @Environment(\.dismiss) var dismiss // 폼을 닫는 데 사용하는 환경 변수
    @Binding var diaryEntries: [DiaryEntry] // 메인 화면에서 전달받은 일기 목록 바인딩 변수
    
    @State private var date = Date()
    @State private var selectedEmotion = "😊" // 기본 감정 선택 값
    @State private var content = ""
    
    // 선택 가능한 감정 리스트 (이모지 사용)
    let emotions = ["😊", "😢", "😡", "😌"] // Happy, Sad, Angry, Calm
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                // 연속적인 스크롤과 중앙 선택을 위한 ScrollView
                EmotionPicker(selectedEmotion: $selectedEmotion, emotions: emotions)
                    .frame(height: 100) // 적절한 높이 설정
                
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("New Diary Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newEntry = DiaryEntry(date: date, emotion: selectedEmotion, content: content)
                        diaryEntries.append(newEntry) // 새 일기 항목을 추가
                        dismiss() // 폼 닫기
                    }
                    .disabled(content.isEmpty) // 내용이 비어 있을 때 비활성화
                }
            }
        }
    }
}

// 감정 선택 뷰
struct EmotionPicker: View {
    @Binding var selectedEmotion: String
    let emotions: [String]
    @State private var autoScrollTimer: Timer? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 40) { // 각 이모지 간의 간격 설정
                        ForEach(emotions, id: \.self) { emotion in
                            GeometryReader { itemGeometry in
                                let distance = abs(itemGeometry.frame(in: .global).midX - geometry.size.width / 2)
                                let opacity = 1 - min(distance / (geometry.size.width / 2), 1)
                                
                                Text(emotion)
                                    .font(.system(size: 60))
                                    .opacity(opacity) // 투명도 조정
                                    .id(emotion) // 이모지의 ID 설정
                                    .onTapGesture {
                                        withAnimation {
                                            selectedEmotion = emotion // 사용자가 탭했을 때 선택 업데이트
                                        }
                                    }
                                    .onChange(of: selectedEmotion) { oldEmotion, newEmotion in
                                        withAnimation {
                                            proxy.scrollTo(newEmotion, anchor: .center) // 선택된 이모지를 중앙으로 스크롤
                                        }
                                    }
                            }
                            .frame(width: 80, height: 80) // 각 이모지의 고정 크기
                        }
                    }
                    .padding(.horizontal, (geometry.size.width - 60) / 2) // 스크롤 뷰의 양쪽에 패딩을 추가하여 중앙 정렬 효과
                    .gesture(DragGesture()
                        .onEnded { value in
                            autoScrollToClosestEmotion(geometry: geometry, proxy: proxy)
                        })
                }
            }
        }
    }
    
    // 가장 가까운 이모티콘으로 자동 스크롤
    private func autoScrollToClosestEmotion(geometry: GeometryProxy, proxy: ScrollViewProxy) {
        guard let closestEmotion = emotions.min(by: {
            let dist1 = abs(offsetOf(emotion: $0, geometry: geometry) - geometry.size.width / 2)
            let dist2 = abs(offsetOf(emotion: $1, geometry: geometry) - geometry.size.width / 2)
            return dist1 < dist2
        }) else {
            return
        }
        
        withAnimation {
            selectedEmotion = closestEmotion
            proxy.scrollTo(closestEmotion, anchor: .center) // 선택된 이모티콘을 중앙으로 스크롤
        }
    }
    
    // 이모지의 중앙 위치 계산
    private func offsetOf(emotion: String, geometry: GeometryProxy) -> CGFloat {
        guard let index = emotions.firstIndex(of: emotion) else { return 0 }
        let baseOffset = geometry.size.width / 2
        let spacing: CGFloat = 120 // 이모지 간의 거리 (HStack의 spacing과 맞춰야 함)
        return baseOffset + CGFloat(index) * spacing
    }
}

// SwiftUI Preview
struct DiaryEntryFormTest_Previews: PreviewProvider {
    static var previews: some View {
        DiaryEntryFormTest(diaryEntries: .constant([]))
    }
}
