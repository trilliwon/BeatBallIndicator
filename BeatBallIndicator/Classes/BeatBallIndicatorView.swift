import UIKit

public enum BeatBallIndicatorType: Int {
	case ballBeat
	func animation() -> BeatBallIndicatorAnimationDelegate {
		return BeatBallIndicatorAnimationBallBeat()
	}
}

/// Activity indicator view with nice animations
public final class BeatBallIndicatorView: UIView {
	/// Default type. Default value is .BallSpinFadeLoader.
	public static var defaultType: BeatBallIndicatorType = .ballBeat

	/// Default color of activity indicator. Default value is UIColor.white.
	public static var defaultColor = UIColor.white

	/// Default color of text. Default value is UIColor.white.
	public static var defaultTextColor = UIColor.white

	/// Default padding. Default value is 0.
	public static var defaultPadding: CGFloat = 0

	/// Default size of activity indicator view in UI blocker. Default value is 60x60.
	public static var defaultBlockerSize = CGSize(width: 60, height: 60)

	/// Default display time threshold to actually display UI blocker. Default value is 0 ms.
	public static var defaultBlockerDisplayTimeThreshold = 0

	/// Default minimum display time of UI blocker. Default value is 0 ms.
	public static var defaultBlockerMinimumDisplayTIme = 0

	/// Default message displayed in UI blocker. Default value is nil.
	public static var defaultBlockerMessage: String? = nil

	/// Default font of message displayed in UI blocker. Default value is bold system font, size 20.
	public static var defaultBlockerMessageFont = UIFont.boldSystemFont(ofSize: 20)

	/// Default background color of UI blocker. Default value is UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
	public static var defaultBlcokerBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

	/// Animation type.
	public var type: BeatBallIndicatorType = BeatBallIndicatorView.defaultType

	@available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
	@IBInspectable var typeName: String {
		get {
			return getTypeName()
		}
		set {
			_setTypeName(newValue)
		}
	}

	/// Color of activity indicator view.
	@IBInspectable public var color: UIColor = BeatBallIndicatorView.defaultColor

	/// Padding of activity indicator view.
	@IBInspectable public var padding: CGFloat = BeatBallIndicatorView.defaultPadding

	/// Current status of animation, read-only.
	@available(*, deprecated: 3.1)
	public var animating: Bool { return isAnimating }

	/// Current status of animation, read-only.
	public private(set) var isAnimating: Bool = false

	/**
	Returns an object initialized from data in a given unarchiver.
	self, initialized using the data in decoder.

	- parameter decoder: an unarchiver object.

	- returns: self, initialized using the data in decoder.
	*/
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		backgroundColor = UIColor.clear
		isHidden = true
	}

	/**
	Create a activity indicator view.

	Appropriate BeatBallIndicatorView.DEFAULT_* values are used for omitted params.

	- parameter frame:   view's frame.
	- parameter type:    animation type.
	- parameter color:   color of activity indicator view.
	- parameter padding: padding of activity indicator view.

	- returns: The activity indicator view.
	*/
	public init(frame: CGRect, type: BeatBallIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil) {
		self.type = type ?? BeatBallIndicatorView.defaultType
		self.color = color ?? BeatBallIndicatorView.defaultColor
		self.padding = padding ?? BeatBallIndicatorView.defaultPadding
		super.init(frame: frame)
		isHidden = true
	}

	// Fix issue #62
	// Intrinsic content size is used in autolayout
	// that causes mislayout when using with MBProgressHUD.
	/**
	Returns the natural size for the receiving view, considering only properties of the view itself.

	A size indicating the natural size for the receiving view based on its intrinsic properties.

	- returns: A size indicating the natural size for the receiving view based on its intrinsic properties.
	*/
	public override var intrinsicContentSize : CGSize {
		return CGSize(width: bounds.width, height: bounds.height)
	}

	/**
	Start animating.
	*/
	public final func startAnimating() {
		isHidden = false
		isAnimating = true
		layer.speed = 1
		setUpAnimation()
	}

	/**
	Stop animating.
	*/
	public final func stopAnimating() {
		isHidden = true
		isAnimating = false
		layer.sublayers?.removeAll()
	}

	// MARK: Internal

	func _setTypeName(_ typeName: String) {
		if String(describing: BeatBallIndicatorType.ballBeat).caseInsensitiveCompare(typeName) == ComparisonResult.orderedSame {
			type = BeatBallIndicatorType.ballBeat
		}
	}

	func getTypeName() -> String {
		return String(describing: type)
	}

	// MARK: Privates

	private final func setUpAnimation() {
		let animation: BeatBallIndicatorAnimationDelegate = type.animation()
		var animationRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
		let minEdge = min(animationRect.width, animationRect.height)

		layer.sublayers = nil
		animationRect.size = CGSize(width: minEdge, height: minEdge)
		animation.setUpAnimation(in: layer, size: animationRect.size, color: color)
	}
}
