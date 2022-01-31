
# Prography 7th IOS Quest

> 프로그라피 IOS 전형의 비중은 면접(70%), 과제(30%) 입니다. 과제의 완성도보다 면접이 더 중요합니다.

## 1. 개요

프로그라피는 짧은 기간동안 멋진 서비스를 뚝딱 만들어내기 때문에 클라이언트 개발 능력이 굉장히 중요합니다. 프로그라피 활동 진행 중 팀원들과 **원활한 협업 및 프로젝트를 진행하기 위함**과 운영진이 **지원자에 따른 적합한 방향성 파악**을 위함입니다. 사전 과제를 완벽히 완료하여야만 합격이 가능한 것이 아니므로 할 수 있는 만큼 보여주시면 됩니다. :)

더 궁금한 것이 있으시면 [해당 프로젝트 이슈](https://github.com/prography/prography-7th-ios-quest/issues/new)로 남겨주세요! 늦어도 당일 이내에 답변을 남기도록 하겠습니다.

## 2. 과제

아래 설명을 읽고, 앱을 구현해주시기 바랍니다.

**해당 Repository를 fork하여 진행합니다.**

### a. 주제

제공되는 API를 활용하여 영화 목록을 받아와 보여주는 영화정보 제공 App을 만들어주세요. 예시와 구성화면이 완벽히 일치하지 않아도 됩니다.(UIKit, SwiftUI 사용 가능)

API 정보
- 영화 정보 API 사용방법: [https://yts.lt/api#list_movies](https://yts.lt/api#list_movies)
- 영화 정보 API base URL: [https://yts.lt/api/v2/list_movies.json](https://yts.lt/api/v2/list_movies.json)

Response Model: 다음을 사용하여 구현할 수 있도록 모델 제공
```swift
import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let status: String?
    let statusMessage: String?
    let data: DataClass?

}

// MARK: - DataClass
struct DataClass: Codable {
    let movieCount: Int?
    let limit: Int?
    let movies: [Movie]?
    
}

// MARK: - Movie
struct Movie: Codable {
    let title: String?
    let rating: Double?
}

```
### b. 필수 과제

- **[Main]**
  - [ ] 평점을 입력받아 10개의 MovieList를 갖는 API를 호출 \
  (parameter: minimum_rating, limit 사용)
  - [ ] API 중복 호출 방지
- **[MovieList]**
  - [ ] 제목과 평점을 다음과 같이 표현
  - [ ] 항목 선택시, Movie Detail로 이동
- **[MovieDetail]**
  - [ ] 제목과 평점을 표시

<div>
  <img src="https://lh5.googleusercontent.com/QZ4urExNed_abXoppB1ogWssilrXf-5DTnO6Pu4LNVek26kC5x6KHBzOr1zLFLsopn7IgVM2Tnsi4vfzuvCbV3XvV0CxvlHBcAuEkF6SsMetLj0KmBsJ4G8I3pvM_NZQjAAcmjXZ" width="200" />
  <img src="https://lh4.googleusercontent.com/jPLn4d6vBkoqksaTVqj-JmWg2QmGco6D36zwzjdKB-j4SO4WMW4dplPkN84xOfO9tieVIxum12h4lqUWKjjjODz4YUY5K0RNtXOoWvZWF8Dn4_QWgO3tsgvzaV6qhpvMfUt9-kXF" width="200" />
  <img src="https://lh5.googleusercontent.com/PIwckhduVdUOL1lMnEFnC3tzl_GoXYetpvr5dSO_yFt-7f61SDnoVZTqhqvTAp8Uk2cPSLULmxYknTtyBe0Q7CHnwfOdToZMNmg5HYyNEXKwBKLtuuWFswb_4Xsom6tNlCKGZXn9" width="200" />
</div>

### b. 선택 과제

- **[Main]**
  - [ ] API Loading시 Indicator 사용
  - [ ] 평점 입력시, PickerView를 사용
  - [ ] button 테두리를 둥글게 표시 및 그림자 효과 적용
- **[MovieList]**
  - [ ] cell이 없는 구간은 경계선 제거
  - [ ] 평점 순으로 정렬
  - [ ] 우측상단에 Next버튼을 만들고, 버튼 클릭시, 다음 10개가 아래 표시
- **[MovieDetail]**
  - [ ] 영화 이미지 표시
- **[기타]**
  - [ ] 추가적으로 어필하고 싶은 기술 사용 가능
  - [ ] RxSwift, Combine SwiftUI 등의 사용도 자유롭습니다.(SwiftUI 선호합니다.)
  - [ ] CocoaPods, carthage, SPM 등의 라이브러리는 자유롭게 사용하셔도 됩니다만, 협업은 CocoaPods을 사용할 예정입니다.
  - [ ] 아키텍쳐는 MVVM 또는 MVC로 구현해주세요


## 3. 제출방법

이 레포지토리를 fork 하여 본인의 깃헙에서 진행해주시면 됩니다. 마감일 기준 23:59:59 까지 기록된 커밋만 인정합니다.


