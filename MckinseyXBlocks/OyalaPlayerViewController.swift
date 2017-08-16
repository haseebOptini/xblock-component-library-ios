//
//  OyalaPlayerViewController.swift
//  MckinseyXBlocks
//
//  Created by Salman Jamil on 8/9/17.
//  Copyright © 2017 Salman Jamil. All rights reserved.
//

import UIKit
import Wrapper
import Foundation
import WebKit

public protocol OyalaPlayerDelegate {
    
}

public enum State {
    case initital // player is created but no content is loaded
    case loading // loading content
    case ready // ready to play
    case playing
    case paused
    case completed
    case error
}

private class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect = rect.insetBy(dx: 0, dy: -0.75)
        rect.origin.y = rect.origin.y - 1.25
        return rect
    }
}

public enum VideoGravity {
    case resize
    case resizeAspectFit
    case resizeAspectFill
}

@available(iOS 9.0, *)
protocol ControlOverlayViewDelegate: class {
    func controlOverlayViewDidTogglePlayState(_ view: ControlOverlayView)
}

func format(timeInterval: Float64) -> String {
    let duration: TimeInterval = timeInterval
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [ .minute, .second ]
    formatter.zeroFormattingBehavior = [ .pad ]
    
    guard let formatted = formatter.string(from: duration) else {
        fatalError()
    }
    
    return formatted
}

@available(iOS 9.0, *)
public class ControlOverlayView: UIView {
    
    let playButton: UIButton
    let totalDurationLabel: UILabel
    let playedDurationLabel: UILabel
    
    weak var delegate: ControlOverlayViewDelegate?
    
    public init(totalDuration: Float?) {
        totalDurationLabel = UILabel()

        playButton = UIButton()
        playedDurationLabel = UILabel()
        super.init(frame: .zero)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(self.playTapped(_:)), for: .touchUpInside)
        let bundle = Bundle(for: ControlOverlayView.self)
        let image = UIImage(named: "pauseIcon", in: bundle, compatibleWith: nil)
        playButton.setImage(image, for: .normal)
        backgroundColor = UIColor.clear
        addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let stackView = UIStackView(arrangedSubviews: [totalDurationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 8.0).isActive = true
        bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8.0).isActive = true
        if let duration = totalDuration {
            totalDurationLabel.text = format(timeInterval: Float64(duration))
        } else {
            totalDurationLabel.text = "0:00"
        }
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        totalDurationLabel.textColor = UIColor.white
        totalDurationLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        
        //full Screen Icon
        
