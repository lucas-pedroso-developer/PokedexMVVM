import Foundation
import UIKit

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.tag)
        if collectionView.tag == 0 {
            if self.pokemonDetailViewModel.pokemonDetail != nil {
                return self.pokemonDetailViewModel.pokemonDetail?.types?.count ?? 0
            }
        } else
        if collectionView.tag == 1 {
            if self.evolutionChainDetailViewModel.evolutionChainDetail != nil {
                if let array = self.evolutionChainDetailViewModel.speciesArray {
                    print(array)
                    if array.count > 0 {
                        return array.count
                    }
                }
            }
        } else if collectionView.tag == 2 {
            if self.pokemonDetailViewModel.pokemonDetail != nil {
                return self.pokemonDetailViewModel.pokemonDetail?.abilities?.count ?? 0
            }
        }
        return 0
    }
                    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath as IndexPath) as! GenericButtonCell
            cell.button.setTitle(self.pokemonDetailViewModel.pokemonDetail?.types?[indexPath.item].type?.name, for: .normal)
            cell.button.tag = indexPath.item
            self.typeColorBackgroundView.backgroundColor = UIColor(named: (self.pokemonDetailViewModel.pokemonDetail?.types?[indexPath.item].type?.name)!)
            cell.backgroundColor = UIColor(named: (self.pokemonDetailViewModel.pokemonDetail?.types?[indexPath.item].type?.name)!)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = self.view.bounds.width*4/100
            self.pokemonMainColor = UIColor(named: (self.pokemonDetailViewModel.pokemonDetail?.types?[indexPath.item].type?.name)!)
            self.backNavBarButton.tintColor = self.pokemonMainColor
            self.segment.backgroundColor = self.pokemonMainColor
            self.abilityLabel.backgroundColor = self.pokemonMainColor
            self.dataDescriptionLabel.backgroundColor = self.pokemonMainColor
            self.hpProgress.tintColor = self.pokemonMainColor
            self.atackProgress.tintColor = self.pokemonMainColor
            self.defenseProgress.tintColor = self.pokemonMainColor
            self.specialAtackProgress.tintColor = self.pokemonMainColor
            self.specialDefenseProgress.tintColor = self.pokemonMainColor
            self.speedProgress.tintColor = self.pokemonMainColor
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath as IndexPath) as! GenericCell
            
            if let url = self.evolutionChainDetailViewModel.speciesArray![indexPath.item].url {
                let id = String(format: "%03d", Int(url.split(separator: "/").last!)!)
                if let imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png") {
                    cell.imageView.kf.setImage(with: imageUrl)
                }
            }
            if let name = self.evolutionChainDetailViewModel.speciesArray![indexPath.item].name {
                cell.label.text = name
            }
            
            cell.label.backgroundColor = self.pokemonMainColor
            cell.label.layer.borderColor = UIColor.darkGray.cgColor
            cell.label.layer.borderWidth = 1
            cell.label.layer.cornerRadius = self.view.bounds.width*3/100
            
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath as IndexPath) as! GenericButtonCell
            cell.button.setTitle(self.pokemonDetailViewModel.pokemonDetail?.abilities?[indexPath.item].ability?.name, for: .normal)
            cell.button.tag = indexPath.item
            cell.backgroundColor = .clear
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = self.view.bounds.width*4/100
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        if collectionView.tag == 0 {
            return CGSize(width: self.view.bounds.width*20/100, height: self.view.bounds.height*5/100)
        } else if collectionView.tag == 1 {
            let collectionViewSize = collectionView.frame.size.width - padding
            return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        } else if collectionView.tag == 2 {
            return CGSize(width: self.view.bounds.width*30/100, height: self.view.bounds.height*4/100)
        }
        return CGSize(width: 0, height: 0)
    }
    
}
