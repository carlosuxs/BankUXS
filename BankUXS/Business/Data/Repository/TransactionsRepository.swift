
import Foundation

protocol TransactionsRepository {
    func getOperations(_ completion: @escaping ([TransactionsResponse]) -> ())
}