        let fullScreenImage = UIImage(named: "FullScreenIcon", in: bundle, compatibleWith: nil)
        let fullScreenButton = UIButton(type: .custom)
        fullScreenButton.setImage(fullScreenImage, for: .normal)
        stackView.addArrangedSubview(fullScreenButton)
        
        
        //played Duration label
        playedDurationLabel.font = UIFont.systemFont(ofSize: 12.0)
        playedDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playedDurationLabel)
        playedDurationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        bottomAnchor.constraint(equalTo: playedDurationLabel.bottomAnchor, constant: 8.0).isActive = true
        playedDurationLabel.text = "0:00"
        playedDurationLabel.textColor = UIColor.white
    }
    
    func playTapped(_ sender: UIButton) {
        delegate?.controlOverlayViewDidTogglePlayState(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playheadTimeUpdated(_ notification: Notification) {
        guard let player = notification.object as? OOOoyalaPlayer else {
            return
        }
        
        totalDurationLabel.text = format(timeInterval: player.duration())
        playedDurationLabel.text = format(timeInterval: player.playheadTime())
    }
    
    func playerStateUpdated(_ notification: Notification) {
        guard let player = notification.object as? OOOoyalaPlayer else {
            return
        }
        
        let bundle = Bundle(for: ControlOverlayView.self)
        if player.state() == OOOoyalaPlayerStatePlaying {
            let image = UIImage(named: "pauseIcon", in: bundle, compatibleWith: nil)
            playButton.setImage(image, for: .normal)
        } else if player.state() == OOOoyalaPlayerStatePaused {
            let image = UIImage(named: "playIcon", in: bundle, compatibleWith: nil)
            playButton.setImage(image, for: .normal)
        } else if player.state() == OOOoyalaPlayerStateCompleted {
            let image = UIImage(named: "playIcon", in: bundle, compatibleWith: nil)
            playButton.setImage(image, for: .normal)
        }
    }
}

@available(iOS 9.0, *)
extension UIActivityIndicatorView {
    override func configure(in view: UIView) {
        hidesWhenStopped = true
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startAnimating()
    }
}

@available(iOS 9.0, *)
extension UIView {
    func configure(in view: UIView) {
        
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

@available(iOS 9.0, *)
protocol OverlayViewDelegate: class {
    func overlayViewDidTogglePlayState(_ view: OverlayView)
}

@available(iOS 9.0, *)
class OverlayView: UIView {
    
    let player: OOOoyalaPlayer
    
    init(player: OOOoyalaPlayer) {
        self.player = player
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentView: UIView? = nil
    weak var delegate: OverlayViewDelegate?
    var state: OOOoyalaPlayerState = OOOoyalaPlayerStateInit {
        didSet {
            currentView?.removeFromSuperview()
            switch state {
            case OOOoyalaPlayerStateLoading:
                let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
                activityIndicatorView.configure(in: self)
                currentView = activityIndicatorView
            case OOOoyalaPlayerStatePlaying:
                let overlay = ControlOverlayView(totalDuration: Float(player.duration()))
                overlay.delegate = self
                overlay.configure(in: self)
                NotificationCenter.default.addObserver(overlay, selector: #selector(overlay.playheadTimeUpdated(_:)), name: NSNotification.Name.OOOoyalaPlayerTimeChanged, object: player)
                NotificationCenter.default.addObserver(overlay, selector: #selector(overlay.playerStateUpdated(_:)), name: NSNotification.Name.OOOoyalaPlayerStateChanged, object: player)
                currentView = overlay
            default:
                break
            }
        }
    }
}

@available(iOS 9.0, *)
extension OverlayView : ControlOverlayViewDelegate {
    func controlOverlayViewDidTogglePlayState(_ view: ControlOverlayView) {
        delegate?.overlayViewDidTogglePlayState(self)
    }
}


@available(iOS 9.0, *)
public class OyalaPlayer: NSObject {
    fileprivate let internalPlayer: OOOoyalaPlayer
    private let containerView: UIView
    private let progressView: UIProgressView
    let overlay: OverlayView
    let slider: UISlider
    private var hideOverlayOperation: Operation?
    //monitors whether the slider is sliding
    private var isSliding = false
    
    public var state: State {
        switch  internalPlayer.state() {
        case OOOoyalaPlayerStateInit:
            return .initital
        case OOOoyalaPlayerStateLoading:
            return .loading
        case OOOoyalaPlayerStateReady:
            return .ready
        case OOOoyalaPlayerStatePlaying:
            return .playing
        case OOOoyalaPlayerStatePaused:
            return .paused
        case OOOoyalaPlayerStateCompleted:
            return .completed
        case OOOoyalaPlayerStateError:
            return .error
        default:
            return .error
        }
    }
    
    public var view: UIView {
        return containerView
    }
    
    public var videoGravity: VideoGravity {
        get {
            switch internalPlayer.videoGravity {
            case OOOoyalaPlayerVideoGravityResize:
                return .resize
            case OOOoyalaPlayerVideoGravityResizeAspect:
                return .resizeAspectFit
            case OOOoyalaPlayerVideoGravityResizeAspectFill:
                return .resizeAspectFill
            default:
                fatalError("Could not find video gravity for internal player")
            }
        } set (newVaule) {
            switch newVaule {
            case .resize:
                internalPlayer.videoGravity = OOOoyalaPlayerVideoGravityResize
            case .resizeAspectFill:
                internalPlayer.videoGravity = OOOoyalaPlayerVideoGravityResizeAspectFill
            case .resizeAspectFit:
                internalPlayer.videoGravity = OOOoyalaPlayerVideoGravityResizeAspect
            }
        }
    }
    
    public func play() {
        internalPlayer.play()
        overlay.state = OOOoyalaPlayerStateLoading
    }
    
    public init(domain: String, playerCode: String, contentID: String) {
        let domain = OOPlayerDomain(string: domain)
        internalPlayer = OOOoyalaPlayer(pcode: playerCode, domain: domain)
        internalPlayer.setEmbedCode(contentID)
        containerView = UIView()
        containerView.addSubview(internalPlayer.view)
        internalPlayer.view.translatesAutoresizingMaskIntoConstraints = false
        internalPlayer.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        internalPlayer.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        internalPlayer.view.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        internalPlayer.view.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        overlay = OverlayView(player: internalPlayer)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(overlay)
        progressView = UIProgressView(progressViewStyle: .default)
        slider = CustomSlider()
        super.init()
        overlay.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tapGestureRecognizer)
        overlay.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        overlay.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        overlay.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleStateChange(notification:)), name: NSNotification.Name.OOOoyalaPlayerStateChanged, object: internalPlayer)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playheadTimeUpdated(notification:)), name: NSNotification.Name.OOOoyalaPlayerTimeChanged, object: internalPlayer)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleMetadeta(notification:)), name: NSNotification.Name.OOOoyalaPlayerMetadataReady, object: internalPlayer)
        NotificationCenter.default.addObserver(self, selector: #selector(self.seekStarted(notification:)), name: NSNotification.Name.OOOoyalaPlayerSeekStarted, object: internalPlayer)
        NotificationCenter.default.addObserver(self, selector: #selector(self.seekEnded(notification:)), name: NSNotification.Name.OOOoyalaPlayerSeekCompleted, object: internalPlayer)
        
        //progress View
        progressView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(progressView)
        progressView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        progressView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 4.0).isActive = true
        progressView.progress = 0.0
        progressView.progressTintColor = UIColor.lightGray
        progressView.trackTintColor = UIColor.clear
        progressView.backgroundColor = UIColor.clear
        
        
        //slider
        slider.isContinuous = true
        let bundle = Bundle(for: ControlOverlayView.self)
        let image = UIImage(named: "circle", in: bundle, compatibleWith: nil)
        slider.setThumbImage(image, for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(slider)
        slider.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        slider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        slider.minimumTrackTintColor = UIColor(red:0.89, green:0.45, blue:0.13, alpha:1)
        slider.maximumTrackTintColor = UIColor.clear
        slider.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        slider.addTarget(self, action: #selector(self.seekAction(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(self.slidingSessionEnded(_:)), for: [.touchUpInside, .touchUpOutside])
    
    }
    
    
    func seekAction(_ sender: UISlider) {
        isSliding = true
        internalPlayer.seek(Float64(sender.value))
    }
    
    func slidingSessionEnded(_ sender: UISlider) {
        isSliding = false
    }
    
    func seekStarted(notification: Notification) {
        overlay.state = OOOoyalaPlayerStateLoading
        showOverlay(animated: false)
    }
    
    func seekEnded(notification: Notification) {
        overlay.state = OOOoyalaPlayerStatePlaying
        hideOverlay(animated: false)
    }
    
    func handleMetadeta(notification: Notification) {
        if let player = notification.object as? OOOoyalaPlayer {
            slider.minimumValue = 0.0
            slider.maximumValue = Float(player.duration())
        }
    }
    
    private func hideOverlay(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: { 
                self.overlay.alpha = 0.0
            })
        } else {
            self.overlay.alpha = 0.0
        }
    }
    
    private func showOverlay(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: { 
                self.overlay.alpha = 1.0
            })
        } else {
            self.overlay.alpha = 0.0
        }
        hideOverlayOperation = BlockOperation {
            if self.state == .playing || self.state == .paused {
                self.hideOverlay(animated: true)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { 
            if self.hideOverlayOperation?.isCancelled == false {
                self.hideOverlayOperation?.start()
            }
        }
    }
    
    func playheadTimeUpdated(notification: Notification) {
        if let player = notification.object as? OOOoyalaPlayer {
            if isSliding == false {
                slider.setValue(Float(player.playheadTime()), animated: true)
            }
            if player.duration() > 0 {
                progressView.progress = (Float(player.bufferedTime() / player.duration()))
            }
        }
    }
    
    func handleStateChange(notification: Notification) {
        if let player = notification.object as? OOOoyalaPlayer {
            let state = player.state()
            slider.maximumValue = Float(player.duration())
            
            handle(state: state)
        }
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        if internalPlayer.state() == OOOoyalaPlayerStateLoading {
            return
        }
        
        if overlay.alpha == 0.0 {
            showOverlay(animated: true)
        } else {
            hideOverlay(animated: true)
        }
    }
    
    func handle(state: OOOoyalaPlayerState) {
        switch state {
        case OOOoyalaPlayerStateLoading:
            overlay.state = state
        case OOOoyalaPlayerStatePlaying:
            overlay.state = state
        default:
            break
        }
    }
    
}

