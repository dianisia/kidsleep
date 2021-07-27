import Foundation
import RxSwift
import RxCocoa

extension StoriesViewModel {
    struct Output {
        let stories: BehaviorRelay<[Story]>
    }
}

final class StoriesViewModel: ViewModelType {
    private var serviceProvider: ServiceProviderType
    // Dirty hack
    private var stories = BehaviorRelay<[Story]>(
        value: [
            Story(id: "", title: "", text: "", imageURL: URL(string: "")),
            Story(id: "", title: "", text: "", imageURL: URL(string: "")),
            Story(id: "", title: "", text: "", imageURL: URL(string: ""))
        ])
    
    init(serviceProvider: ServiceProviderType) {
        self.serviceProvider = serviceProvider
    }

    func transform() -> Output {
        requestStories()
        return Output(stories: stories)
    }
    
    private func requestStories() {
        DispatchQueue.global(qos: .utility).async {[weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.serviceProvider.apiService.getStories { error, result in
                guard error == nil, let result = result, result.count > 0 else {
                    return strongSelf.stories.accept([])
                }
                strongSelf.stories.accept(result)
            }
        }
    }
}
