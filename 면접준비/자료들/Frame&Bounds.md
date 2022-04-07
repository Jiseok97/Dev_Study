# Frame & Bounds 🤷🏻‍♂️

## 정의 ▾
* **frame**
    * **SuperView(상위뷰)의 좌표 시스템**안에서 View의 위치와 크기를 나타낸다.
    * frame의 핵심 == **SuperView(상위뷰)**
    
* **bounds**
    * View의 위치와 크기를 **자신만의 자표시스템**안에서 나타낸다.
    
</br>

## Example 📑

### 예시 사진 ▾
> 아래 사진을 기준으로 적어보았다.
<img width="329" alt="frame" src="https://user-images.githubusercontent.com/64394744/153708589-a15da63c-928f-4090-939e-22bd5b1c01dc.png">
</br>


### frame
- **subView**의 origin을 기준으로 (70, 100)만큼 떨어진 곳에 **imageView**의 origin이 있게 되는 것이다.
- 그림은 **subView**는 **SuperView**로 부터 (16, 60)만큼 떨어져있다.
- **위 그림을 통해 하위뷰는 상위뷰의 origin(0,0)을 기준으로 좌표를 잡는다는 것을 알았다.**
</br>

### bounds
- **subView, imageView**의 origin은 (0,0)이다.
- bounds는 **자신만의 좌표시스템**이기 때문이다. 
