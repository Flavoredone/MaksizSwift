

import UIKit

class SubstanceSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private var criteriaLabel: UILabel!
    private var segmentedControl: UISegmentedControl!
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    
  
        private let imagesForKeyword: [String: [String]] = [
            "705.jpg": [
                    "азотная кислота (70%)", "акриловая кислота", "акрилонитрил", "аммиак",
                    "аммония гидроксид (30%-й водный раствор аммиака)", "анилин", "ацетон",
                    "ацетонитрил", "бензин этилированный", "бензонитрил", "бром", "1,3-бутадиен",
                    "н-бутанол", "водород фтористый (безводный)", "водород хлористый",
                    "водород цианистый (сжиженный)", "гексан", "глутаровый альдегид (5%-й водный раствор)",
                    "дихлорметан", "диэтиламин", "йод", "калия хромат (насыщенный раствор соли)",
                    "калия цианид (10%)", "масляный альдегид", "метанол", "муравьиная кислота (96%)",
                    "натрия гидроксид (50%)", "натрия гидроксид концентрированный", "натрия гипохлорит (5,25% хлора)",
                    "нитробензол", "п-нитротолуол", "о-нитрохлорбензол", "п-нитрохлорбензол",
                    "олеум (40% свободного so3)", "перекись водорода (30%)", "перекись водорода (70%)",
                    "плавиковая кислота (48%)", "плавиковая кислота (70%)", "ртуть", "серная кислота (16%)",
                    "серная кислота (93%)", "серная кислота (98%)", "сероуглерод", "серы диоксид",
                    "синильная кислота", "соляная кислота (37%)", "сулема (насыщенный раствор)", "тетрагидрофуран",
                    "тетрахлорэтилен", "о-толуидин", "толуол", "2,4-толуолдиизоцианат", "2,2,2-трифторэтанол",
                    "1,2,4-трихлорбензол", "уксусная кислота (ледяная)", "фенол (85%)", "формальдегид (10%)",
                    "формальдегид (37%)", "фосфорная кислота (85%)", "хлор", "хлороформ", "хромовая кислота",
                    "этилацетат", "этиленгликоль", "этиленоксид", "этиленхлоргидрин"
                ],
                "701.jpg": [
                    "азотная кислота (30%)", "аммония гидроксид (30%-й водный раствор аммиака)",
                    "калия гидроксид (40%)", "калия хромат (насыщенный раствор соли)",
                    "калия цианид (насыщенный раствор соли)", "муравьиная кислота (30%)",
                    "натрия ацетат (насыщенный раствор соли)", "натрия гидроксид (40%)",
                    "натрия гипохлорит (12% хлора)", "натрия фторид (насыщенный раствор соли)",
                    "перекись водорода (30%)", "серная кислота (16%)", "серная кислота (30%)",
                    "соляная кислота (30%)", "сулема (насыщенный раствор)", "уксусная кислота (30%)",
                    "фосфорная кислота (50%)", "этиленгликоль"
                ],
            "702.jpg": [
                    "азотная кислота (30%)", "аммония гидроксид (30%-й водный раствор аммиака)",
                    "калия гидроксид (40%)", "калия хромат (насыщенный раствор соли)",
                    "калия цианид (насыщенный раствор соли)", "муравьиная кислота (30%)",
                    "натрия ацетат (насыщенный раствор соли)", "натрия гидроксид (40%)",
                    "натрия гипохлорит (12% хлора)", "натрия фторид (насыщенный раствор соли)",
                    "перекись водорода (30%)", "серная кислота (16%)", "серная кислота (30%)",
                    "соляная кислота (30%)", "сулема (насыщенный раствор)", "уксусная кислота (30%)",
                    "фосфорная кислота (50%)", "этиленгликоль"
                ],
                "706.jpg": [
                    "азотная кислота (30%)", "аммония гидроксид (30%-й водный раствор аммиака)",
                    "калия гидроксид (40%)", "калия хромат (насыщенный раствор соли)",
                    "калия цианид (насыщенный раствор соли)", "муравьиная кислота (30%)",
                    "натрия ацетат (насыщенный раствор соли)", "натрия гидроксид (40%)",
                    "натрия гипохлорит (12% хлора)", "натрия фторид (насыщенный раствор соли)",
                    "перекись водорода (30%)", "серная кислота (16%)", "серная кислота (30%)",
                    "соляная кислота (30%)", "сулема (насыщенный раствор)", "уксусная кислота (30%)",
                    "фосфорная кислота (50%)", "этиленгликоль"
                ],
                "707.jpg": [
                    "азота диоксид", "азотная кислота (70%)", "азотная кислота (свыше 90%, дымящая)", "акриламид (50%)", "акриловая кислота",
                    "акрилонитрил", "акролеин", "аллиловый спирт", "аллилхлорид", "н-амилацетат", "аммиак", "аммония гидроксид (30%-й водный раствор аммиака)",
                    "анилин", "антрацен (насыщенный раствор толуоле)", "ацетальдегид", "ацетон", "ацетонитрил", "бензин неэтилированный",
                    "бензин этилированный", "бензол", "бензонитрил", "бром", "1,3-бутадиен", "н-бутанол", "н-бутиловый эфир", "винилацетат",
                    "винилхлорид", "водород фтористый (безводный)", "водород хлористый", "гексаметилендиизоцианат", "гексан", "гидразин",
                    "дибромметан", "дибромэтан", "дизельное топливо", "n,n-диметил ацетамид", "диметил нитросамин", "диметил сульфид",
                    "диметил сульфоксид", "m,n-диметил формамид", "1,4-диоксан", "1-дихлор-2,3-пропен", "дихлорметан", "диэтиламин", "йод",
                    "калия хромат (насыщенный раствор соли)", "керосин (реактивное топливо а)", "o-креозол", "креозот", "изо-ксилол", "лупранат (дифенилметан-4,4-диозицинат)",
                    "метанол", "метилвинилкетон", "метилмеркаптан", "метилметакрилат", "2-метил-н-пирролидон", "метил-трет-бутиловый эфир",
                    "метилцеллозольв", "метилэтилкетон", "натрия гипохлорит (30% хлора)", "натрия цианид (45%)", "нафталин", "нитробензол",
                    "нитрометан", "плавиковая кислота (48%)", "плавиковая кислота (70%)", "полихлорированный дифенил в трансформаторном масле",
                    "полихлорированный дифенил, газовый конденсат", "1,2-пропиленоксид", "изо-пропиловый спирт", "ртуть", "серная кислота (93%)",
                    "серная кислота (95%)", "серная кислота (98%)", "сероуглерод", "серы диоксид", "соляная кислота (37%)", "стирол", "сулема (насыщенный раствор)",
                    "сурьмы пентахлорид", "2,2’,6,6’-тетрахлорбифенол", "тетрахлорметан", "триметилхинон", "1,1,3-трихлобензол", "трихлоруксусеая кислота",
                    "фосген", "фосфин", "фосфора окситрихлорид", "фосфора трихлорид", "фторбензол", "фурфурол", "хлорбензол", "хлорметил метиловый эфир",
                    "изо-циановой кислоты метиловый эфир", "циклогексан", "эпихлоргидрин", "этаноламин", "этилендиамин", "этилцеллозольв-ацетат"
                ]
                // ...
            ]
        
        

   

    
    
    private let titles = [
        "азотная кислота (30%)",
           "аммония гидроксид (30%-й водный раствор аммиака)",
           "калия гидроксид (40%)",
           "калия хромат (насыщенный раствор соли)",
           "калия цианид (насыщенный раствор соли)",
           "муравьиная кислота (30%)",
           "натрия ацетат (насыщенный раствор соли)",
           "натрия гидроксид (40%)",
           "натрия гипохлорит (12% хлора)",
           "натрия фторид (насыщенный раствор соли)",
           "перекись водорода (30%)",
           "серная кислота (16%)",
           "серная кислота (30%)",
           "соляная кислота (30%)",
           "сулема (насыщенный раствор)",
           "уксусная кислота (30%)",
           "фосфорная кислота (50%)",
           "этиленгликоль",
           "азотная кислота (70%)",
           "акриловая кислота",
           "акрилонитрил",
           "аммиак",
           "анилин",
           "ацетон",
           "ацетонитрил",
           "бензин этилированный",
           "бензонитрил",
           "бром",
           "1,3-бутадиен",
           "н-бутанол",
           "водород фтористый (безводный)",
           "водород хлористый",
           "водород цианистый (сжиженный)",
           "гексан",
           "глутаровый альдегид (5%-й водный раствор)",
           "дихлорметан",
           "диэтиламин",
           "йод",
           "калия цианид (10%)",
           "масляный альдегид",
           "метанол",
           "муравьиная кислота (96%)",
           "натрия гидроксид (50%)",
           "натрия гидроксид концентрированный",
           "натрия гипохлорит (5,25% хлора)",
           "нитробензол",
           "п-нитротолуол",
           "о-нитрохлорбензол",
           "п-нитрохлорбензол",
           "олеум (40% свободного so3)",
           "перекись водорода (70%)",
           "плавиковая кислота (48%)",
           "плавиковая кислота (70%)",
           "ртуть",
           "серная кислота (93%)",
           "серная кислота (98%)",
           "сероуглерод",
           "серы диоксид",
           "синильная кислота",
           "соляная кислота (37%)",
           "тетрагидрофуран",
           "тетрахлорэтилен",
           "о-толуидин",
           "толуол",
           "2,4-толуолдиизоцианат",
           "2,2,2-трифторэтанол",
           "1,2,4-трихлорбензол",
           "уксусная кислота (ледяная)",
           "фенол (85%)",
           "формальдегид (10%)",
           "формальдегид (37%)",
           "фосфорная кислота (85%)",
           "хлор",
           "хлороформ",
           "хромовая кислота",
           "этилацетат",
           "этиленоксид",
           "этиленхлоргидрин",
           "азота диоксид",
           "азотная кислота (свыше 90%, дымящая)",
           "акриламид (50%)",
           "акролеин",
           "аллиловый спирт",
           "аллилхлорид",
           "н-амилацетат",
           "антрацен (насыщенный раствор толуоле)",
           "ацетальдегид",
           "бензин неэтилированный",
           "бензол",
           "н-бутиловый эфир",
           "винилацетат",
           "винилхлорид",
           "гексаметилендиизоцианат",
           "гидразин",
           "дибромметан",
           "дибромэтан",
           "дизельное топливо",
           "n,n-диметил ацетамид",
           "диметил нитросамин",
           "диметил сульфид",
           "диметил сульфоксид",
           "m,n-диметил формамид",
           "1,4-диоксан",
           "1-дихлор-2,3-пропен",
           "керосин (реактивное топливо а)",
           "o-креозол",
           "креозот",
           "изо-ксилол",
           "лупранат (дифенилметан-4,4-диозицинат)",
           "метилвинилкетон",
           "метилмеркаптан",
           "метилметакрилат",
           "2-метил-н-пирролидон",
           "метил-трет-бутиловый эфир",
           "метилцеллозольв",
           "метилэтилкетон",
           "натрия гипохлорит (30% хлора)",
           "натрия цианид (45%)",
           "нафталин",
           "нитрометан",
           "полихлорированный дифенил в трансформаторном масле",
           "полихлорированный дифенил, газовый конденсат",
           "1,2-пропиленоксид",
           "изо-пропиловый спирт",
           "серная кислота (95%)",
           "стирол",
           "сурьмы пентахлорид",
           "2,2’,6,6’-тетрахлорбифенол",
           "тетрахлорметан",
           "триметилхинон",
           "1,1,3-трихлобензол",
           "трихлоруксусеая кислота",
           "фосген",
           "фосфин",
           "фосфора окситрихлорид",
           "фосфора трихлорид",
           "фторбензол",
           "фурфурол",
           "хлорбензол",
           "хлорметил метиловый эфир",
           "изо-циановой кислоты метиловый эфир",
           "циклогексан",
           "эпихлоргидрин",
           "этаноламин",
           "этилендиамин",
           "этилцеллозольв-ацетат"

        ]
    
    private var filteredTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.tintColor = .white

        setupCriteriaLabel()
        setupSegmentedControl()
        setupSearchBar()
        setupTableView()
        
        
        segmentedControl.isHidden = true
       // filteredTitles = titles
        
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

        criteriaLabel.text = "ПОИСК ПО ВЕЩЕСТВУ:"
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
        // Инициализация searchBar и настройка внешнего вида
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Введите запрос..."
        searchBar.searchBarStyle = .prominent
        searchBar.barTintColor = .darkGray
        searchBar.tintColor = .white

        // Добавление searchBar к основному представлению
        view.addSubview(searchBar)

        // Установка делегата searchBar
        searchBar.delegate = self
        searchBar.showsCancelButton = true

        // Установка ограничений для searchBar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5), // Расположение ниже segmentedControl на 5 пунктов
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),                     // Выравнивание по левому краю основного представления
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)                    // Выравнивание по правому краю основного представления
        ])
    }


    private func setupTableView() {
        // Инициализация tableView
        tableView = UITableView()
        
        // Установка auto-layout для tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление tableView в основное представление
        view.addSubview(tableView)
        
        // Установка ограничений для tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5), // Ниже на 5 пунктов от searchBar
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),             // Выравнивание по левому краю основного представления
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),           // Выравнивание по правому краю основного представления
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // Ниже до нижнего края безопасной зоны
        ])
        
        // Назначение источника данных и делегата tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        // Регистрация класса ячейки для использования в tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Дополнительная настройка tableView (если необходимо)
        tableView.backgroundColor = .darkGray  // Установка цвета фона
        tableView.separatorStyle = .singleLine // Установка стиля разделителя
    }


    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return filteredTitles.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Идентификатор переиспользуемой ячейки
        let cellIdentifier = "cell"
        
        // Запрос переиспользуемой ячейки из таблицы или создание новой, если таковой нет
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Установка текста ячейки равным элементу из отфильтрованного списка
        cell.textLabel?.text = filteredTitles[indexPath.row]
        
        // Настройка внешнего вида ячейки
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
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNumber = titles[indexPath.row]
        var imagesToShow: [String] = []

        for (image, numbers) in imagesForKeyword {
            if numbers.contains(selectedNumber) {
                imagesToShow.append(image)
            }
        }
        
        
        if !imagesToShow.isEmpty {
            let imagesDisplayVC = ImagesDisplayViewController()
            imagesDisplayVC.imageNames = imagesToShow
            let backItem = UIBarButtonItem()
            backItem.title = "Назад"
            navigationItem.backBarButtonItem = backItem
            navigationController?.pushViewController(imagesDisplayVC, animated: true)
        }
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredTitles = [] // Очищаем результаты при пустом поиске
        } else {
            // Фильтруем по запросу, игнорируя регистр
            filteredTitles = titles.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData() // Обновляем таблицу
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""               // Очистка текста поиска
            filteredTitles = []               // Очистка отфильтрованных заголовков
            tableView.reloadData()            // Обновление данных таблицы
            searchBar.resignFirstResponder()  // Скрытие клавиатуры
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true) // Показ кнопки отмены при редактировании
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true) // Скрытие кнопки отмены при окончании редактирования
        }
}
