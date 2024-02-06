import UIKit

class WhereToBuyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        label.text = "Где Купить"
        label.textColor = .white
        view.addSubview(label)
        view.backgroundColor = .white
           navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .darkGray
        
        
    }
}
