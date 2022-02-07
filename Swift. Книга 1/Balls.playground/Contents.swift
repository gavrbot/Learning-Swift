import PlaygroundSupport
import UIKit

public class Balls: UIView {
    // список цветов для шариков
    private var colors: [UIColor]
    // шарики
    private var balls: [UIView] = []
    // размер шариков
    private var ballSize: CGSize = CGSize(width: 40, height: 40)
    // аниматор графических объектов
    private var animator: UIDynamicAnimator?
    // обработчик перемещений объектов
    private var snapBehavior: UISnapBehavior?
    // обработчик столкновений
    private var collisionBehaviour: UICollisionBehavior
    
    // инициализатор
    public init(colors: [UIColor]) {
        self.colors = colors
        // создание значения свойства
        collisionBehaviour = UICollisionBehavior(items: [])
        // указание на то, что границы отображения также являются объектами взаимодействия
        collisionBehaviour.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        backgroundColor = UIColor.gray
        // подключаем аниматор с указанием на сам класс
        animator = UIDynamicAnimator(referenceView: self)
        // отрисовка шариков
        ballsView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // функция начала касания
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // так как экраны поддерживают multitouch, нам необходимо только первое касание
        if let touch = touches.first {
            // определяем зону касания
            let touchLocation = touch.location(in: self)
            for ball in balls {
                // если какой-либо из шариков входит в зону касания
                if (ball.frame.contains(touchLocation)) {
                    // то в snapBehaviour записываются данные об объекте и о координатах, куда данный объект будет перемещен
                    snapBehavior = UISnapBehavior(item: ball, snapTo: touchLocation)
                    // свойство damping определяет плавность и затухание при движении шарика
                    snapBehavior?.damping = 0.5
                    // указываем, что обрабатываемое классом поведение объекта должно быть анимировано
                    animator?.addBehavior(snapBehavior!)
                }
            }
        }
    }
    // функция перемещения объектов касанием
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            if let snapBehaviour = snapBehavior {
                snapBehaviour.snapPoint = touchLocation
            }
        }
    }
    // функция завершения касания шарика, очищающая используемые ресурсы после завершения касания
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let snapBehavior = snapBehavior {
            animator?.removeBehavior(snapBehavior)
        }
        snapBehavior = nil
    }
    // функция отображения шариков
    func ballsView() {
        /*
         производим перебор переданных цветов, они определяют количество шариков
         */
        for (index, color) in colors.enumerated() {
            // шарик - экземпляр UIView класса
            let ball = UIView(frame: CGRect.zero)
            // указываем цвет шарика
            ball.backgroundColor = color
            // накладываем отображение шарика на отображение подложки
            addSubview(ball)
            // добавляем шарик в массив шариков
            balls.append(ball)
            // вычисляем отступ каждого шарика(каждый ниже и правее предыдущего)
            let origin = 40 * index + 100
            // отображение шарика с помощью прямоугольника
            ball.frame = CGRect(x: origin, y: origin, width: Int(ballSize.width), height: Int(ballSize.height))
            // с закруглёнными углами
            ball.layer.cornerRadius = ball.bounds.width / 2.0
            // добавим шарик в обработчик столкновений
            collisionBehaviour.addItem(ball)
        }
    }
}



let balls = Balls(colors: [UIColor.white, UIColor.blue, UIColor.red])

PlaygroundPage.current.liveView = balls
