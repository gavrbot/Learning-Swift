//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        // создаем кривые на сцене
        createBezier(on: view)
    }
    
    private func createBezier(on view: UIView) {
        // 1. создаем графический контекст(слой), на нем в дальнейшем будут рисоваться кривые. CAShapeLayer позволяет работать с фигурами как с множеством векторов
        let shapeLayer = CAShapeLayer()
        // добавляем слой в качествер дочернего к корневому слою корневого представления.
        view.layer.addSublayer(shapeLayer)
        
        // 2. изменение цвета линий
        shapeLayer.strokeColor = UIColor.gray.cgColor
        // изменение толщины линии в точках
        shapeLayer.lineWidth = 5
        // определение фонового цвета
        shapeLayer.fillColor = UIColor.green.cgColor
        
        // свойство lineCap используется для оформления крайних точек линий
        // shapeLayer.lineCap = .round
        
        // свойство lineDashPattern определяет шаблон для рисования прерывистой линии
        // shapeLayer.lineDashPattern = [5, 8, 12]
        
        // свойство strokeStart позволяет указать внутреннее смещение начала линии(strokeEnd - конца). 0 - начало фигуры, 1 - конец
        // shapeLayer.strokeStart = 0.3
        
        // свойство lineJoin определяет стиль оформления соединительных точек
        shapeLayer.lineJoin = .round
        
        // 3. создание фигуры. Метод getPath() возвращает путь, который описывает фигуру. Свойство path у shapeLayer имеет значение типа CGPath, поэтому передаём туда cgPath
        // путь 2-х треугольников
        // shapeLayer.path = getPath().cgPath
        // путь прямоугольника
        // shapeLayer.path = getRectanglePath().cgPath
        // путь для дуги
        // shapeLayer.path = getArcPath().cgPath
        // путь для овала
        // shapeLayer.path = getOvalPath().cgPath
        // путь до кривой
        // shapeLayer.path = getCurvePath().cgPath
        // путь до поварской шапки
        shapeLayer.path = getCustomPath().cgPath
    }
    
    private func getPath() -> UIBezierPath {
        // 1. создаём экземпляр класса UIBezierPath, который будет отписывать фигуру, а точнее её путь
        let path = UIBezierPath()
        // 2. указатель перемещается в точку с координатами(50, 50)
        path.move(to: CGPoint(x: 50, y: 50))
        // 3. рисуется линия, которая начинается в точке (50, 50) и заканчивается в точке (150, 50)
        path.addLine(to: CGPoint(x: 150, y: 50))
        
        // создание второй линии
        path.addLine(to: CGPoint(x: 150, y: 150))
        
        // метод close() завершает фигуру, в результате чего фигура замыкается, а также помогает замыкать фигуру, состоящую из 2-х линий
        path.close()
        
        // создание второго треугольника
        path.move(to: CGPoint(x: 50, y: 70))
        path.addLine(to: CGPoint(x: 150, y: 170))
        path.addLine(to: CGPoint(x: 50, y: 170))
        path.close()
        
        return path
    }
    
    private func getRectanglePath() -> UIBezierPath {
        // создание сущности "прямоугольник"
        let rect = CGRect(x: 10, y: 10, width: 200, height: 100)
        // создание прямоугольника
        // let path = UIBezierPath(rect: rect)
        // let path = UIBezierPath(roundedRect: rect, cornerRadius: 30)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomRight, .topLeft], cornerRadii: CGSize(width: 30, height: 0))
        return path
    }
    
    private func getArcPath() -> UIBezierPath {
        let centerPoint = CGPoint(x: 200, y: 200)
        let path = UIBezierPath(arcCenter: centerPoint, radius: 150, startAngle: .pi/5, endAngle: .pi, clockwise: true)
        return path
    }
    
    private func getOvalPath() -> UIBezierPath {
        let rect = CGRect(x: 50, y: 50, width: 200, height: 100)
        let path = UIBezierPath(ovalIn: rect)
        return path
    }
    
    private func getCurvePath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 10))
        path.addCurve(to: CGPoint(x: 200, y: 200), controlPoint1: CGPoint(x: 200, y: 20), controlPoint2: CGPoint(x: 20, y: 200))
        return path
    }
    
    private func getCustomPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 50, startAngle: .pi, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: 220, y: 100))
        path.addArc(withCenter: CGPoint(x: 220, y: 150), radius: 50, startAngle: .pi*3/2, endAngle: .pi/2, clockwise: true)
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 260))
        path.addLine(to: CGPoint(x: 100, y: 260))
        path.addLine(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 80, y: 200))
        path.addArc(withCenter: CGPoint(x: 80, y: 150), radius: 50, startAngle: .pi/2, endAngle: .pi*3/2, clockwise: true)
        path.close()
        return path
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
