
class GetCurrentViewController() -> UIViewController {

    let app = UIApplication.shared
    return app.keyWindow?.rootViewController

}