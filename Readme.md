# Тестовое задание iOS (NTPro)

## **Что необходимо было сделать**

---

- [x] Реализовать экран с таблицей сделок.

- [x] По умолчанию таблица должна быть отсортирована по дате изменения сделки.

- [x] Кроме того должна быть возможность сортировать таблицу по следующим полям: “имя инструмента”, “цена сделки”, “объем сделки” и “сторона сделки”.

- [x] Также необходимо уметь менять направление сортировки.


## **Требования по реализации**

---

- [x] Цена сделки и объем сделки (поля price и amount) приходят в Double, цену надо округлить до сотых, а объем до целых.
- [x] На экране должен быть интерфейс для того, чтобы сменить поле сортировки и направление сортировки.
- [x] В зависимости от стороны сделки необходимо подкрашивать цену либо в красный - для sell, либо в зеленый для buy.
- [x] При скроле списка он не должен тормозить.
- [x] Проект должен быть выполнен в git-репозитории, на который необходимо предоставить ссылку.
- [x] Делать изменения в классе Server нельзя. Необходимо строить решение, подразумевая, что в любой момент времени может прилететь новая пачка со сделками.

## **Комментарии исполнителя**

---

1. Задание было выполнено с использованием SwiftUI, в связи с чем были переписаны предложенные варианты отображения таблицы. В них, в последствии, стоит поработать с шрифтами и размерами колонок.

2. Размеры шрифтов заданы в соответствии с предложенным примером

3. Для вывода большого объема строк была использована комбинация ScrollView + LazyVStack. LazyVStack отрисовывает только видимые строки + несколько строк выше и ниже. Остальные строки загружаются по мере прокрутки экрана

4. Предложенный вариант сервера присылает пачки по 100 строк с высокой периодичностью. Строки не отсортированные, в связи с чем приходится делать сортировку всех имеющихся строк каждый раз, при получении новых. По мнению исполнителя, это ошибка логики работы сервера + приложения, так как требует дополнительных расчётов. Если бы сервер присылал данные заведомо отсортированные хотя бы по 1 полю, логику их отображения и сортировки в приложении можно было бы изменить в лучшую сторону

5. В связи с пунктом №4 при загрузке данных приложение ведет себя не отзывчиво

6. Держать в памяти приложения 1м строк не рационально, так как либо нужно хранить несколько копий отсортированных массивов или каждый раз при изменении сортировки тратить на это ресурсы. В связи с этим при изменении метода сортировки присутствует "затуп" приложения и результат выводится не мгновенно (что бы максимально сохранить отзывчивость приложения)

7. Сортировка массива строк реализована в отдельном потоке, что бы сохранить отзывчивость пользовательского интерфейса, работающего на главном потоке

> При скроле списка он не должен тормозить.

8. "Тормоза" наблюдаются только в момент сортировки. Отсортированный массив не "тормозит" 

9. Настройка сортировки таблицы реализована путем нажатия на заголовки столбцов, для выбора поля сортировки. При повторном нажатии на столбец происходит смена направления сортировки

10. Так как шапка таблицы не имеет поля "дата", по которому так же была необходима сортировка, в нижней части экрана реализован дополнительный модуль настройки сортировки

> В зависимости от стороны сделки необходимо подкрашивать цену либо в красный - для sell, либо в зеленый для buy.

11. В примере были окрашены поля "Sell" и "Buy". В реализации выполнено согласно примеру

## **Update #1**

Обнаружена ошибка, приводящая к потере данных.

В связи с тем, что добавление и сортировка строк проходила асинхронно, происходила потеря строк таблицы. Для исправления был добавлен массив "model_show" отвечающий за отображение контента на экране, а в массив "model" теперь сохраняются все поступающие строки.

Для обновления таблицы на экране была добавлена функции "UpdateTable" которая, 1 раз в 10 секунд добавляет новый контент на экран. Благодаря сокращению частоты обновления интерфейса увеличивается его отзывчивость.