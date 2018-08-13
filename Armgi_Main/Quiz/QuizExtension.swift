import UIKit

extension UIView { //뒤로가기
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func PreButton(_ duration: TimeInterval = 0.5, completionDelegate: CAAnimationDelegate? = nil) {//시간차는 1.0초 끝나고 실행할 값은 없다. 닐~
        // Create a CATransition animation
        let PreButtonTransition = CATransition() //코어트랜지션에 속했다
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate {
            PreButtonTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        PreButtonTransition.type = kCATransitionPush  // 푸시는 우리가 원하는 밀려나는 효과
        PreButtonTransition.subtype = kCATransitionFromLeft // 시작방향지정: Left Right를 우린 이용하게 됨
        PreButtonTransition.duration = duration
        PreButtonTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        PreButtonTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(PreButtonTransition, forKey: "PreButtonTransition")
    }
    func NextButton(_ duration: TimeInterval = 0.5, completionDelegate: CAAnimationDelegate? = nil) {
        let NextButtonTransition = CATransition()
        
        if let delegate2: CAAnimationDelegate = completionDelegate {
            NextButtonTransition.delegate = delegate2
        }
        
        NextButtonTransition.type = kCATransitionPush
        NextButtonTransition.subtype = kCATransitionFromRight
        NextButtonTransition.duration = duration
        NextButtonTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        NextButtonTransition.fillMode = kCAFillModeRemoved
        
        self.layer.add(NextButtonTransition,forKey: "NextButtonTransition")
        
    }
}
