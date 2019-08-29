enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case responseError(Error)
    case noURLResponse
    case noData
    case badURLResponse(Int)
    var description: String {
        switch self {
        case .badURL: return "Invalid URL"
        case let .responseError(error): return "Response Error: \(error)"
        case .noURLResponse: return "No URL Response"
        case .noData: return "No Data"
        case let .badURLResponse(statusCode): return "Bad status code: \(statusCode)"
        }
    }
}
