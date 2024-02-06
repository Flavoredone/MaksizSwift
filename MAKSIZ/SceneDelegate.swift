import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Создание нового UIWindow с использованием windowScene
        let window = UIWindow(windowScene: windowScene)

        // Создание экземпляра ViewController
        let mainViewController = ViewController()

        // Создание UINavigationController с ViewController в качестве корневого контроллера
        let navigationController = UINavigationController(rootViewController: mainViewController)

        // Установка UINavigationController как rootViewController окна
        window.rootViewController = navigationController

        // Сохранение и отображение окна
        self.window = window
        window.makeKeyAndVisible()
    }

    // ... оставшиеся методы SceneDelegate
}
