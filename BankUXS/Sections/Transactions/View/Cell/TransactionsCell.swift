
import UIKit

protocol TransactionsItem: class {
    var amount: Float { get set }
    var fee: Float { get set }
    var total: Float { get set }
    var descriptionOperation: String { get set }
    var date: String { get set }
}

class TransactionsCell: UITableViewCell, TransactionsItem {
    
    // MARK: - UI
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    // MARK: - TransactionsItem
    
    var amount: Float = 0.0 {
        didSet {
            amountLabel.text = "\(amount) €"
            amountLabel.textColor = amount > 0.0 ? .green : .red
        }
    }
    
    var fee: Float = 0.0 {
        didSet {
            feeLabel.text = "\(fee) €"
        }
    }
    
    var descriptionOperation: String = "" {
        didSet {
            descriptionLabel.text = descriptionOperation
        }
    }
    
    var date: String = "" {
        didSet {
            dateLabel.text = "\(date)"
        }
    }
    
    var total: Float = 0.0 {
        didSet {
            totalLabel.text = "\(total) €"
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
