import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonsViewModel.numberOfRows(searchIsActive: searchActive)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.pokemonsViewModel.cellSize(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath as IndexPath) as! GenericCell        
        if searchActive {
            cell.label.text = self.pokemonsViewModel.resultsArray?[indexPath.item].name!
            let url = self.pokemonsViewModel.resultsArray?[indexPath.item].url
            let id = String(format: "%03d", Int(url!.split(separator: "/").last!)!)
            var imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png")!
            cell.imageView.kf.setImage(with: imageUrl)
        } else {
            if let name = self.pokemonsViewModel.pokemons?.results?[indexPath.item].name {
                cell.label.text = name
            }
            if let url = self.pokemonsViewModel.pokemons?.results?[indexPath.item].url {
                let id = String(format: "%03d", Int(url.split(separator: "/").last!)!)
                var imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png")!
                cell.imageView.kf.setImage(with: imageUrl)
            }
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
                        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !searchActive {
            if !isFinalToLoad {
                if indexPath.item == (self.pokemonsViewModel.pokemons?.results!.count)! - 4 &&
                    (self.pokemonsViewModel.pokemons?.results!.count)! < (self.pokemonsViewModel.pokemons?.count)! {
                        if (!((self.pokemonsViewModel.pokemons?.next!.elementsEqual("https://pokeapi.co/api/v2/pokemon?offset=780&limit=20"))!)) {
                            self.getPokemons(url: URL(string: (self.pokemonsViewModel.pokemons?.next!)!)!)
                        } else {
                            
                            self.getPokemons(url: URL(string: "https://pokeapi.co/api/v2/pokemon?offset=780&limit=27")!)
                            self.isFinalToLoad = true
                        }
                }
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController        
        var idToSend: Int = 0
        if searchActive {
            let url = self.pokemonsViewModel.resultsArray?[indexPath.item].url
            idToSend = Int(url!.split(separator: "/").last!)!
        } else {
            let url = self.pokemonsViewModel.pokemons?.results![indexPath.item].url
            idToSend = Int(url!.split(separator: "/").last!)!
        }
        newViewController.id = idToSend
        present(newViewController, animated: true, completion: nil)
    }
    
}
