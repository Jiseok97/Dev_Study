# MVVM 패턴

> **Model** & **View** & **View Model** & **Controller** 로 구성되어있다.
<img width="800" alt="MVVM패턴" src="https://user-images.githubusercontent.com/64394744/135600828-e68d1391-e827-4caa-ab69-d5803e8184f4.png">

<img width="800" alt="MVVM 패턴" src="https://user-images.githubusercontent.com/64394744/135607402-01158195-b748-4604-8587-cfca71f3a772.png">


## ‣ About MVVM ❔
* Why use ?
    * 기존 MVC패턴은 다양한 로직을 Controller에서 처리하다보니 Controller가 비대해지는 문제점이 있다.
    
- **View**에 업데이트할 데이터를 **View Model**에서 처리함으로써 Controller가 복잡해지는 것을 줄여준다.
- **View**에 어떤 **View Model**을 연결하느냐에 따라 로직처리가 달라진다.
- **Model**이 변경되면 관련된 **View Model**을 사용하는 **View**가 자동으로 업데이트 되는 방식이다.
    
* MVVM → **Model** + **View** + **View Model**
    * **Model**
        * 데이터 캡슐화
        * **View Model**이 소유하고 있다.
        * 데이터 모델, 데이터 접근 레이어, 비즈니스 로직등이 포함되어 있다.
        * 데이터에 대한 작업을 마치면 **View Model**에게 결과를 알린다.
        
    * **View**
        * 시각적 요소, 컨트롤 표시 etc... (UI 반영하는 코드 & 생명주기 관리 코드)
        * 사용자 이벤트를 수신하고 데이터를 표시하는 유저 인터페이스를 책임진다.
        * View Controller 또한 View의 일부라고 한다.
        * 이벤트들은 **View Model**에 전달되어 처리해야할 책임이 있고, **View**는 **View Model**의 변경사항을 감지하고 **View Model**이 업데이트한 데이터를 보여준다.
        * **View**와 **Model**사이에는 연결이 없다.
        * **View Model**에 의해 연결된다.
        * 가장 이상적인 형태 → 일부 유저 인터페이스를 제외하면 오로지 메소드를 호출하는 생성자만 존재하는 것
        
    * **View Model**
        * Model 데이터를 View에 맞게 가공 및 처리 (뷰에 반영될 데이터 비즈니스 로직 담당)
        * 로직을 담당한다
        * 유저가 **View**에서 어떤 액션을 취할 때 **Model**을 변경했을 때 해당 **Model**을 업데이트하고 **View Model**에게 결과를 알리고 **View**를 갱신하는 역할을 한다.
        * **View**와 **1:N**관계를 이룬다.
        * **Presentation Logic**을 처리하는 역할을 한다.
        
        
</br>

## ‣ Example 

- Model 예제 코드 ▾
```swift
import Foundation

// MARK: - Model
class Dog {
    
    // 개 품종
    enum Breed {
        case maltese
        case pomeranian
        case pug
        case poodle
    }
    
    let name: String
    let birthday: Date
    let breed: Breed
    let imageName: String
    
    init(name: String = "pomeranian", birthday: Date = Date(timeIntervalSinceNow: (-2 * 86500 * 380)), 
        breed: Breed = .pomeranian, imageName: String = "pomeranian.jpeg") {
        self.name = name
        self.birthday = birthday
        self.breed = breed
        self.imageName = imageName
    }
}
```

- View Model에선 Model을 통해 받아온 데이터 중 바로 사용하기 힘든 데이터들을 가공해준다.
 - 예제 코드 같은 경우는 품종에 따라 다른 가격을 반환하므로, 그 부분을 가공해준다.
 </br>
 
 - View Model 예제 코드 ▾

```swift
import Foundation

// MARK: - ViewModel
class DogViewModel {
    let dog: Dog
    let calendar: Calendar
    
    init(){
        self.dog = Dog()
        self.calendar = Calendar(identifier: .gregorian)
    }
    
    var name: String {
        return dog.name
    }
    
    var imageName: String {
        return dog.imageName
    }
    
    var ageText: String {
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: dog.birthday)
        let components = calendar.dateComponents([.year], from: birthday, to: today)
        let age = components.year == nil ? 0 : components.year!
        return "\(age) years old"
    }
    
    var adoptionFeeText: String {
        switch dog.breed {
            case .maltese:
                return "₩200000"
            case .pomeranian:
                return "₩500000"
            case .poodle:
                return "₩600000"
            case .pug:
                return "₩400000"
        }
    }
}

extension DogViewModel {
    func configure(_ view: DogView) {
        view.nameLabel.text = name
        view.imageName = imageName
        view.ageLabel.text = ageText
        view.adoptionFeeLabel.text = adoptionFeeText
    }
}
```

- Model 객체를 만들어주고, View의 표시될 데이터를 알맞는 포맷으로 가공해준다.
* example
    * Model → birthday
        * 현재 Date()를 구하여 dateComponents()를 통해 현재 **몇 살**인지를 **String형식**으로 가공해준다.
    * Model → bread 
        * 품종에 맞는 **가격**을 **String형식**으로 가공해준다.
</br>

> View 예제 코드는 해당 UI들을 적어둔것이라 따로 스킵했다.
</br>

- View Controller 예제 코드 ▾
```swift
extension DogViewModel {
    func configure(_ view: DogView) {
        view.nameLbl.text = name
        view.imageName = imageName
        view.ageLbl.text = ageText
        view.adoptionFeeLbl.text = adoptionFeeText
    }
}
```
- 이런식으로 View Controller는 View Model의 있는 데이터를 가져와 View의 값을 전달해준다.
</br>

### ‣ MVVM 장/단점
* 장점
    * 테스트 용이성
        * **View Model**에는 UIKit 관련된 코드가 없으므로 UI에 독립적인 테스트 가능
    * Controller 부담을 경감
    
* 단점
    * 바인딩을 도와주는 라이브러리를 함께 사용하지 않으면, 많은 기반 코드를 작성해야 함
    * **View Model**을 설계하는 것이 쉽지 않다.
    * **View**에 대한 처리가 복잡해질수록 **View Model**이 거대해져 **오버스펙**이 될 수 있다.

