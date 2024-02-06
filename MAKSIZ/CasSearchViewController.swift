
import UIKit

class CasSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private var criteriaLabel: UILabel!
    private var segmentedControl: UISegmentedControl!
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    
  
        private let imagesForKeyword: [String: [String]] = [
            "705.jpg": ["7697-37-2", "79-10-7", "107-13-1", "7664-41-7", "1336-21-6", "62-53-3", "62-53-3", "75-05-8", "86290-81-5", "100-47-0", "7726-95-6", "106-99-0", "71-36-3", "7663-39-3", "7647-01-0", "74-90-8", "110-54-3", "56-81-5", "75-09-2", "109-89-7", "7553-56-2", "7789-00-6", "151-50-08", "123-72-8", "67-56-1", "64-18-6", "1310-73-2", "1310-73-2", "7681-52-9", "98-95-3", "99-99-0", "88-73-3", "100-00-5", "8014-95-7", "7722-84-1", "7722-84-1", "7664-39-3", "7664-39-3", "7439-97-6", "7664-93-9", "7664-93-9", "7664-93-9", "75-15-0", "7446-09-5", "74-90-8", "7647-01-0", "7487-94-7", "109-99-9", "127-18-4", "95-53-4", "108-88-3", "584-84-9", "75-89-8", "120-82-1", "64-19-7", "108-95-2", "50-00-0", "50-00-0", "7664-38-2", "7782-50-05", "67-66-3", "1333-82-0", "141-78-6", "107-21-1", "75-21-8", "107-07-3"],
            
            "701.jpg": [
                "7697-37-2", "1336-21-6", "1310-58-3", "7789-00-6", "151-50-8", "64-18-6", "127-09-3", "1310-73-2", "7681-52-9", "7681-49-4", "7722-84-1", "7664-93-9", "7647-01-0", "7487-94-7", "64-19-7", "7664-38-2", "107-21-1"
            ],
            "702.jpg": [
                "7697-37-2", "1336-21-6", "1310-58-3", "7789-00-6", "151-50-8", "64-18-6", "127-09-3", "1310-73-2", "7681-52-9", "7681-49-4", "7722-84-1", "7664-93-9", "7647-01-0", "7487-94-7", "64-19-7", "7664-38-2", "107-21-1"
            ],
            "706.jpg": [
                "7697-37-2", "1336-21-6", "1310-58-3", "7789-00-6", "151-50-8", "64-18-6", "127-09-3", "1310-73-2", "7681-52-9", "7681-49-4", "7722-84-1", "7664-93-9", "7647-01-0", "7487-94-7", "64-19-7", "7664-38-2", "107-21-1"
            ],
            "707.jpg": [
                "10102-44-0", "7697-37-2", "7607-37-2", "79-06-1", "79-10-7", "107-13-1",
                    "107-02-8", "107-18-6", "107-05-1", "628-63-7", "7664-41-7", "1336-21-6",
                    "62-53-3", "120-12-7", "67-64-1", "75-05-8", "8006-61-9", "86290-81-5",
                    "71-43-2", "100-47-0", "7726-95-6", "106-99-0", "71-36-3", "142-96-1",
                    "108-05-4", "75-01-4", "7663-39-3", "7647-01-0", "822-06-0", "110-54-3",
                    "302-01-2", "74-95-3", "106-93-4", "70892-10-3", "127-19-5", "62-75-9",
                    "75-18-3", "67-68-5", "68-12-2", "123-91-1", "78-88-6", "75-09-2",
                    "109-89-7", "7553-56-2", "7789-00-6", "8008-20-8", "95-48-7", "8001-58-9",
                    "1330-20-7", "9016-87-9", "67-56-1", "78-94-4", "74-93-1", "80-62-6",
                    "872-50-4", "1634-04-4", "109-86-4", "78-93-3", "64-18-6", "1310-73-2",
                    "7681-52-9", "143-33-9", "91-20-3", "98-95-3", "75-52-5", "7664-39-3",
                    "11097-69-1", "75-56-9", "67-63-0", "7439-97-6", "7664-93-9", "75-15-0",
                    "7446-09-5", "100-42-5", "7487-94-7", "7647-18-9", "109-99-9", "79-95-8",
                    "56-23-5", "127-18-4", "95-53-4", "108-88-3", "584-84-9", "935-92-2",
                    "921-03-9", "120-82-1", "76-03-9", "64-19-7", "108-95-2", "50-00-0",
                    "75-44-5", "7803-51-2", "10025-87-3", "7719-12-2", "7664-38-2", "462-06-6",
                    "98-01-1", "7782-50-05", "108-90-7", "107-30-2", "67-66-3", "624-83-9",
                    "110-82-7", "106-89-8", "141-43-5", "141-78-6", "107-21-1", "107-15-3",
                    "75-21-8", "107-07-3", "111-15-9"

            ]
        ]

   

    
    
    private let titles = [
        "7697-37-2",
            "1336-21-6",
            "1310-58-3",
            "7789-00-6",
            "151-50-8",
            "64-18-6",
            "127-09-3",
            "1310-73-2",
            "7681-52-9",
            "7681-49-4",
            "7722-84-1",
            "7664-93-9",
            "7647-01-0",
            "7487-94-7",
            "64-19-7",
            "7664-38-2",
            "107-21-1",
            "79-10-7",
            "107-13-1",
            "7664-41-7",
            "62-53-3",
            "75-05-8",
            "86290-81-5",
            "100-47-0",
            "7726-95-6",
            "106-99-0",
            "71-36-3",
            "7663-39-3",
            "74-90-8",
            "110-54-3",
            "56-81-5",
            "75-09-2",
            "109-89-7",
            "7553-56-2",
            "151-50-08",
            "123-72-8",
            "67-56-1",
            "98-95-3",
            "99-99-0",
            "88-73-3",
            "100-00-5",
            "8014-95-7",
            "7664-39-3",
            "7439-97-6",
            "75-15-0",
            "7446-09-5",
            "109-99-9",
            "127-18-4",
            "95-53-4",
            "108-88-3",
            "584-84-9",
            "75-89-8",
            "120-82-1",
            "108-95-2",
            "50-00-0",
            "7782-50-05",
            "67-66-3",
            "1333-82-0",
            "141-78-6",
            "75-21-8",
            "107-07-3",
            "10102-44-0",
            "7607-37-2",
            "79-06-1",
            "107-02-8",
            "107-18-6",
            "107-05-1",
            "628-63-7",
            "120-12-7",
            "67-64-1",
            "8006-61-9",
            "71-43-2",
            "142-96-1",
            "108-05-4",
            "75-01-4",
            "822-06-0",
            "302-01-2",
            "74-95-3",
            "106-93-4",
            "70892-10-3",
            "127-19-5",
            "62-75-9",
            "75-18-3",
            "67-68-5",
            "68-12-2",
            "123-91-1",
            "78-88-6",
            "8008-20-8",
            "95-48-7",
            "8001-58-9",
            "1330-20-7",
            "9016-87-9",
            "78-94-4",
            "74-93-1",
            "80-62-6",
            "872-50-4",
            "1634-04-4",
            "109-86-4",
            "78-93-3",
            "143-33-9",
            "91-20-3",
            "75-52-5",
            "11097-69-1",
            "75-56-9",
            "67-63-0",
            "100-42-5",
            "7647-18-9",
            "79-95-8",
            "56-23-5",
            "935-92-2",
            "921-03-9",
            "76-03-9",
            "75-44-5",
            "7803-51-2",
            "10025-87-3",
            "7719-12-2",
            "462-06-6",
            "98-01-1",
            "108-90-7",
            "107-30-2",
            "624-83-9",
            "110-82-7",
            "106-89-8",
            "141-43-5",
            "107-15-3",
            "111-15-9"

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

        criteriaLabel.text = "ПОИСК ПО НОМЕРУ CAS:"
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
        let selectedNumber = filteredTitles[indexPath.row]  // Получаем выбранный номер CAS из отфильтрованного списка
        var imagesToShow: [String] = []

        // Проходим по всем изображениям и их связанным номерам CAS
        for (image, numbers) in imagesForKeyword {
            // Если номера для изображения содержат выбранный номер, добавляем изображение в список
            if numbers.contains(selectedNumber) {
                imagesToShow.append(image)
            }
        }

        // Если есть изображения для отображения, переходим к следующему экрану и передаем их
        if !imagesToShow.isEmpty {
            let imagesDisplayVC = ImagesDisplayViewController()
            imagesDisplayVC.imageNames = imagesToShow  // Передаем отфильтрованный список изображений
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
