import Foundation
import UIKit
import Kingfisher
import ViewModel

class DetailViewController: UIViewController {
      
     var id: Int = 0
     var pokemonArray: [Int: String] = [:]
     var pokemonMainColor: UIColor?
     var speciesEvolutionArray: [SpecieDetailViewModel] = []
     var pokemonDetailViewModel = PokemonDetailViewModel()
     var specieDetailViewModel = SpecieDetailViewModel()
     var evolutionChainDetailViewModel = EvolutionChainDetailViewModel()
             
     @IBOutlet weak var pokemonNameLabel: UILabel!
     @IBOutlet weak var navbar: UINavigationBar!
     @IBOutlet weak var pokemonIdLabel: UILabel!
     @IBOutlet weak var pokemonImageView: UIImageView!
     @IBOutlet weak var hpLabel: UILabel!
     @IBOutlet weak var atackLabel: UILabel!
     @IBOutlet weak var defenseLabel: UILabel!
     @IBOutlet weak var specialAtackLabel: UILabel!
     @IBOutlet weak var specialDefenseLabel: UILabel!
     @IBOutlet weak var speedLabel: UILabel!
     @IBOutlet weak var abilityLabel: UILabel!
         
     @IBOutlet weak var typeCollectionView: UICollectionView!
     @IBOutlet weak var evolutionCollectionView: UICollectionView!
     @IBOutlet weak var abilitiesCollectionView: UICollectionView!
              
     @IBOutlet weak var segment: UISegmentedControl!
     
     @IBOutlet weak var pokemonImageBackgroundView: UIView!
     @IBOutlet weak var pokemonImageBackgroundViewHeight: NSLayoutConstraint!
     @IBOutlet weak var pokemonImageBackgroundViewWidth: NSLayoutConstraint!
     
     @IBOutlet weak var heightLabel: UILabel!
     @IBOutlet weak var weightLabel: UILabel!
     
     @IBOutlet weak var whiteBackgroundView: UIView!
     
     @IBOutlet weak var dataView: UIView!
     @IBOutlet weak var statusView: UIView!
     @IBOutlet weak var evolutionView: UIView!
     
     @IBOutlet weak var typeColorBackgroundView: UIView!
     
     @IBOutlet weak var backNavBarButton: UIBarButtonItem!
     @IBOutlet weak var descriptionLabel: UILabel!
     @IBOutlet weak var dataDescriptionLabel: UILabel!
       
               
     @IBOutlet weak var hpProgress: UIProgressView!
     @IBOutlet weak var atackProgress: UIProgressView!
     @IBOutlet weak var defenseProgress: UIProgressView!
     @IBOutlet weak var specialAtackProgress: UIProgressView!
     @IBOutlet weak var specialDefenseProgress: UIProgressView!
     @IBOutlet weak var speedProgress: UIProgressView!
     
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            showLoading(true)
            self.setCornerRadius()
            self.segment.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            self.configureBackGesture()
            
            if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(self.id)") {
                getPokemon(url: url)
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
        
        func setCornerRadius() {
            self.pokemonImageBackgroundView.layer.cornerRadius = self.view.bounds.height*12/100
            self.whiteBackgroundView.layer.cornerRadius = self.view.bounds.height*4/100
            self.whiteBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.abilityLabel.layer.cornerRadius = self.view.bounds.height*1/100
            self.dataDescriptionLabel.layer.cornerRadius = self.view.bounds.height*1/100
        }
               
        func getPokemon(url: URL) {
            self.pokemonDetailViewModel.getPokemon(url: url) { [weak self] results in
                self!.setPokemonImage()
                self!.setPokemonData()
                self!.setPokemonStatus()
                self!.setPokemonAbilities()
                self!.setPokemonTypes()
                if let specieUrl = URL(string: (self!.pokemonDetailViewModel.pokemonDetail?.species?.url)!) {
                    self!.getSpecie(url: specieUrl)
                }                
            }
        }
            
        func getSpecie(url: URL) {
            self.specieDetailViewModel.getSpecie(url: url) { [weak self] results in
                print(results)
                self!.dataDescriptionLabel.text = self!.specieDetailViewModel.getDataDescription()
                if let url = URL(string: (self!.specieDetailViewModel.specieDetail?.evolution_chain?.url)!) {
                    self!.getPokemonEvolution(url: url)
                }
            }
        }
             
