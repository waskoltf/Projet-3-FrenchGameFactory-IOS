
//  main.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 21/10/2022.
//

import Foundation

class Game {
    //je crée les 2 joueur de la partie
    var players = [Player]()
    var maxCharacters = 3
    
    // MARK: - Public Interface
    
    func start() {
        print("Bienvenue dans FrenchFactoryGame🎮 \n"
              +  "Pour commencer la partie veuillez inscrire votre nom✍🏼")
        createPlayers()
        startBattle()
        showStatistics()
    }
}

// MARK: - Main Methods

extension Game {
    
    // Demande le nom des joueurs
    // Demande le nom de leurs personnages
    // Le but: Avoir 2 joueurs dans le tableaux players
    // posseder 3 character par player
    
    private func createPlayers() {
        for i in 1...2 {
            print("\nBonjour Joueur\(i), quel est votre prénom?")
            // - Demander à l'utilisateur son prénom, gérer les cas d'erreurs
            var name = ""
            var nameAlreadyExist = false
            
            while nameAlreadyExist || name.isEmpty {
                name = readLine() ?? ""
                name = name.capitalized
                
                nameAlreadyExist = players.contains(where: { $0.name == name })
                print("\nBienvenue \(name)\n")
                
                if name.isEmpty {
                    print("Le prénom ne doit pas être vide !")
                }
                
                if nameAlreadyExist {
                    print("Ce prénom existe déjà !")
                }
            }
            
            var characters = [Character]()
            
            // : Initialisation  et choix des 3 personnages du joueur
            for index in 1...maxCharacters {
                
                print("Veuillez choisir le personnage numéro \(index)")
                
                let selectedCharacter = getSelectedCharacter(for: index)
                
                var characterName = ""
                
                while nameAlreadyExist || characterName.isEmpty {
                    characterName = (readLine() ?? "").capitalized
                    //on verifie dans le joueur actuelle si le nom est present
                    nameAlreadyExist = characters.contains(where: { $0.name == characterName })
                    if nameAlreadyExist {
                        print("Le nom existe déjà, veuillez recommencer:")
                        continue
                    }
                    //on verifie dans le tableau complet(dans le premier et deuxieme joueur si un nom est deja existant)
                    for player in players {
                        nameAlreadyExist = player.characters.contains(where: { $0.name == characterName })
                        if nameAlreadyExist {
                            print("Le nom existe déjà, veuillez recommencer:")
                            break
                        }
                    }
                }
                
                selectedCharacter.name = characterName
                characters.append(selectedCharacter)
            }
            
            let player = Player(name: name, characters: characters)
            players.append(player)
        }
    }
    
    //    Permet de montrer les statistique de la Team
    private func showStatistics() {
        for (index, player) in players.enumerated() {
            print("Personnages du joueur \(index + 1)")
            for (index, character) in player.characters.enumerated() {
                print("\(index + 1). \(character.type.name.capitalized) s'appelle \(character.name)")
            }
        }
    }
    
