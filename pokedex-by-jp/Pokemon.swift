//
//  Pokemon.swift
//  pokedex-by-jp
//
//  Created by JuanPa Villa on 2/9/17.
//  Copyright © 2017 JuanPa Villa. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionlvl: String!
    private var _pokemonUrl: String!
    
    
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var pokemonUrl: String {
        return _pokemonUrl
    }
    
    
    var description: String {
        if self._description == nil {
            self._description = ""
        }
        return _description
    }
    
    var type: String {
        if self._type == nil {
            self._type = ""
        }
        return _type
    }
    
    var defense: String {
        if self._defense == nil {
            self._defense = ""
        }
        return _defense
    }
    
    var height: String {
        if self._height == nil {
            self._height = ""
        }
        return _height
    }
    
    var weight: String {
        if self._weight == nil {
            self._weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if self._attack == nil {
            self._attack = ""
        }
        return _attack
    }
    
    
    var nextEvolutionTxt: String {
        if self._nextEvolutionTxt == nil {
            self._description = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionLvl: String {
        
        if self._nextEvolutionlvl == nil {
            self._nextEvolutionlvl = ""
        }
        return _nextEvolutionlvl
    }
    
    
    var nextEvolutionId: String {
        if self._nextEvolutionId == nil {
            self._nextEvolutionId = ""
        }
        return self._nextEvolutionId
    }
    
    

    
    
    
    func downloadPokemonDetails(completion: @escaping DowmloadComplete) {
        
        let url = URL(string: _pokemonUrl)!
        Alamofire.request(url).responseJSON { (result) in
            //
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._attack)
                print(self._defense)
                print(self._height)
                print(self._weight)
                
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    
                    
                    if let name = types[0]["name"] {
                    self._type = name.uppercased()
                    
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                            
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.uppercased())"
                            }
                            
                        }
                        
                    }
                    
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>], descArray.count > 0 {
                    
                    if let resourceUri = descArray[0]["resource_uri"] {
                        
                        let url = URL(string: "\(URL_BASE)\(resourceUri)")!
                        
                        Alamofire.request(url).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.value as? Dictionary<String,AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            
                            completion()
                            
                        })
                            
                        
                    }
                    
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                 
                    if let to = evolutions[0]["to"] as? String {
                        
                        // We want to make sure that we do not include any "Mega" evolutions
                        
                        if to.range(of: "mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "\(URL_POKEMON)", with: "")
                                let num = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionTxt = to
                                self._nextEvolutionId = "\(num)"
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionlvl = "\(lvl)"
                                    print(self._nextEvolutionlvl)

                                }
                                
                                print(self._nextEvolutionTxt)
                                print(self._nextEvolutionId)
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
                
            }
        }
        
    }
    
}
