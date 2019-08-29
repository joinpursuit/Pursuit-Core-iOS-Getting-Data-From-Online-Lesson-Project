import Foundation

class NetworkHelper {
    
    // Mark: - Static Properties
    
    static let manager = NetworkHelper()
    
    // MARK: - Internal Methods
    
    func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.responseError(error)))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLResponse))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }
            
            completionHandler(.success(data))
        }
        dataTask.resume()
    }
    
    // MARK: - Private Properties and Initializers
    
    private let urlSession = URLSession(configuration: .default)
    
    private init() {}
}
