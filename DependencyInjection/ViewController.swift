
import UIKit
import Swinject

class ViewController: UIViewController {
    
    //Swinject
    let container : Container = {
        let container = Container()
        container.register(BackgroundProvidingClass.self) { resolver in
            return BackgroundProvidingClass()
        }
        container.register(AnotherVC.self) { resolver in
            let vc = AnotherVC(providerProtocol: resolver.resolve(BackgroundProvidingClass.self))
            return vc
        }
        
        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        let nextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        nextButton.setTitle("Open Another VC", for: .normal)
        nextButton.center = view.center
        nextButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(nextButton)
        
        
    }
    
    @objc private func buttonClicked() {
        if let viewController = container.resolve(AnotherVC.self) {
            present(viewController, animated: true)
        }
    }

    
    
}