        func getPokemonEvolution(url: URL) {
            self.evolutionChainDetailViewModel.getPokemonEvolution(url: url) { [weak self] results in
                self?.showLoading(false)
                self?.evolutionCollectionView.reloadData()
            }
        }
            
        private func setPokemonImage() {
            if let url = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(String(format: "%03d", id)).png") {
                self.pokemonImageView.kf.setImage(with: url)
            }
        }
        
        private func setPokemonData() {
            if let name = self.pokemonDetailViewModel.pokemonDetail?.name {
                self.pokemonNameLabel.text = name
            }
            
            if let id = self.pokemonDetailViewModel.pokemonDetail?.id {
                self.pokemonIdLabel.text = "# \(String(format: "%03d", id))"
                
            }
            
            if let height = self.pokemonDetailViewModel.pokemonDetail?.height {
                self.heightLabel.text = "\(height)"
            }
            
            if let weight = self.pokemonDetailViewModel.pokemonDetail?.weight {
                self.weightLabel.text = "\(weight)"
            }
        }
                
        private func setPokemonStatus() {
            let stats = self.pokemonDetailViewModel.pokemonDetail?.stats
            for stat in stats! {
                let name = stat.stat?.name!
                
                if (name?.elementsEqual("hp"))! {
                    if let base_stat = stat.base_stat {
                        self.hpLabel.text = "\(base_stat)"
                        self.hpProgress.setProgress(((self.hpLabel.text?.floatValue())!/500), animated: false)
                    }
                } else if (name?.elementsEqual("defense"))! {
                    if let base_stat = stat.base_stat {
                        self.atackLabel.text = "\(base_stat)"
                        self.atackProgress.setProgress(((self.atackLabel.text?.floatValue())!/500), animated: false)
                    }
                } else if (name?.elementsEqual("attack"))! {
                    if let base_stat = stat.base_stat {
                        self.defenseLabel.text = "\(base_stat)"
                        self.defenseProgress.setProgress(((self.defenseLabel.text?.floatValue())!/500), animated: false)
                    }
                } else if (name?.elementsEqual("special-attack"))! {
                    if let base_stat = stat.base_stat {
                        self.specialAtackLabel.text = "\(base_stat)"
                        self.specialAtackProgress.setProgress(((self.specialAtackLabel.text?.floatValue())!/500), animated: false)
                    }
                } else if (name?.elementsEqual("special-defense"))! {
                    if let base_stat = stat.base_stat {
                        self.specialDefenseLabel.text = "\(base_stat)"
                        self.specialDefenseProgress.setProgress(((self.specialDefenseLabel.text?.floatValue())!/500), animated: false)
                    }
                } else if (name?.elementsEqual("speed"))! {
                    if let base_stat = stat.base_stat {
                        self.speedLabel.text = "\(base_stat)"
                        self.speedProgress.setProgress(((self.speedLabel.text?.floatValue())!/500), animated: false)
                    }
                } else {
                    self.showAlert(title: "Error", message: "Unknow Error")                    
                }
            }
        }
        
        private func setPokemonAbilities() {
            self.abilitiesCollectionView.reloadData()
        }
        
        private func setPokemonTypes() {
            self.typeCollectionView.reloadData()
        }
        
        func configureBackGesture() {
            let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
            slideDown.direction = .right
            view.addGestureRecognizer(slideDown)
        }
            
        @IBAction func back(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
                
        @IBAction func change(_ sender: UISegmentedControl) {
                if sender.selectedSegmentIndex == 0 {
                    self.dataView.isHidden = false
                    self.statusView.isHidden = true
                    self.evolutionView.isHidden = true
                } else if sender.selectedSegmentIndex == 1 {
                    self.dataView.isHidden = true
                    self.statusView.isHidden = false
                    self.evolutionView.isHidden = true
                } else if sender.selectedSegmentIndex == 2 {
                    self.dataView.isHidden = true
                    self.statusView.isHidden = true
                    self.evolutionView.isHidden = false
                }
        }
           
        @objc func dismissView(gesture: UISwipeGestureRecognizer) {
            UIView.animate(withDuration: 0.4) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    
        
}

