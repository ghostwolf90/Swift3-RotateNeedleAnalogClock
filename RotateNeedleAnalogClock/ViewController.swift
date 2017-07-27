import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labTime: UILabel!
    
    // 画像インスタンス
    let ClockBackImage = UIImageView()
    let ClockTimehourImage = UIImageView()
    let pinImage = UIImageView()
    let MinuteTimehourImage = UIImageView()
    
    // 目前時間
    var curHour: Int = 0
    var curMinutes: Int = 0
    var oldMinutes: Int = 0
    
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
        update()
    }

    
    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        let touch = touches.first!
        if touch.view === HourView.subviews[0] {
            let position = touch.location(in: self.view)
            let target = HourView.center
            let angle = atan2f(Float(target.y-position.y), Float(target.x-position.x)) - Float(Double.pi) / Float(2)

            let h: Float = (angle / 6.28319) * 12.0
            var h2: Float = h
            if h < 0 { curHour = Int( h - 1 ) + 12; h2 = h + 11.9905 }
            else { curHour = Int( h + 0.0005) }
            
            print("angle=\(angle) hour=\(curHour) minute=\(curMinutes) h=\(h) h2=\(h2) \(h2 - Float(curHour)) ")

            HourView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            ClockTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            
            let m: Float = h2 - Float(curHour)
            curMinutes = Int( m * 60 )
            
            let mDeg = curMinutes * (360 / 60);
            
            MinuteView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * Double(mDeg) / 180.0))
            MinuteTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * Double(mDeg) / 180.0))
            
            labTime.text = String(format: "目前時間: %02d:%02d", curHour, curMinutes)
            
        }
        
        if touch.view === MinuteView.subviews[0] {
            let position = touch.location(in: self.view)
            let target = MinuteView.center
            let x: Float = Float(target.x-position.x)
            let y: Float = Float(target.y-position.y)
            
            let angle = atan2f(y, x) - Float(Double.pi) / Float(2)
            // angle range: 1.5708 ~ -4.71239
        
            let m: Float = (angle / 6.28319) * 60.0
            if m < 0 { curMinutes = Int( m - 1 ) + 60 }
            else { curMinutes = Int( m ) }
            print("hour=\(curHour) minute=\(curMinutes) oldMinutes=\(oldMinutes) m=\(m)")
            
            if oldMinutes > 50 && curMinutes < 10 {
                curHour += 1
                oldMinutes = curMinutes
            } else if oldMinutes < 10 && curMinutes > 50 {
                curHour -= 1
                oldMinutes = curMinutes
            } else {
                oldMinutes = curMinutes
            }
            
            labTime.text = String(format: "目前時間: %02d:%02d", curHour, curMinutes)
            
            MinuteView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            MinuteTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))

            var mm = curHour * 60 + curMinutes
            if mm > 195 { mm -= 720 }
            let hourAngle = Float(mm) / 720.0 * 6.28319
            print("hourAngle=\(hourAngle)")
            
            HourView.transform = CGAffineTransform(rotationAngle: CGFloat(hourAngle))
            ClockTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(hourAngle))
            
            
        }
    }
    
    func update() {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        curHour = hour
        curMinutes = minutes
        oldMinutes = minutes
        let hDeg = (hour % 12) * (360 / 12);
        let mDeg = minutes * (360 / 60);
        let sDeg = seconds * (360 / 60)
        print(hDeg)
        print(mDeg)
        print(sDeg)
        
        //secondsImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * Double(sDeg) / 180.0))
        
        MinuteView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * Double(mDeg) / 180.0))
        MinuteTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * Double(mDeg) / 180.0))
        
        HourView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * Double(hDeg) / 180.0))
        ClockTimehourImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * Double(hDeg) / 180.0))
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
