//
//  PokemonDetailVC.swift
//  pokedex-by-jp
//
//  Created by JuanPa Villa on 2/18/17.
//  Copyright © 2017 JuanPa Villa. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attckLbl: UILabel!
    @IBOutlet weak var nxtEvoTxt: UILabel!
    
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetails { 
            
            self.updateUI()
        }
        
        
    }
    
    
    func updateUI() {
       descriptionLbl.text = pokemon.description
       typeLbl.text = pokemon.type
       defenseLbl.text = pokemon.defense
       heightLbl.text = pokemon.height
       weightLbl.text = pokemon.weight
       attckLbl.text = pokemon.attack
       pokedexIdLbl.text = "\(pokemon.pokedexId)"
       
        
        if pokemon.nextEvolutionId == "" {
            nxtEvoTxt.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            
            nxtEvoTxt.text = str

        }
        
    }
    
    
    @IBAction func backBttnPressd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
