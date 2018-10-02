
import UIKit

protocol TransactionsView: class {
    func reloadView()
}

// TODO: Implementar una clase ViewControllerBase

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - UI
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class
    
    private lazy var presenter: TransactionsPresenterDefault = {
        return TransactionsPresenterDefault(view: self)
    }()
    
    // MARK: - Initialization
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        registerNibs()
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: TransactionsCell.self), bundle: Bundle(for: self.classForCoder)), forCellReuseIdentifier: String(describing: TransactionsCell.self))
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.content(at: indexPath), for: indexPath) as! TransactionsCell
        
        presenter.configureItem(cell, at: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
}

// MARK: - TransactionsView

extension TransactionsViewController: TransactionsView {
    func reloadView() {
        tableView.reloadData()
    }
}