    // Permet de commencer le combat
    private func startBattle() {
        
        var turnRound: Int = 0
        var attack = players[0]
        var attacked = players[1]
        var gameIsNotOver = true
        
        while gameIsNotOver {
            
            let playerHasAMagusAlive = attack.characters.contains { character in
                if character.type == .Magus {
                    return character.lives > 0
                }
                return false
            }
            
            print("\nNous allons passer au combat🛡️\n")
            print("C'est au tour de \(attack.name.capitalized)\n")
            
            if playerHasAMagusAlive == false {
                launchAttack()
            } else {
                print("Vous voulez attaquer? Taper 1🗡️")
                print("Vous voulez vous soigner? Taper 2💊")
                
                let errorMessage = "Vous voulez attaquer? Taper 1🗡️\nVous voulez vous soigner? Taper 2💊"
                let choice = getUserChoice(between: 1...2, errorMessage: errorMessage)
                
                if choice == 1 {
                    launchAttack()
                } else {
                    let magus = attack.characters.first { $0.type == .Magus }! as! Magus
                    healCharacter(with: magus)
                }
            }
            
            turnRound += 1
            swap(&attack, &attacked)
            gameIsNotOver = checkCharactersPlayersLifePoints()
        }
        
        
        //    Fonction qui permet d'attaquer
        func launchAttack() {
            let attackCharacter = getCharacter(player: attack)
            let attackedCharacter = getCharacter(player: attacked)
            
            
            let damage = attackCharacter.weapon.damage
            let lives = attackedCharacter.lives
            
            if damage > lives {
                attackedCharacter.lives = 0
                print("votre personnage est mort")
                
            } else {
                attackedCharacter.lives -= attackCharacter.weapon.damage
                print("votre personnage a \(attackedCharacter.lives) point de vie.")
                
            }
        }
        
        //    Fonction qui permet de se heal
        func healCharacter(with magus: Magus) {
            print("veuillez choisir un de vos personnage à soigner")
            
            let aliveCharacter = getCharacter(player: attack)
            
            aliveCharacter.lives += magus.mana
            print("votre personnage à recuperer \(magus.mana) point de vie il possède maintenant \(aliveCharacter.lives) point de vie")
        }
        
        //        Fonction qui permer de verifier la vie de tout les personnages
        func checkCharactersPlayersLifePoints() -> Bool{
            var turnCharacter = 0
            for player in players{
                var countCharacterDead = 0
                turnCharacter += 1
                for character in player.characters{
                    if character.lives <= 0 {
                        countCharacterDead += 1
                    }
                    if countCharacterDead == player.characters.count{
                        gameIsNotOver = false
                        print("\njeux terminer🕹️")
                        print("\nla partie a durer \(turnRound) tour")
                        if turnCharacter == 1{
                            print("\nle gagant de la partie est \(players[1].name)\n")
                        }else{
                            print("\nle gagnant de la partie est \(players[0].name)\n")
                        }
                        return false                    }
                }
                
            }
            return   true
        }
    }
}

// MARK: - Convenience Methods
extension Game {
    //extension sert a ne pas "polluer" le code pour laisser une chronologie dans notre code ce sont des fonction interne à d'autre.
    private func getSelectedCharacter(for index: Int) -> Character {
        let heroes = [Warrior(), Dwarf(), Colossus(), Magus()]
        
        var selectedCharacter: Character?
        
        while selectedCharacter == nil {
            print("\nTapez le numero correspondant pour choisir votre personnage \(index)")
            
            for (index, hero) in heroes.enumerated() {
                let description = hero.getDescription()
                print("\(index + 1). \(description)")
            }
            
            if let choiceCharacter = readLine(),
               let number = Int(choiceCharacter),
               number >= 1 && number <= 4 {
                selectedCharacter = heroes[number - 1]
                print("Vous avez choisi: \(selectedCharacter!.type)\n")
            } else {
                print("Votre choix est incorrect.")
            }
        }
        // ! = Force Casting
        return selectedCharacter!
    }
    
    //    Fonction qui permet de recuperer nos character
    private func getCharacter(player: Player) -> Character {
        print("Personnages du joueur \(player.name) :")
        
        let aliveCharacters = player.characters.filter { $0.lives > 0 }
        for (index, character) in aliveCharacters.enumerated() {
            print("\(index + 1). \(character.getDescription())")
        }
        
        print("Choissisez un personnage dans l'equipe :")
        
        let attackerIndex = getUserChoice(
            between: 1...aliveCharacters.count,
            errorMessage: "Choissisez un personnage dans l'equipe :"
        )
        
        let selectedCharacter = aliveCharacters[attackerIndex - 1]
        print("\nVous avez choisi \(selectedCharacter.getDescription())\n")
        return selectedCharacter
        
    }
    
    //    Fonction qui permet de selectionner un choix selon le range fixé
    private func getUserChoice(between range: ClosedRange<Int>, errorMessage: String) -> Int {
        var choice = 0
        
        while !(choice >= range.lowerBound && choice <= range.upperBound) {
            if let input = readLine(),
               let number = Int(input),
               number >= range.lowerBound && number <= range.upperBound {
                choice = number
            } else{
                print(errorMessage)
            }
        }
        return choice
    }
}


