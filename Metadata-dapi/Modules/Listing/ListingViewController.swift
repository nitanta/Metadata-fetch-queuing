//
//  ListingViewController.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import UIKit
import Combine


final class ListingViewController: UIViewController {
    
    private typealias DataSource = UITableViewDiffableDataSource<ListingViewModel.Section, ListingModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ListingViewModel.Section, ListingModel>

    var viewModel: ListViewModelImplementable!
    private var bag = Set<AnyCancellable>()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        viewModel.setupObservers()
        setupBindings()
    }
    
    /// Perform UI setup
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.title
        addRightBarItem()
        tableView.delegate = self
        tableView.register(UINib(nibName: ListTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.cellIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    /// Add right button on the navigation bar
    private func addRightBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.start, style: .plain, target: self, action: #selector(startTapped))
    }
    
    /// Bindings
    func setupBindings() {
        guard let viewModel = viewModel as? ListingViewModel else { return }
        /// Bind view to viewmodel
        func bindViewToViewModel() {}
        
        /// Bind viewmodel to view
        func bindViewModelToView() {
            let stateValueHandler: (ListingViewModel.ViewModelState) -> Void = { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .start:
                    self.startState()
                case .loading:
                    self.loadingState()
                case .finishedLoading: break
                case .error(let error):
                    self.showError(Constants.error, error)
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bag)
            
            viewModel.$datasource
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                    self.updateSections()
                })
                .store(in: &bag)

        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    /// Create a snapshot for tha tableview
    private func updateSections() {
        guard let viewModel = viewModel as? ListingViewModel else { return }

        var snapshot = Snapshot()
        snapshot.appendSections([.contents])
        snapshot.appendItems(viewModel.datasource, toSection: .contents)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    /// UI changes on loading state
    private func loadingState() {
        navigationItem.rightBarButtonItem = nil
    }
    
    /// UI changes on start state
    private func startState() {
        addRightBarItem()
    }
    
    /// Start button is pressed
    @objc func startTapped() {
        viewModel.fetchMetadata()
    }
}

// MARK: - Populating the table view and interacting with it
extension ListingViewController: UITableViewDelegate {
    
    /// Get the datasource for the tableview
    private func configureDataSource() {
        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, data) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier, for: indexPath) as? ListTableViewCell
                cell?.configure(model: data)
                return cell
            }
        )
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = dataSource.itemIdentifier(for: IndexPath(item: 0, section: section)) else { return nil }
        let title = dataSource.snapshot().sectionIdentifier(containingItem: model)?.rawValue
        return createHeader(with: title)
    }
}

// MARK: - Create header for the labelview
extension ListingViewController {
    
    /// Create a header  for the section
    /// - Parameter title: title for the section
    /// - Returns: return uiview representing the header
    private func createHeader(with title: String?) -> UIView {
        let view = getHeaderView()
        
        let label = getHeaderLabel()
        label.text = title
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 22).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        return view
    }
    
    /// Get the wrapper view for containing label
    /// - Returns: returns a view
    private func getHeaderView() -> UIView {
        let view = UIView()
        return view
    }
    
    /// Get the label for displaying the header
    /// - Returns: returns the label for the header
    private func getHeaderLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }
}

// MARK: - Constants used in the view, made together to make changes easy
private extension ListingViewController {
    struct Constants {
        static let title = "Sites"
        static let error = "Error"
        static let start = "Start"
    }
}


