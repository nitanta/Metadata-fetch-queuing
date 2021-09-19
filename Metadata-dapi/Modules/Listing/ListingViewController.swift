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

    var viewModel: ListingViewModel!
    private var bag = Set<AnyCancellable>()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        setupBindings()
        viewModel.fetchMetadata()
    }
    
    /// Perform UI setup
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.title
        tableView.register(UINib(nibName: ListTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.cellIdentifier)
        tableView.delegate = self
        
        let rightButton = UIBarButtonItem(title: Constants.start, style: .plain, target: self, action: #selector(startButtonPressed))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    /// Add right button on the navigation bar
    private func addRightBarItem() {
        let rightButton = UIBarButtonItem(title: Constants.start, style: .plain, target: self, action: #selector(startButtonPressed))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    /// Bindings
    func setupBindings() {
        /// Bind view to viewmodel
        func bindViewToViewModel() {}
        
        /// Bind viewmodel to view
        func bindViewModelToView() {
            let stateValueHandler: (ListingViewModel.ViewModelState) -> Void = { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.loadingState()
                case .finishedLoading:
                    self.errorState()
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
        var snapshot = Snapshot()
        snapshot.appendSections([.contents])
        snapshot.appendItems(viewModel.datasource)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    /// UI changes on loading state
    private func loadingState() {
        navigationItem.rightBarButtonItem = nil
    }
    
    /// UI changes on error state
    private func errorState() {
        addRightBarItem()
    }
    
    /// Start button is pressed
    @objc private func startButtonPressed() {
        
    }
}

// MARK: - Populating the table view and interacting with it
extension ListingViewController: UITableViewDelegate {
    private func configureDataSource() {
        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, data) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier, for: indexPath) as? ListTableViewCell
                cell?.configure(model: data)
                return cell
            })
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


