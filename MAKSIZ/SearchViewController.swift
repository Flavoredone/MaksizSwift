import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var criteriaLabel: UILabel!
    private var segmentedControl: UISegmentedControl!
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    
  
        private let imagesForKeyword: [String: [String]] = [
            "Защита от масел, смол и нефтепродуктов": ["701.jpg"],
            "Работа в чистых комнатах и стерильных помещениях": ["701.jpg", "706.jpg"],
            "Малярные работы": ["701.jpg", "702.jpg", "703.jpg", "706.jpg"],
            "Сельское хозяйство": ["701.jpg", "702.jpg", "706.jpg"],
            "Пищевая промышленность": ["701.jpg", "702.jpg", "703.jpg", "706.jpg"],
            "Очистка производственных помещений и оборудования": ["701.jpg", "702.jpg", "703.jpg", "706.jpg"],
            "Утилизация и переноска асбеста": ["701.jpg", "702.jpg", "703.jpg", "706.jpg"],
            "Фармацевтическая промышленность": ["701.jpg", "703.jpg"],
            "Сборка электроники": ["701.jpg"],
            "Точное машиностроение": ["701.jpg"],
            "Химическая и нефтехимическая промышленность": ["701.jpg", "705.jpg", "707.jpg"],
            "Подразделения МЧС, аварийно-спасательные службы": ["701.jpg", "702.jpg"],
            "Защита от паров воды, большого количества влаги": ["701.jpg"],
            "Атомная промышленность": ["701.jpg"],
            "Защита от масел": ["702.jpg", "706.jpg"],
            "Смол и нефтепродуктов": ["702.jpg", "706.jpg"],
            "Монтаж изоляции": ["702.jpg"],
            "Очистка резервуаров и сосудов для хранения жидких химикатов": ["705.jpg"],
            "При обработке агропромышленных культур химикатами": ["705.jpg"],
            "Утилизация отходов": ["705.jpg", "707.jpg"],
            "В местах разлива химикатов": ["705.jpg", "707.jpg"],
            "Работа со спреями и струями под давлением": ["705.jpg", "707.jpg"],
            "Работы по сносу и демонтажу промышленных зданий": ["707.jpg"],
            "Обращение с высокоопасными химическими веществами": ["707.jpg"]
        ]

   

    
    
    private let titles = [
            "Малярные работы",
            "Пищевая промышленность",
            "Очистка производственных помещений и оборудования",
            "Утилизация и переноска асбеста",
            "Фармацевтическая промышленность",
            "Защита от масел",
            "Смол и нефтепродуктов",
            "Работа в чистых комнатах и стерильных помещениях",
            "Сельское хозяйство",
            "Сборка электроники",
            "Точное машиностроение",
            "Химическая и нефтехимическая промышленность",
            "Подразделения МЧС",
            "Аварийно-спасательные службы",
            "Защита от паров воды",
            "Большого количества влаги",
            "Атомная промышленность",
            "Монтаж изоляции",
            "Очистка резервуаров и сосудов для хранения жидких химикатов",
            "При обработке агропромышленных культур химикатами",
            "Утилизация отходов местах разлива химикатов",
            "Работа со спреями и струями под давлением",
            "Работы по сносу и демонтажу промышленных зданий",
            "Обращение с высокоопасными химическими веществами"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.tintColor = .white

        setupCriteriaLabel()
        setupSegmentedControl()
        setupSearchBar()
        setupTableView()
        
        searchBar.isHidden = true
            segmentedControl.isHidden = true
        
    }

    private func setupCriteriaLabel() {
        criteriaLabel = UILabel()
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(criteriaLabel)

        NSLayoutConstraint.activate([
            criteriaLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            criteriaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            criteriaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])

        criteriaLabel.text = "ПОИСК ПО ДЕЯТЕЛЬНОСТИ:"
        criteriaLabel.textColor = .white
    }

    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Деятельность", "№ CAS", "Вещества"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: criteriaLabel.bottomAnchor, constant: 5),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .white
        
        let font = UIFont.systemFont(ofSize: 12)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }

    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        searchBar.placeholder = "Введите запрос..."
        searchBar.searchBarStyle = .prominent
        searchBar.barTintColor = .darkGray
        searchBar.tintColor = .white
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: criteriaLabel.bottomAnchor, constant: 5),  // Изменено на criteriaLabel
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }


    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // Установка высоты ячейки в 100 пунктов
    }

  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)  // Снять выделение с ячейки

        let selectedTitle = titles[indexPath.row]
        var imagesToShow: [String] = []
        
        for (keyword, images) in imagesForKeyword {
            if selectedTitle == keyword {
                imagesToShow.append(contentsOf: images)
            }
        }
        
        if !imagesToShow.isEmpty {
            let imagesDisplayVC = ImagesDisplayViewController()
            imagesDisplayVC.imageNames = imagesToShow
            // Установка текста кнопки "Назад" на русском языке
            let backItem = UIBarButtonItem()
            backItem.title = "Назад"
            navigationItem.backBarButtonItem = backItem
            navigationController?.pushViewController(imagesDisplayVC, animated: true)
        }
    }



}



import UIKit

class ImagesDisplayViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var contentView: UIView!  // Новая view для масштабирования
    var imageNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .darkGray
        setupScrollView()
        loadImages()
    }

    private func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Настройка масштабирования
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // Инициализация contentView
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)  // Обеспечиваем, что ширина contentView соответствует scrollView
        ])
    }

    private func loadImages() {
        var lastImageViewBottomAnchor = contentView.topAnchor

        for imageName in imageNames {
            let imageView = UIImageView()
            if let image = UIImage(named: imageName) {
                imageView.image = image
            }
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            contentView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: lastImageViewBottomAnchor),
                imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: (imageView.image?.size.height ?? 1) / (imageView.image?.size.width ?? 1))
            ])
            
            lastImageViewBottomAnchor = imageView.bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            lastImageViewBottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // Метод делегата UIScrollView для масштабирования
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView  // contentView будет масштабироваться
    }
}