@available(iOS 9.0, *)
extension OyalaPlayer : OverlayViewDelegate {
    func overlayViewDidTogglePlayState(_ view: OverlayView) {
        if internalPlayer.state() == OOOoyalaPlayerStatePlaying {
            internalPlayer.pause()
        } else {
            internalPlayer.play()
        }
    }
}

/* 
 A simple wrapper around OOOOyalaPlayerViewController
 This doesn't have the UICustomization We want for now though
 */

@available(iOS 9.0, *)
public class OyalaPlayerViewController: UIViewController {

    // the wrapped ViewController
    private var internalPalyer: OOOoyalaPlayerViewController!
    fileprivate let webView: WKWebView
    fileprivate let exchangeRequest: URLRequest?
    fileprivate let request: URLRequest?
    public var state: State {
        switch  internalPalyer.player.state() {
        case OOOoyalaPlayerStateInit:
            return .initital
        case OOOoyalaPlayerStateLoading:
            return .loading
        case OOOoyalaPlayerStateReady:
            return .ready
        case OOOoyalaPlayerStatePlaying:
            return .playing
        case OOOoyalaPlayerStatePaused:
            return .paused
        case OOOoyalaPlayerStateCompleted:
            return .completed
        case OOOoyalaPlayerStateError:
            return .error
        default:
            return .error
        }
    }
    
