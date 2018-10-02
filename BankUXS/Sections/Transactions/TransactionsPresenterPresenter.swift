
import Foundation

protocol TransactionsPresenter {
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func content(at indexPath: IndexPath) -> String
    func configureItem(_ cell: TransactionsItem, at indexPath: IndexPath)
}

// TODO: Implementar una clase PresenterBase

class TransactionsPresenterDefault: TransactionsPresenter {
    
    // MARK: - Class
    
    var configHeader = true
    weak var view: TransactionsViewController?
    private var model = [TransactionsSectionModel]()
    private var transactionsInteractor = TransactionsInteractorDefault()
    private var transactionsStaticInteractor = TransactionsStaticInteractorDefault()
  
    // MARK: - Initialization
    
    init (view: TransactionsViewController) {
        self.view = view
    }
    
    // MARK: - Lifecycle
    
    func viewWillAppear() {
        transactionsInteractor.execute({ [weak self] response in
            self?.loadData(transactionResponse: response)
        })
    }
    
    // MARK: - Private
    
    private func loadData(transactionResponse: [TransactionsResponse]) {
        transactionsStaticInteractor.loadModel(transactions: transactionResponse, { [weak self] response in
            self?.model = response
            self?.view?.reloadView()
        })
    }
    
    // MARK: - TransactionsPresenter
    
    func numberOfRows(in section: Int) -> Int {
        return model[section].items?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return model.count
    }
    
    func content(at indexPath: IndexPath) -> String {
        guard let item = model[indexPath.section].items![indexPath.row] as? TransactionsItemModel else {
            return ""
        }
        switch item.type {
        case .description:
            return String(describing: TransactionsCell.self)
        }
    }
    
    func configureItem(_ cell: TransactionsItem, at indexPath: IndexPath) {
        guard let item = model[indexPath.section].items?[indexPath.row] as? TransactionsItemModel else { return }
        
        if setDate(date: item.date) != "" {
            cell.amount = item.amount
            cell.date = setDate(date: item.date)
            cell.descriptionOperation = item.description ?? ""
            cell.fee = item.fee ?? 0.00
            cell.total = calculateTotal(amount: item.amount, fee: item.fee)
        }
    }
    
    func setDate(date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d/MM/yyyy     HH:mm"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func calculateTotal(amount: Float, fee: Float?) -> Float {
        return amount + (fee ?? 0.0)
    }
}
