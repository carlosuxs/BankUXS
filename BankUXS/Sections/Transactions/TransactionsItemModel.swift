
import Foundation

enum TransactionsItemType {
    case description
}

struct TransactionsItemModel {
    var amount: Float
    var fee: Float?
    var description: String?
    var id: Int
    var date: Date?
    var type: TransactionsItemType
}
