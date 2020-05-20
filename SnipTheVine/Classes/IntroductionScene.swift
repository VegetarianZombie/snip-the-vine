/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SpriteKit
import WebKit

class IntroductionScene: SKScene {
  
  override func didMove(to view: SKView) {
    setUpBackground()
    setUpButtons()
    setUpCrocodile()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }
    let positionInScene = touch.location(in:self)
    let touchedNode = self.atPoint(positionInScene)

    if touchedNode.name == ButtonName.start {
      runGame()
    } else if touchedNode.name == ButtonName.tutorial {
      let notificationCenter = NotificationCenter.default
      notificationCenter.post(Notification(name: Notification.Name(rawValue: NotificationNames.launchTutorial)))
    }
  }
  

  private func runGame() {
    let sceneChange = SKAction.run {
      let scene = GameScene(size: self.size)
      scene.scaleMode = .aspectFill
      self.view?.presentScene(scene, transition: .fade(withDuration: 2.0))
    }
    run(sceneChange)
  }
  
  private func setUpBackground() {
    let background = SKSpriteNode(imageNamed: ImageName.introBackground)
    background.anchorPoint = CGPoint(x: 0, y: 0)
    background.position = CGPoint(x: 0, y: 0)
    background.zPosition = Layer.background
    background.size = CGSize(width: size.width, height: size.height)
    addChild(background)
  }
  
  private func setUpButtons() {
    let snipTheRope = SKSpriteNode(imageNamed: ImageName.snipTheRope)
    snipTheRope.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    snipTheRope.position = CGPoint(x: size.width / 2, y: size.height * 0.8)
    snipTheRope.zPosition = Layer.ui
    addChild(snipTheRope)
    
    let playTheGame = SKSpriteNode(imageNamed: ImageName.playTheGame)
    playTheGame.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    playTheGame.position = CGPoint(x: size.width / 2, y: size.height * 0.55)
    playTheGame.zPosition = Layer.ui
    playTheGame.name = ButtonName.start
    addChild(playTheGame)

    let makeTheGame = SKSpriteNode(imageNamed: ImageName.makeTheGame)
    makeTheGame.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    makeTheGame.position = CGPoint(x: size.width / 2, y: size.height * 0.40)
    makeTheGame.zPosition = Layer.ui
    makeTheGame.name = ButtonName.tutorial
    addChild(makeTheGame)
  }
  
  private func setUpCrocodile() {
    let crocodile = SKSpriteNode(imageNamed: ImageName.crocMouthClosed)
    crocodile.position = CGPoint(x: size.width * 0.78, y: size.height * 0.142)
    crocodile.zPosition = Layer.crocodile
    crocodile.size = CGSize(width: crocodile.size.width * 1.5, height: crocodile.size.height * 1.5)
    addChild(crocodile)
  }
  
  
}
