import Foundation
import Alamofire

final class APICaller {
    static let shared = APICaller()
    struct Constants {
        static let baseUrl = "https://kidsleep-e0e6.restdb.io/rest"
        static let apiKey = "35b8a542e0dd8b221449e3812acc5ef817217"
    }
    
    @discardableResult
    public func getStories(completion: @escaping (Error?, [Story]?) -> Void) -> URLSessionTask? {
        let headers: HTTPHeaders = [
            "content-type": "application/json",
            "x-apikey": Constants.apiKey,
            "cache-control": "no-cache"
        ]
        let storiesURL = "\(Constants.baseUrl)/stories"
        return AF.request(storiesURL, method: .get, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                if let array = value as? [[String: Any]] {
                    var result = [Story]()
                    for val in array {
                        guard let text = val["text"] as? String else {
                            continue
                        }
                        result.append(Story(text: text))
                    }
                    completion(nil, result)
                }
            case .failure(let error):
                completion(error as Error, nil)
            }
        }.task
    }
}
