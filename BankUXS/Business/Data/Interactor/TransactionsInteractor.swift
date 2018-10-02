
import Foundation

protocol TransactionsInteractor {
    func execute(_ success: @escaping ([TransactionsResponse]) -> ())
}

class TransactionsInteractorDefault: TransactionsInteractor {
    
    // MARK: - Class
    
    var repository = TransactionsRepositoryDefault()
    
    func execute(_ success: @escaping ([TransactionsResponse]) -> ()) {
        repository.getOperations({ [weak self] operations in
            success(operations)
        })
    }
}
