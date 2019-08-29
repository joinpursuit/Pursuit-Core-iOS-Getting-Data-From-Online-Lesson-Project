import Foundation

class JokeFetchingService {
    
    // MARK: - Static Properties
    
    static let manager = JokeFetchingService()
    
    // MARK: - Internal Methods
    
    func getJokes(completionHandler: @escaping (Result<[Joke], JokeError>) -> Void) {
        NetworkHelper.manager.getData(from: jokesEndpoint) { (result) in
            switch result {
            case let .success(data):
                do {
                    let jokes = try JSONDecoder().decode([Joke].self, from: data)
                    completionHandler(.success(jokes))
                } catch {
                    completionHandler(.failure(.jsonDecodingError(error)))
                }
            case let .failure(networkError):
                completionHandler(.failure(.networkError(networkError)))
            }
        }
    }
    
    // MARK: - Private Properties and Initializers
    
    private let jokesEndpoint = "https://official-joke-api.appspot.com/jokes/programming/ten"
    
    private init() {}
}
