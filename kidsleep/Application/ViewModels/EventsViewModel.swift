import Foundation
import RxSwift
import RxCocoa

struct EventInput {
    var label: String
    var value: String
    var type: EventType?
}

final class EventsViewModel: ViewModelType {
    private var user: UserInfo
    
    struct Output {
        let events: Driver<[EventInput]>
    }
    
    init() {
        let repository = UserDefaultsRepository()
        user = repository.get()
    }
    
    func transform() -> Output {
        let data = user.events.map { EventInput(
            label: $0.title,
            value: Converter.minutesToString(totalMinutes: $0.value),
            type: $0.type
        ) }
        return Output(events: Driver.just(data))
    }
}
