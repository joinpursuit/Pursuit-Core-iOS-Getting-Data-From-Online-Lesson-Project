import UIKit

class JokesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var jokesTableView: UITableView!
    
    // MARK: - Internal Properties
    
    var jokes = [Joke]() {
        didSet {
            jokesTableView.reloadData()
        }
    }
    
    // MARK: - Lifecyle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureJokesTableView()
        loadJokes()
    }
    
    // MARK: - Private methods
    
    func configureJokesTableView() {
        jokesTableView.delegate = self
        jokesTableView.dataSource = self
    }
    
    func loadJokes() {
        JokeFetchingService.manager.getJokes { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case let .success(fetchedJokes):
                    self.jokes = fetchedJokes
                case let .failure(error):
                    let alertVC = UIAlertController(title: "Error",
                                                    message: "An error fetching the jokes occurred: \(error.description)",
                                                    preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK",
                                                    style: .default,
                                                    handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
}

extension JokesViewController: UITableViewDelegate {}

extension JokesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jokesTableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        let joke = jokes[indexPath.row]
        cell.textLabel?.text = joke.setup
        cell.detailTextLabel?.text = joke.punchline
        return cell
    }
}
