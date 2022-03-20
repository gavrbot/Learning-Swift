//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    // перед вызовом метода loadView() корневое представление self.view = nil, поэтому мы либо вызываем super.loadView() или создаём экземпляр класса UIView и передаём его в self.view
    override func loadView() {
        setupViews()
    }
    
    // настойка представлений сцены
    private func setupViews() {
        self.view = getRootView()
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        
        set(view: greenView, toCenterOfView: redView)
        // позиционируем белое представленеи с помощью свойства center, то есть при вызове этого метода whiteView рисуется в центра родительского представления greenView, то есть в redView.
        whiteView.center = greenView.center
        
        self.view.addSubview( redView )
        redView.addSubview( greenView )
        redView.addSubview( whiteView )
        
    }
    
    // создание корневого представления
    private func getRootView() -> UIView{
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    // создание красного представления
    private func getRedView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .red
        view.addSubview( getGreenView() )
        // свойство clipsToBounds позволяет определять границы отрисовки для subView. Если значение true, то отрисовка subView не выходит на пределы parentView
        view.clipsToBounds = true
        return view
    }
    
    // создание зелёного представления
    private func getGreenView() -> UIView {
        let viewFrame = CGRect(x: 10, y: 10, width: 180, height: 180)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .green
        return view
    }
    
    private func getWhiteView() -> UIView {
        let viewFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .white
        return view
    }
    
    private func set(view moveView: UIView, toCenterOfView baseView: UIView) {
        // размеры вложенного представления
        let moveViewWidth = moveView.frame.width
        let moveViewHeight = moveView.frame.height
        
        // размеры родительского представления
        let baseViewWidth = baseView.frame.width
        let baseViewHeight = baseView.frame.height
        
        // вычисление и изменение координат
        let newXCoordinate = (baseViewWidth - moveViewWidth) / 2
        let newYCoordinate = (baseViewHeight - moveViewHeight) / 2
        moveView.frame.origin = CGPoint(x: newXCoordinate, y: newYCoordinate)
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
