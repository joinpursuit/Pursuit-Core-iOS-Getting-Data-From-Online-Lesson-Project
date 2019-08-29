enum JokeError: Error, CustomStringConvertible {
    case networkError(NetworkError)
    case jsonDecodingError(Error)
    var description: String {
        switch self {
        case let .networkError(networkError):
            return "Network error: \(networkError)"
        case let .jsonDecodingError(decodingError):
            return "Decoding error: \(decodingError)"
        }
    }
}
