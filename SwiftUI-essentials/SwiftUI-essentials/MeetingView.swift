//
//  ContentView.swift
//  SwiftUI-essentials
//
//  Created by yeonsu on 2023/08/02.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    /**
     * 속성을 @StateObject로 래핑하는 것은 뷰가 해당 개체에 대한 소스를 지닌다는 의미
     * ScrumTimer() 객체는 ObservableObject 프로토콜 준수
     * ScrumTimer를 MeetingView의 라이프사이클에 연결
     */
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaing: scrumTimer.secondsRemaining, theme: scrum.theme)
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
        
        // 라이프사이클에 따른 동작
        .onAppear {
            startScrum()
        }
        .onDisappear {
            endScrum()
        }
    }
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.startScrum()
        
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
