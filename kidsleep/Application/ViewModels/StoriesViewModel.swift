import Foundation
import RxSwift
import RxCocoa

final class StoriesViewModel: ViewModelType {
    // Dirty hack
    private var stories = BehaviorRelay<[Story]>(
        value: [
            Story(id: "", title: "", text: "", imageURL: URL(string: "")),
            Story(id: "", title: "",text: "", imageURL: URL(string: "")),
            Story(id: "", title: "",text: "", imageURL: URL(string: ""))
        ])

    struct Output {
        let stories: BehaviorRelay<[Story]>
    }
    
    func transform() -> Output {
        requestStories()
        return Output(stories: stories)
    }
    
    private func requestStories() {
        DispatchQueue.global(qos: .utility).async {
            APICaller.shared.getStories {[unowned self] error, result in
                guard error == nil, let result = result, result.count > 0 else {
                    return stories.accept([])
                }
                stories.accept(result)
            }
        }
    }
}
