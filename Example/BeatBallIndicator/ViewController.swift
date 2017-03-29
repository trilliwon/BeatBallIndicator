import UIKit
import BeatBallIndicator

class ViewController: UIViewController, BeatBallIndicatorViewable {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = .black
		let frame = CGRect(x: 100, y: 100, width: 300, height: 50)
		let activityIndicatorView = BeatBallIndicatorView(frame: frame)
		activityIndicatorView.center = self.view.center
		self.view.addSubview(activityIndicatorView)
		activityIndicatorView.startAnimating()
	}
}

