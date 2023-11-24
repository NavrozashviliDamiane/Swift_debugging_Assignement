//Static Shared Instance: Changed let shared = NetworkManager() to static let shared = NetworkManager(). This ensures that shared is a static property of the NetworkManager class, allowing access to the shared instance through NetworkManager.shared.
//URL Initialization: Updated the URL initialization in the get function by using the provided URL string rather than an empty string.

//Updated API url from 2021 to 2023

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}

protocol NewsViewModel {
    var delegate: NewsViewModelDelegate? { get set }
    func viewDidLoad()
}

final class DefaultNewsViewModel: NewsViewModel {
    private let newsAPI = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-11&sortBy=publishedAt&apiKey=ce67ca95a69542b484f81bebf9ad36d5"
    
    private var newsList = [News]()
    
    weak var delegate: NewsViewModelDelegate?
    
    func viewDidLoad() {
        fetchNews()
    }
    
    private func fetchNews() {
        NetworkManager.shared.get(url: newsAPI) { [weak self] (result: Result<Article, Error>) in
            switch result {
            case .success(let article):
                self?.delegate?.newsFetched(article.articles)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
