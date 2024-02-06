import UIKit

class AboutCompanyViewController: UIViewController {
    
    private var imageView: UIImageView!
    private var stackView: UIStackView!  // Объявляем stackView как свойство класса

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.tintColor = .white

        setupButtons()
        setupImageView()
        
        // Устанавливаем изображение по умолчанию
        imageView.image = UIImage(named: "6.png")
    }

    private func setupButtons() {
        stackView = UIStackView()  // Инициализируем stackView
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])

        let buttonTitles = ["История", "Миссия", "Ценности"]
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.backgroundColor = .orange
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.tag = index
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }

    private func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill // Изменение режима содержимого
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            imageView.image = UIImage(named: "6.png")
        case 1:
            imageView.image = UIImage(named: "7.png")
        case 2:
            imageView.image = UIImage(named: "8.png")
        default:
            break
        }
    }
}
