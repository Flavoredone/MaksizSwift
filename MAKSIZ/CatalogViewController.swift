import UIKit

class CatalogViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        navigationController?.navigationBar.tintColor = .white
        
        setupButtons()
    }

    private func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        let buttonImages = ["10.png", "11.png", "12.png"]
        let buttonTitles = ["КОМБИНЕЗОНЫ", "ПЕРЧАТКИ", "ПРОИЗВОДНЫЕ"]
        
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            button.contentHorizontalAlignment = .left
            button.contentVerticalAlignment = .bottom
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
            button.layer.cornerRadius = 30 // Закругление углов
//            button.layer.borderWidth = 2 // Толщина границы
//            button.layer.borderColor = UIColor.white.cgColor // Цвет границы
            button.clipsToBounds = true

            let backgroundImage = UIImage(named: buttonImages[index])
            button.setBackgroundImage(backgroundImage, for: .normal)

            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func buttonAction(_ sender: UIButton) {
           if let title = sender.title(for: .normal) {
               let imageVC = ImageDisplayViewController()

               // Установка русскоязычного текста для кнопки "Назад"
               let backItem = UIBarButtonItem()
               backItem.title = "Назад"
               navigationItem.backBarButtonItem = backItem

               switch title {
               case "КОМБИНЕЗОНЫ":
                   let coverallsVC = CoverallsViewController()
                   navigationController?.pushViewController(coverallsVC, animated: true)
                   break
               case "ПЕРЧАТКИ":
                   let glovesVC = GlovesViewController()
                               navigationController?.pushViewController(glovesVC, animated: true)
                               break
               case "ПРОИЗВОДНЫЕ":
                   imageVC.imageName = "35.jpg"
                   navigationController?.pushViewController(imageVC, animated: true)
                   break
               default:
                   break
               }
           }
       }


}

import UIKit

class CoverallsViewController: UIViewController {

    private let imageNames = ["25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg", "31.jpg"]
    private let buttonImages = ["15.png", "16.png", "17.png", "18.png", "19.png", "20.png", "21.png"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.tintColor = .white
        setupButtons()
    }

    private func setupButtons() {
        var lastLeftButton: UIButton?
        var lastRightButton: UIButton?

        for i in 0..<7 {
            let button = createButton(withImageNamed: buttonImages[i])
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            view.addSubview(button)

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 120),
                button.heightAnchor.constraint(equalToConstant: 170)
            ])

            if i < 4 {
                // Left column of buttons
                if let lastButton = lastLeftButton {
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: lastButton.bottomAnchor, constant: 10),
                        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
                    ])
                }
                lastLeftButton = button
            } else {
                // Right column of buttons
                if let lastButton = lastRightButton {
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: lastButton.bottomAnchor, constant: 10),
                        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                    ])
                }
                lastRightButton = button
            }
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        let imageVC = ImageDisplayViewController()
        imageVC.imageName = imageNames[sender.tag]

        // Установка текста кнопки "Назад" на русском языке
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem

        navigationController?.pushViewController(imageVC, animated: true)
    }

    private func createButton(withImageNamed imageName: String) -> UIButton {
        let button = UIButton()
        if let image = UIImage(named: imageName) {
            button.setBackgroundImage(image, for: .normal)
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}











import UIKit

class ImageDisplayViewController: UIViewController, UIScrollViewDelegate {  // 1. Conform to UIScrollViewDelegate

    var imageName: String?
    var showMapButton: Bool = false

    private var scrollView: UIScrollView!
    private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupScrollView()

        navigationController?.navigationBar.barTintColor = .darkGray

        if showMapButton {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Показать на карте", style: .plain, target: self, action: #selector(showMap))
        }
    }

    private func setupScrollView() {
        guard let imageName = imageName, let image = UIImage(named: imageName) else { return }

        scrollView = UIScrollView()
        scrollView.delegate = self  // 2. Set the delegate to self
        scrollView.minimumZoomScale = 1.0  // 3. Set minimum zoom scale
        scrollView.maximumZoomScale = 6.0  // 4. Set maximum zoom scale
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: image.size.height / image.size.width)
        ])

        DispatchQueue.main.async {
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.imageView.frame.height)
        }
    }

    // 5. Implement the UIScrollViewDelegate method to specify the view to zoom
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    @objc func showMap() {
        let mapVC = MapViewController()  // Создаем контроллер карты
        
        // Установка русскоязычного текста для кнопки "Назад"
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(mapVC, animated: true)  // Переходим к контроллеру карты
    }
}

// The rest of your GlovesViewController remains unchanged.









import UIKit

class GlovesViewController: UIViewController {
    
    // Имена файлов изображений для каждой кнопки
    private let imageNames = ["40.jpg", "41.jpg", "42.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray

        // Установка текста кнопки "Назад" на русском языке
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem

        setupButtons()
    }

    private func setupButtons() {
        let buttonTitles = ["HOUSEHOLD GLOVES", "PHYSICAL PROTECTIVE GLOVES", "REAGENT PROTECTIVE GLOVES"]
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill // Измените это на .fill, чтобы разрешить разные размеры
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])

        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.backgroundColor = .orange
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

            // Настройка высоты кнопки
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true

            stackView.addArrangedSubview(button)
        }
    }

    
    @objc private func buttonTapped(_ sender: UIButton) {
        let imageVC = ImageDisplayViewController()
        imageVC.imageName = imageNames[sender.tag]
        navigationController?.pushViewController(imageVC, animated: true)
    }
}


