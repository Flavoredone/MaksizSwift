import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        
        // Создание серой заставки
        let launchScreenView = UIView(frame: self.view.bounds)
        launchScreenView.backgroundColor = .darkGray
        view.addSubview(launchScreenView)
        
        view.backgroundColor = .darkGray
        // Создание UIImageView для логотипа
        let logoImageView = UIImageView(image: UIImage(named: "prespl.png"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        launchScreenView.addSubview(logoImageView)
        
        // Констрейнты для logoImageView
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: launchScreenView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: launchScreenView.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Удаление заставки через 5 секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            launchScreenView.removeFromSuperview()
        }
    }
    
    private func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        let buttonTitles = ["О КОМПАНИИ", "ПОИСК", "КАТАЛОГ", "ДОКУМЕНТАЦИЯ", "ГДЕ КУПИТЬ"]
        let imageNames = ["1.png", "2.png", "3.png", "4.png", "5.png"]
        
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            
            if let customFont = UIFont(name: "Teko-Regular", size: 20) {
                button.titleLabel?.font = UIFont(descriptor: customFont.fontDescriptor.withSymbolicTraits(.traitBold) ?? customFont.fontDescriptor, size: 20)
            } else {
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            }
            
            let backgroundImage = UIImage(named: imageNames[index])
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            
            button.insertSubview(backgroundImageView, at: 0)
            
            NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: button.topAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor)
            ])
            
            button.contentHorizontalAlignment = .left
            button.contentVerticalAlignment = .bottom
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
            
            button.layer.cornerRadius = 30 // Закругление углов
            //            button.layer.borderWidth = 2 // Толщина границы
            //            button.layer.borderColor = UIColor.white.cgColor // Цвет границы
            button.clipsToBounds = true
            
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    
    
    
    // В вашем ViewController...
    
    @objc func buttonTapped(sender: UIButton) {
        let viewController: UIViewController
        let backButtonTitle: String
        
        switch sender.tag {
        case 0:
            viewController = AboutCompanyViewController()
            backButtonTitle = "О Компании"
        case 1:
            // Открывается SearchViewController при нажатии на "ПОИСК"
            viewController = ButtonsViewController()
            backButtonTitle = "Поиск"
        case 2:
            viewController = CatalogViewController()
            backButtonTitle = "Каталог"
        case 3:
            viewController = DocumentationViewController()
            backButtonTitle = "Документация"
        case 4:
                let imageVC = ImageDisplayViewController()
                imageVC.imageName = "45.png"
                imageVC.showMapButton = true  // Установка флага
                viewController = imageVC
                backButtonTitle = "Где Купить"
                navigationController?.navigationBar.tintColor = .white
            default:
                return
            }
            
            let backItem = UIBarButtonItem()
            backItem.title = backButtonTitle
            navigationItem.backBarButtonItem = backItem
            navigationController?.pushViewController(viewController, animated: true)
        }
}