    /// The wrapped player. you can observe it directly for different state changes....
    public var player: OOOoyalaPlayer {
        return internalPalyer.player
    }

    /// Creates a new ViewController given the following parameters
    /// - Parameter contentID: The content-id from ooyala backlot
    /// - Parameter domain: The domain where the content is hosted
    /// - Parameter pcode: The player code obtained from ooyala account
    public init(contentID: String, domain: String, pcode: String, exchangeRequest: URLRequest? = nil, request: URLRequest? = nil) {
        webView = WKWebView()
        self.request = request
        self.exchangeRequest = exchangeRequest
        super.init(nibName: nil, bundle: nil)
        loadViewIfNeeded()
        let domain = OOPlayerDomain(string: domain)
        let player = OOOoyalaPlayer(pcode: pcode, domain: domain)
        player?.setEmbedCode(contentID)
        internalPalyer = OOOoyalaPlayerViewController(player: player)
        addChildViewController(internalPalyer)
        view.addSubview(internalPalyer.view)
        internalPalyer.view.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = internalPalyer.view.topAnchor.constraint(equalTo: view.topAnchor)
        let leadingConstraint = internalPalyer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let widhtConstraint = internalPalyer.view.widthAnchor.constraint(equalTo: view.widthAnchor)
        let heightConstraint = internalPalyer.view.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, widhtConstraint, heightConstraint])
        internalPalyer.didMove(toParentViewController: self)
        internalPalyer.setFullscreen(false)
        internalPalyer.showControls()
        
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        view.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 30).isActive = true
        view.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 30).isActive = true
        webView.topAnchor.constraint(equalTo: internalPalyer.view.bottomAnchor, constant: 30).isActive = true
        webView.navigationDelegate = self
        
        if let request = exchangeRequest {
            webView.load(request)
        } else if let request = request {
            webView.load(request)
        }
    }
    
    
    public func play() {
        internalPalyer.player.play()
    }
    
    public func puase() {
        internalPalyer.player.pause()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 9.0, *)
extension OyalaPlayerViewController : WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.url == exchangeRequest?.url, let req = self.request {
            webView.load(req)
        }
    }
}
