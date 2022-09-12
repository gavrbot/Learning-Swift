/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import Photos
import PhotosUI

class PhotoViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!

  @IBOutlet weak var toolbar: UIToolbar!

  @IBOutlet weak var favoriteButton: UIBarButtonItem!
  @IBAction func favoriteTapped(_ sender: Any) { toggleFavorite() }

  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBAction func saveTapped(_ sender: Any) { saveImage() }

  @IBOutlet weak var undoButton: UIBarButtonItem!
  @IBAction func undoTapped(_ sender: Any) { undo() }

  @IBAction func applyFilterTapped(_ sender: Any) { applyFilter() }

  var asset: PHAsset
  // PHContentEditingOutput - контейнер, который хранит изменения ассета
  private var editingOutput: PHContentEditingOutput?

  required init?(coder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }

  init?(asset: PHAsset, coder: NSCoder) {
    self.asset = asset
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    getPhoto()
    updateFavoriteButton()
    updateUndoButton()
    saveButton.isEnabled = false
    // регистрируем себя в качестве наблюдателя PHPhotoLibraryChangeObserver
    PHPhotoLibrary.shared().register(self)
  }
  
  deinit {
    // после окончания работы класса убираем себя из наблюдателей
    PHPhotoLibrary.shared().unregisterChangeObserver(self)
  }

  func updateFavoriteButton() {
    if asset.isFavorite {
      favoriteButton.image = UIImage(systemName: "heart.fill")
    } else {
      favoriteButton.image = UIImage(systemName: "heart")
    }
  }

  func updateUndoButton() {
    // каждое изменение ассета создаёт экземпляр PHAssetResource. Функция assetResources возвращает массив ресурсов для данного ассета, который мы отфильтровали на предмет наличия данных для корректировки и включили/выключили кнопку в зависимости от наличия/отсутствия изменений
    let adjustmentResources = PHAssetResource.assetResources(for: asset).filter { $0.type == .adjustmentData }
    undoButton.isEnabled = !adjustmentResources.isEmpty
  }

  func toggleFavorite() {
    // создаем обработчик изменений, в котором свойство isFavorite меняем на противоположное
    let changeHandler: () -> Void = {
      let request = PHAssetChangeRequest(for: self.asset)
      request.isFavorite = !self.asset.isFavorite
    }
    // передаём наш обработчик в выбранную библиотеку
    PHPhotoLibrary.shared().performChanges(changeHandler, completionHandler: nil)
  }

  // функция применения изменений
  func applyFilter() {
    // изменения происходят с помощью контейнеров PHContentEditingOutput, которые дают доступ к изображению, обработка происходит в completion handler'e
    asset.requestContentEditingInput(with: nil) { [weak self] input, _ in
      guard let self = self else {
        return
      }
      // нам нужны bundleId, input контейнер и filterData
      guard let bundleId = Bundle.main.bundleIdentifier else {
        fatalError("Error: unable to get bundle identifier")
      }
      
      guard let input = input else {
        fatalError("Error: cannot get editing input")
      }
      
      guard let filterData = Filter.noir.data else {
        fatalError("Error: cannot get filter data")
      }
      // adjustmentData(данные о корректировке) - способ описания изменений ассета. Для его создания нам необходим уникальный id, для этого подойдёт bundleId.
      let adjustmentData = PHAdjustmentData(formatIdentifier: bundleId, formatVersion: "1.0", data: filterData)
      // нам также необходим editingOutput - контейнер, в котором будет храниться результат изменённого изображения
      self.editingOutput = PHContentEditingOutput(contentEditingInput: input)
      guard let editingOutput = self.editingOutput else {
        return
      }
      editingOutput.adjustmentData = adjustmentData
      // применяем фильтр к картинке, описан в UIImage+Extensions файле
      let filteredImage = self.imageView.image?.applyFilter(.noir)
      self.imageView.image = filteredImage
      // создаём jpegData для изображения и записываем его в итоговый контейнер
      let jpegData = filteredImage?.jpegData(compressionQuality: 1.0)
      do {
        try jpegData?.write(to: editingOutput.renderedContentURL)
      } catch {
        print(error.localizedDescription)
      }
      
      // после этого включаем кнопку сохранения
      DispatchQueue.main.async {
        self.saveButton.isEnabled = true
      }
    }

  }

  // функция для сохранения изменений в библиотеку с помощью PHAssetChangeRequest
  func saveImage() {
    // создали changeRequest и добавили туда контейнер для результата
    let changeRequest: () -> Void = { [weak self] in
      guard let self = self else {
        return
      }
      let changeRequest = PHAssetChangeRequest(for: self.asset)
      changeRequest.contentEditingOutput = self.editingOutput
    }
    // создаём completionHandler для исполнения действий после завершения изменений
    let completionHandler: (Bool, Error?) -> Void = { [weak self] success, error in
      guard let self = self else {
        print("Error: cannot edit asset: \(String(describing: error))")
        return
      }
      // если изменения успешны, то editingOutput записываем в nil,так как он больше не нужен
      self.editingOutput = nil
      DispatchQueue.main.async {
        self.saveButton.isEnabled = false
      }
    }
    // вызываем метод performChanges с нашим запросом и обработчиком
    PHPhotoLibrary.shared().performChanges(changeRequest, completionHandler: completionHandler)
  }

  func undo() {
    // в changeRequest содержится логика изменения картинки
    let changeRequest: () -> Void = { [weak self] in
      guard let self = self else { return }
      let request = PHAssetChangeRequest(for: self.asset)
      request.revertAssetContentToOriginal()
    }
    // completionHandler проверяет на успешный результат и выключает кнопку undo , если результат успешен
    let completionHandler: (Bool, Error?) -> Void = { [weak self] success, error in
      guard let self = self else { return }
      
      guard success else {
        print("Error: can't revert the asset: \(String(describing: error))")
        return
      }
      DispatchQueue.main.async {
        self.undoButton.isEnabled = false
      }
    }
    // выполняем изменения с помощью метода performChanges
    PHPhotoLibrary.shared().performChanges(changeRequest, completionHandler: completionHandler)
  }

  func getPhoto() {
    imageView.fetchImageAsset(asset, targetSize: view.bounds.size, completionHandler: nil)
  }
}

// PhotoKit кэширует запросы на получение для лучшей производительности, при нажатии на кнопку сердечка ассет обновляется в библиотеке, но копия ассета во View Controller не актуальна. Контроллеру нужно следить за обновлениями библиотеки и обновлять свои данные по необходимости. Для этого мы подпишем наш класс на протокол PHPhotoLibraryChangeObserver
extension PhotoViewController: PHPhotoLibraryChangeObserver {
  // этот метод будет вызываться каждый раз при обновлении библиотеки
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    // надо проверить, затрагивает ли обновление наш ассет. changeInstance свойство описывает изменение в библиотеке, возвращает nil, если изменений не было. иначе получаем обновлённый ассет.
    guard let change = changeInstance.changeDetails(for: asset), let updatedAsset = change.objectAfterChanges else {
      return
    }
    // метод работает в бэкграунде, поэтому всю логику выполняем в главном потоке, так как обновляется UI
    DispatchQueue.main.sync {
      asset = updatedAsset
      imageView.fetchImageAsset(asset, targetSize: view.bounds.size) { [weak self] _ in
        guard let self = self else {
          return
        }
        // обновляем UI
        self.updateFavoriteButton()
        self.updateUndoButton()
      }
    }
    
  }
}
