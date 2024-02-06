import UIKit

class ButtonsViewController: UIViewController {
    
    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    let button3 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray  // Цвет фона экрана темно-серый
        navigationController?.navigationBar.tintColor = .white
        
        setupButton(button1, title: "Поиск по деятельности")
        setupButton(button2, title: "Поиск по № CAS")
        setupButton(button3, title: "Поиск по веществу")
        
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        
        // Установка ограничений по высоте для кнопки
        button.translatesAutoresizingMaskIntoConstraints = false  // Отключение автоматически создаваемых ограничений
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 100)  // Установка высоты кнопки равной 100 точкам
        ])
        
        if title == "Поиск по деятельности" {
            button.addTarget(self, action: #selector(openSearchViewController), for: .touchUpInside)
        } else if title == "Поиск по № CAS" {
            button.addTarget(self, action: #selector(openCasSearchViewController), for: .touchUpInside)
        } else if title == "Поиск по веществу" {
            button.addTarget(self, action: #selector(openSubstanceSearchViewController), for: .touchUpInside)
        }
    }

        @objc func openCasSearchViewController() {
            let casSearchVC = CasSearchViewController()
            let backItem = UIBarButtonItem()
            backItem.title = "Назад"
            navigationItem.backBarButtonItem = backItem
            navigationController?.pushViewController(casSearchVC, animated: true)
        }

        @objc func openSubstanceSearchViewController() {
            let substanceSearchVC = SubstanceSearchViewController()
            let backItem = UIBarButtonItem()
            backItem.title = "Назад"
            navigationItem.backBarButtonItem = backItem
            navigationController?.pushViewController(substanceSearchVC, animated: true)
        }

    
    @objc func openSearchViewController() {
        let searchVC = SearchViewController()  // Создайте экземпляр SearchViewController

        // Установка текста кнопки "Назад" на русском
        let backItem = UIBarButtonItem()
     //   let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(searchVC, animated: true)
    }

}
