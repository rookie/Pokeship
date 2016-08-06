//
//  GameScene.swift
//  Pokeship
//
//  Created by Ray Fix on 8/5/16.
//  Copyright (c) 2016 Neko Labs. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  let board = PokeBoard(columns: 10, rows: 10)
  
  var corral: PokeCorral!
  
    override func didMoveToView(view: SKView) {
        // put in our poke corral here
      
      //let trainer = Trainer(name: "M", pokeballs: 50)
      //let corral = PokeCorral(owner: trainer, pokemon: [])
      
      
      let positions = board.getRandomPositions(3)
      
      let pokemonType = randomPokemon(3)
      
      let pokemon = [(positions[0], pokemonType[0]),
                     (positions[1], pokemonType[1]),
                     (positions[2], pokemonType[2])
                     ]
      
      let trainer = Trainer(name: "Matt", pokeballs: 50)
      corral = PokeCorral(owner: trainer, pokemon: pokemon)
      
      
      
      self.size = view.bounds.size;
      createGrid()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
          
          if let position = positionForTouch(location) {
          
            let positionState = board.stateForPosition(position)
          
            if let touchedNode = self.nodeAtPoint(location) as? SKShapeNode {
                
                playPokeball(position)
                
              switch positionState {
              case .None:
                touchedNode.fillColor = UIColor.whiteColor()
              case .Close:
                touchedNode.fillColor = UIColor.yellowColor()
              case .Occupied:
                touchedNode.fillColor = UIColor.redColor()
                
                corral.pokemon[board.indexForPosition(position)!].1.hp -= Pokeball().hp

                let pokemon = corral.pokemon[board.indexForPosition(position)!].1
                
                if pokemon.hp < 0 {
                    touchedNode.fillColor = UIColor.whiteColor()
                    addPokemon(corral.pokemon[board.indexForPosition(position)!].1, atPosition: position)
                }
              }
            }
            
          }
          
          /*
            let sprite = SKSpriteNode(imageNamed:"charizard")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
           */
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
  
  func addPokemon(pokemon: Pokemon, atPosition position: Position) {

    let sprite = SKSpriteNode(imageNamed: pokemon.name)
    
    let rect = pokemonRectForPosition(position)
    
    sprite.size = rect.size
    sprite.position = rect.origin
    
    self.addChild(sprite)
    
  }

    func playPokeball(position: Position) {
        let sprite = SKSpriteNode(imageNamed: Pokeball().name)
        
        let rect = pokemonRectForPosition(position)
        
        sprite.size = rect.size
        sprite.position = rect.origin
        
        self.addChild(sprite)
        
        let wait = SKAction.waitForDuration(0.2)
        let remove = SKAction.removeFromParent()
        sprite.runAction(SKAction.sequence([wait, remove]))
    }
  
  func pokemonRectForPosition(position: Position) -> CGRect {
    
    let gridWidth = size.width/CGFloat(board.columns)
    
    let x = CGFloat(position.row) * gridWidth + gridWidth/2
    let y = CGFloat(position.column) * gridWidth + gridWidth/2
    
    return CGRect(x: x, y: y, width: gridWidth, height: gridWidth)
    
  }
  
  func randomPokemon(count: Int) -> [Pokemon]{
    
    let randomPokemon = pokemon.shuffle()
    
    return Array(randomPokemon[0..<count])
    
  }

}



extension GameScene {
  
  func positionForTouch(point: CGPoint) -> Position? {
    
    let gridWidth = size.width/CGFloat(board.columns)
    
    if point.y > size.width {
      return nil
    } else {
      
      let row = Int(point.x / gridWidth)
      let column = Int(point.y / gridWidth)
      
      return Position(row: row, column: column)
      
    }
  }
  
  func createGrid() {
    
    
    let gridWidth = size.width/CGFloat(board.columns)
    
    //let xOffset = size.height + (
    
    for row in 0..<board.rows {
      for column in 0..<board.columns {
        
        let sprite = SKShapeNode(rect: CGRect(x: 0, y: 0, width: gridWidth, height: gridWidth)) //Node(imageNamed:"charizard")
        sprite.strokeColor = UIColor.blackColor()
        sprite.fillColor = UIColor.whiteColor()
        
        let location = CGPoint(x: (CGFloat(column) * gridWidth), y: (CGFloat(row) * gridWidth))
        sprite.position = location
        
        self.addChild(sprite)

      }
    }
  }
  
  
  /*
  - (NSSet *)createInitialCookies {
  NSMutableSet *set = [NSMutableSet set];
  
  // 1
  for (NSInteger row = 0; row < NumRows; row++) {
  for (NSInteger column = 0; column < NumColumns; column++) {
  
  // 2
  NSUInteger cookieType = arc4random_uniform(NumCookieTypes) + 1;
  
  // 3
  RWTCookie *cookie = [self createCookieAtColumn:column row:row withType:cookieType];
  
  // 4
  [set addObject:cookie];
  }
  }
  return set;
  }
  
  - (RWTCookie *)createCookieAtColumn:(NSInteger)column row:(NSInteger)row withType:(NSUInteger)cookieType {
  RWTCookie *cookie = [[RWTCookie alloc] init];
  cookie.cookieType = cookieType;
  cookie.column = column;
  cookie.row = row;
  _cookies[column][row] = cookie;
  return cookie;
  }*/
  
}

extension CollectionType {
  /// Return a copy of `self` with its elements shuffled
  func shuffle() -> [Generator.Element] {
    var list = Array(self)
    list.shuffleInPlace()
    return list
  }
}

extension MutableCollectionType where Index == Int {
  /// Shuffle the elements of `self` in-place.
  mutating func shuffleInPlace() {
    // empty and single-element collections don't shuffle
    if count < 2 { return }
    
    for i in 0..<count - 1 {
      let j = Int(arc4random_uniform(UInt32(count - i))) + i
      guard i != j else { continue }
      swap(&self[i], &self[j])
    }
  }
}