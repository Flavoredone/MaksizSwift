import UIKit

class DocumentationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let thumbnails = [
        "1-свидетельство-асиз.jpg",
        "2-ру-от-29-08.jpg",
        "3-заключение-минпромторга.jpg",
        "4-заключение-минпромторга.jpg",
        "5-заключение-минпроторга.jpg",
        "6-сертификат-тр-тс-019-2011.jpg",
        "7-испытания-на-пламя.jpg",
        "8-декларация-ruguard.jpg",
        "9-декларация-ruguard.jpg"
    ]
    
    let detailImages = [
        "1б-свидетельство-асиз.jpg",
        "2б-ру-от-29-08.jpg",
        "3б-заключение-минпромторга.jpg",
        "4б-заключение-минпромторга.jpg",
        "5б-заключение-минпроторга.jpg",
        "6б-сертификат-тр-тс-019-2011.jpg",
        "7б-испытания-на-пламя.jpg",
        "8б-декларация-ruguard.jpg",
        "9б-декларация-ruguard.jpg"
    ]
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupCollectionView()
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.tintColor = .white
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - 20, height: view.frame.width / 2 - 20)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DocumentCell")
        collectionView.backgroundColor = .darkGray
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let zoomVC = ImageZoomViewController()
        zoomVC.imageName = detailImages[indexPath.row]  // Передача детального изображения
        zoomVC.modalPresentationStyle = .fullScreen
        present(zoomVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentCell", for: indexPath)
        cell.backgroundColor = .darkGray  // Темно-серый фон для ячеек

        // Удаление предыдущих изображений, если они есть
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        // Добавление миниатюрного изображения
        let image = UIImage(named: thumbnails[indexPath.row])
        let imageView = UIImageView(image: image)
        imageView.frame = cell.bounds
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)

        return cell
    }
}

import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate { // 1. Conform to UIScrollViewDelegate
    var imageName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        guard let imageName = imageName, let image = UIImage(named: imageName) else { return }

        // Создание UIScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.delegate = self // 2. Set the delegate to self
        view.addSubview(scrollView)

        // Конфигурация UIScrollView для поддержки масштабирования и панорамирования
        scrollView.minimumZoomScale = 1.0 // 3. Set minimum zoom scale
        scrollView.maximumZoomScale = 6.0 // 4. Set maximum zoom scale

        // Установка ограничений для UIScrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])

        // Создание UIImageView
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        
        // Установка ограничений для UIImageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: image.size.height / image.size.width)
        ])

        // Добавление кнопки "Назад"
        let backButton = UIButton()
        backButton.setTitle("Назад", for: .normal)
        backButton.backgroundColor = .gray.withAlphaComponent(0.8)
        backButton.layer.cornerRadius = 5
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(backButton)

        // Установка ограничений для кнопки "Назад"
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 80),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // 5. Implement the UIScrollViewDelegate method to specify the view to zoom
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first as? UIImageView
    }

    @objc func close() {
        dismiss(animated: true)
    }
}
