import UIKit

class ViewController: UIViewController {
    
    // 画像インスタンス
    let ClockBackImage = UIImageView()
    let ClockTimehourImage = UIImageView()
    let pinImage = UIImageView()
    let MinuteTimehourImage = UIImageView()
    
    
    var HourView: UIView!
    var MinuteView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Screen Size の取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        ClockBackImage.image = UIImage(named: "body")
        ClockBackImage.frame = CGRect(x:0, y:0, width:300, height:300)
        ClockBackImage.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        self.view.addSubview(ClockBackImage)
        
        ClockTimehourImage.image = UIImage(named: "short")
        ClockTimehourImage.frame = CGRect(x:0, y:0, width:150, height:150)
        ClockTimehourImage.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        ClockTimehourImage.isUserInteractionEnabled = true
        self.view.addSubview(ClockTimehourImage)
        
        MinuteTimehourImage.image = UIImage(named: "long")
        MinuteTimehourImage.frame = CGRect(x:0, y:0, width:150, height:250)
        MinuteTimehourImage.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        MinuteTimehourImage.isUserInteractionEnabled = true
        self.view.addSubview(MinuteTimehourImage)
        
        pinImage.image = UIImage(named: "cover")
        pinImage.frame = CGRect(x:0, y:0, width:50, height:50)
        pinImage.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        self.view.addSubview(pinImage)
        
        
        HourView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 100))
        HourView.center = self.view.center
        HourView.backgroundColor = UIColor.clear;
        self.view.addSubview(HourView)
        HourView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        let HourViewBox = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 80))
        HourViewBox.backgroundColor = UIColor.clear
        HourView.addSubview(HourViewBox)
        
        
        MinuteView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 120))
        MinuteView.center = self.view.center
        MinuteView.backgroundColor = UIColor.clear;
        self.view.addSubview(MinuteView)
        MinuteView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        let MinuteBox = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 90))
        MinuteBox.backgroundColor = UIColor.clear
        MinuteView.addSubview(MinuteBox)
  
    }
    
    
    
    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        let touch = touches.first!
        if touch.view === HourView.subviews[0] {
            let position = touch.location(in: self.view)
            let target = HourView.center
            let angle = atan2f(Float(target.y-position.y), Float(target.x-position.x)) - Float(M_PI) / Float(2)
            HourView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            ClockTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
        
        if touch.view === MinuteView.subviews[0] {
            let position = touch.location(in: self.view)
            let target = MinuteView.center
            let angle = atan2f(Float(target.y-position.y), Float(target.x-position.x)) - Float(M_PI) / Float(2)
            MinuteView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            MinuteTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
