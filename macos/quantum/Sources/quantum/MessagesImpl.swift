
public class QuantumHostApiImpl : QuantumHostApi {
    func getHostLanguage() throws -> String {
        return "Swift"
    }
    func add(_ a: Int64, to b: Int64) throws -> Int64 {
        return a + b;
    }
    func sendMessage(message: MessageData, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}
