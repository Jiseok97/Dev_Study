# MVC 패턴

> **Model** & **View** & **Controller** 로 구성되어있다.
<img width="817" alt="MVC패턴" src="https://user-images.githubusercontent.com/64394744/135588646-26c855c3-4795-49fb-ad51-44affe96c98a.png">


## ‣ About MVC ❔
* Why use ?
    * 디자인 패턴을 따르는 이유는 **유지보수를 쉽게** 하기 위함이다.
    
* MVC → Model + View + Controller 의 줄임말
    * Model → 데이터에 관한 로직 담당 ( 데이터 값 변경 및 관리)
    * View → 사용자에게 보여지는 화면 담당 (UI)
    * Controller → Model과 View연결 (Model 값을 View에 보여줌)
    
* Model과 View는 Controller만 접근할 수 있다.
* 가장 기초적인 패턴 & Apple이 권장한다고 한다.
>  ‼️ View와 Model은 **절대로** 서로에게 **접근**하면 안된다.
</br>

## ‣ View 이벤트 처리는??
- View의 변화는 **Delegate & Data Souce**를 사용하여 이벤트 처리를 한다.
* Delegate
    * 사용자의 입력 터치 등 이벤트 발생 시 Controller가 그 이벤트를 처리하기 때문에 View가 직접적으로 Controller에 접근할 필요가 없게 된다.
* Model → 값 변화
    * **Notification** || **KVO(Key-Value Observing)** 를 사용하여 Controller가 감지하여 처리할 수 있도록 해준다.
</br>

## ‣ What is the KVO ??
- 특정 키의 값의 변화를 감지하기 위한 기능
- Model 객체의 어떤 값이 변경되었을 경우 이를 UI에 반영하기 위해서 Controller는 Model 객체에 Observing을 도입하여 Delegate에 특정 메세지를 보내 처리할 수 있도록 하는 것
- 변수에 코드를 붙여 변수가 변경될 때마다 코드가 실행되도록 하는 방법을 의미한다.
* 순수 Swfit 코드로는 부적합하다.
    * **Objective-c 런타임**에 의존하고 있기 때문이다.

- NSObject를 상속받기 위해 **@objc**를 반드시 붙여줘야 한다.
- KVO는 속성 각각에 **@objc dynamic**을 붙여줘야한다.
</br>

### Example → KVO(Key-Value Observing)
```swift
class SomeClass: NSObject {
    @objc dynamic var value : String = ""
}

let someObject = SomeClass()

someObject.observe(\.value) { (object, change) in
    print("SomeClass의 Object값이 변경되었습니다. \(object.value)")
}

someObject.value = "Hello World"  // Hello World
```
- NSObject는 KVO지원을 위해서는 필수 !!
* dynamic
    * dynamic dispatch를 활성화 시키는 Operator
- 키패스(KeyPath = /.) 이름을 이용해 프로퍼티의 주소를 찾게 해 주도록 하라는 정도의 코드
* 핵심 → observe() 메소드
    * 클로져를 이용할 수 있게 추가된 메소드
    * 해당 오브젝트에서 키패스로 지정된 프로퍼티의 값이 바뀌게 되면 클로져가 호출된다.
    * 오버라이드 쓸 필요 X
    * Apple의 자체 API로 작업할 때 좋다고 한다.
</br>

## ‣ MVC 장/단 점
* 장점
    * 생산성이 높다. (역할을 분담하여 빠르게 구현)
    
* 단점
    * 많은 코드들이 Controller에 집중되어 Controller가 커지게 된다.
</br>
    
## ‣ MVC 예제 코드
 - View & Controller 코드 ▾
```swift
import UIKit 

// Controller
class ViewController: UIViewController {
    // View
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var eamilTF: UITextField!
    @IBOutlet waek var passwordTF: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.isHidden = ture
    }
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        
        guard let email = emailTF.text else { return }
        guard let pwd = passwordTF.text else { return }
        
        user = User(email: email, password: pwd)
        
        // email = test@gmail.com && paaword = 1234 로 가정
        if user.email == "test@gmail.com" && user.password == "1234" {
            message.text = "로그인 성공!!"
            message.isHidden = false
        }
    }
}
```
 
 - Model 코드 ▾
 ```swift
 // Model
 import Foundation
 
 struct User {
    var email: String
    var password: String
}
 ```


 * View ▾
    * **UILabel & UITextField** 등이 View에 해당이 된다.
        * UILabel → UIView 상속
        * UITextField → UIControl 상속 → UIView 상속

* Controller ▾
    * Controller은 View를 제외한 **나머지 코드**들

* Model ▾
    * User
        * **email & password** 두 개의 저장 프로퍼티가 존재한다.
        * 여기에 데이터에 관한 로직이 들어갈 수 있다.


### ⭐️ MVC 패턴의 **단점을 보완**하는 패턴 → **MVVM 패턴** 
