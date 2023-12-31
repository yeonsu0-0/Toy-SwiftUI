//
//  DailyScrum.swift
//  SwiftUI-essentials
//
//  Created by yeonsu on 2023/08/02.
//

import Foundation

/** ✨ UUID
  * List는 각 요소마다 고유의 값을 할당해줘야 한다.
  * 스크럼 각각 고유의 값을 갖게 하려면 Identifiable 프로토콜을 채택하고, id 속성을 추가해주면 된다
  */

/** ✨ Codable
  * Codable은 인코딩 / 디코딩 기능 프로토콜을 결합한 유형의 별칭
  * Codable API를 사용해서 쉽게 데이터를 JSON으로 직렬화할 수 있다
 */

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    // 슬라이더 값을 계산 속성으로 지정
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
}


extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design",
                           attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                           lengthInMinutes: 10,
                           theme: .yellow),
                DailyScrum(title: "App Dev",
                           attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
                           lengthInMinutes: 5,
                           theme: .orange),
                DailyScrum(title: "Web Dev",
                           attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
                           lengthInMinutes: 5,
                           theme: .poppy)
    ]
}
