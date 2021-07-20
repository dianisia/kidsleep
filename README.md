# Kidsleep

MVP приложения Kid'sleep. Kid'sleep -- это приложение, которое поможет составить график сна и уложить ребенка спать с помощью подборки успокаивающих звуков.
Также данное приложение может выступать трекером для основных детских активностей (сон, еда, сон, еда). 

Приложение проектировалось с учетом требований Clean Architecture и архитектуры MVVM. 

# Использованные технологии
- RxSwift
- RxCocoa
- Alamofire
- SDWebImage
- PanModal
- RxMusicPlayer
- хранение данные в UserDefaults
- UIKit
- верстка кодом

Design: [![Kidsleep]](https://www.figma.com/file/qWAZ390nhHSGaZpksfkf6y/Kid-sleep?node-id=82%3A2738)

В некоторых местах есть неконсистентность в подходе к верстке UI. Это возникло из-за желания попробовать разные способы. В ходе дальнейшей разработки данного MVP буду избавляться от этой неконсистентности.

# Основные функции
- онбоардинг пользователя, получение основных данных о ребенке и режиме дня
- отображение событий из режима дня
- push-оповещения о предстоящих событиях, если пользователь указал, что хочет получать уведомления (локальные пуши)
- демонстрация "сторис" с полезной информацией, которая запрашивается с сервера (пока данные храняться в restdb.io)
- проигрывание мелодий
- эмуляция ночника

# Onboarding пользователя

<p float="left">
  <img src="/gifs/onboarding-part1-gif.gif" width="30%" height="30%"/>
  <img src="/gifs/onboarding-part2-gif.gif" width="30%" height="30%"/>
</p>

# Демонстрация работы приложения

<p float="left">
  <img src="/gifs/using-part1-gif.gif" width="30%" height="30%"/>
  <img src="/gifs/using-part2-gif.gif" width="30%" height="30%"/>
</p>
