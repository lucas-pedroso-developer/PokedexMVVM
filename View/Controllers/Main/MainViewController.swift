import Foundation
import UIKit
import Kingfisher
import ViewModel
import RxSwift

class MainViewController: UIViewController {
            
    var searchController: UISearchController!
    var searchActive : Bool = false
    var isFinalToLoad : Bool = false
    var pokemonsViewModel = PokemonsViewModel()
    var pokemonArrayFiltered: [[String:String]] = []
    var disposeBag = DisposeBag()
    
    public var detailViewController: DetailViewController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon") {
            getPokemons(url: url)
        }
    }
    
    func getPokemons(url: URL) {
        showLoading(true)
        self.pokemonsViewModel.get(url: url).subscribe(
            onNext: { result in
                self.collectionView.reloadData()
                self.showLoading(false)
            },
            onError: { error in
                self.showAlert(title: "Erro", message: "Ocorreu o seguinte erro - \(error.localizedDescription) ")
            },
            onCompleted: {
                          
            }
        ).disposed(by: disposeBag)
    }
    
    func showLoading(_ show: Bool) {
        if show {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {}
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.pokemonsViewModel.resultsArray?.removeAll()
        if !searchBar.text!.isEmpty {
            self.searchActive = true
            self.isFinalToLoad = true
            self.pokemonsViewModel.pokemonNameToSearch = searchBar.text!.lowercased()
            if (searchBar.text!.isEmpty) {
                self.searchActive = false
                self.collectionView.reloadData()
            }
        } else {
            self.searchActive = false
            self.isFinalToLoad = false
        }
        self.collectionView.reloadData()
    }
}
