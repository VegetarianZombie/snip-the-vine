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

import UIKit
import SpriteKit
import GameplayKit
import WebKit

class GameViewController: UIViewController {
  
  var scene: IntroductionScene!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Listen for notifications    // Listen for notifications
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(pauseAudio) , name: UIApplication.willResignActiveNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(resumeAudio) , name: UIApplication.didBecomeActiveNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(launchTutorial), name: NSNotification.Name(rawValue: NotificationNames.launchTutorial), object: nil)
    
    // Configure the view.
    let skView = self.view as! SKView
    skView.showsFPS = false
    skView.showsNodeCount = false
    skView.ignoresSiblingOrder = true
    
    // Create and configure the scene.
    scene = IntroductionScene(size: CGSize(width: 375, height: 667))
    scene.scaleMode = .aspectFill
    
    // Play Background Music
    setupAudio()
    
    // Present the scene.
    skView.presentScene(scene)
    
  }
  
  func setupAudio() {
    let audioPlayer = SKTAudio.sharedInstance()
    audioPlayer.playBackgroundMusic(SoundFile.backgroundMusic)
  }
  
  @objc func launchTutorial() {
    let wkWebView = WKWebView()
    guard let url = URL(string: "https://www.raywenderlich.com/5347797-how-to-make-a-game-like-cut-the-rope-with-spritekit") else {
      fatalError("Unable to construct url")
    }
    wkWebView.load(URLRequest(url: url))
    let viewController = UIViewController()
    viewController.view = wkWebView
    present(viewController, animated: true, completion: nil)
  }
  
  @objc func resumeAudio() {
    SKTAudio.sharedInstance().resumeBackgroundMusic()
  }
  
  @objc func pauseAudio() {
    SKTAudio.sharedInstance().pauseBackgroundMusic()
  }
  
}
