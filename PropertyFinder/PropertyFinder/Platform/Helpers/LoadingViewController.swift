import UIKit

class LoadingViewController: UIViewController {

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
    didSet {
      activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
  }
  @IBOutlet weak var messageLabel: UILabel! {
    didSet {
     
    }
  }
  @IBOutlet weak var containerView: UIView! {
    didSet {
      containerView.layer.cornerRadius = 15
    }
  }
  
  //MARK: - LoadXIB
  override func loadView() {
    Bundle.main.loadNibNamed("LoadingViewController", owner: self, options: nil)
  }
  
  //MARK: - ViewLifecycle
  override func viewDidLoad() {
      super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  func showLoadingView(_ withMessage: String, inViewController: UIViewController) {
    self.loadView()
    messageLabel.text = withMessage
    
      //try to show the loading view in the parent, otherwise, on ipad the loader is shown only on the right side.
      
      if let nav = inViewController.navigationController {
        if let navParent = nav.parent {
          self.view.frame = navParent.view.frame
          navParent.view.addSubview(self.view)
        }
        else{
          self.view.frame = nav.view.frame
          nav.view.addSubview(self.view)
        }
        self.view.alpha = 0
        self.view.fadeIn(duration: 0.25)
      }
    }
  
  
  func hideLoadingView() {
      self.view.fadeOut(duration: 0.25)
      let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
      DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
        self.view.removeFromSuperview()
      })
  }
}

public extension UIView {
  func fadeIn(duration: TimeInterval = 1.5) {
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 1.0
    })
  }
  
  func fadeOut(duration: TimeInterval = 1.5) {
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 0.0
    })
  }
}
