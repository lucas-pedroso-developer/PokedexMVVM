import Foundation
import UIKit
import Kingfisher
import ViewModel

class MainViewController: UIViewController {
            
    var searchController: UISearchController!
    var searchActive : Bool = false
    var isFinalToLoad : Bool = false
    var pokemonsViewModel = PokemonsViewModel()
    var pokemonArrayFiltered: [[String:String]] = []
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
        self.pokemonsViewModel.getPokemons(url: url) { [weak self] results in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.showLoading(false)
            }
        }
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
            if let poke = self.pokemonsViewModel.pokemons?.results {
                for item in poke {
                    let name = item.name!.lowercased()
                    if ((name.contains(searchBar.text!.lowercased()))) {
                        self.pokemonsViewModel.appendPokemon(name: item.name!, url: item.url!)
                    }
                    print(name)
                    print(searchBar.text!.lowercased())
                }
            }
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
