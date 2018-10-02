
import Foundation

protocol TransactionsStaticInteractor: class {
    func loadModel(transactions: [TransactionsResponse],_ success: @escaping ([TransactionsSectionModel]) -> ())
}

class TransactionsStaticInteractorDefault: TransactionsStaticInteractor {
    func loadModel(transactions: [TransactionsResponse],_ success: @escaping ([TransactionsSectionModel]) -> ()) {
        
        var sections = [TransactionsSectionModel]()
        var items = [TransactionsItemModel]()
        
        for transaction in transactions {
            items.append(TransactionsItemModel(amount: transaction.amount, fee: transaction.fee, description: transaction.description, id: transaction.id, date: setDate(dateString: transaction.date), type: .description))
        }
        
        var mostRecent = items.unique(map: { $0.id })
        mostRecent.sort{ ($0.date ?? .distantPast) > ($1.date ?? .distantPast) }
        sections.append(TransactionsSectionModel(items: mostRecent))
        
        success(sections)
    }
    
    private func setDate(dateString: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let operationDate = dateString {
            let date = dateFormatter.date(from: operationDate)
            return date
        }
        return nil
    }
}
