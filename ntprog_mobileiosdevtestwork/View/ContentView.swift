//
//  ContentView.swift
//  ntprog_mobileiosdevtestwork
//
//  Created by Kirill Burchenko on 19.01.2023.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
//    Переменная доступа к абстрактному серверу
    private let server = Server()
//    Переменная, в которой хранится массив наших строк
    @State private var model: [Deal] = []
    @State private var model_show: [SortDirection: [SortField: [Deal]]] = [:]
//    Переменная настроки боковых отступов таблицы
    private let pad: CGFloat = 20
//    Переменная доступа к сортировщику наших строк
    @State private var sorter: Sorter = Sorter()
//    Создание последовательно очереди для выполнения фоновых задач
    let myQueue = DispatchQueue(label: "serial")

    @State var first: Bool = true

    
    var body: some View {
        let show = model_show[sorter.direction] ?? [:]
            VStack(spacing: 0) {
//                Выводим на экран шапку таблицы
                HeaderCell(sorter: $sorter)
                    .padding(.horizontal, pad)
                Divider()
                    .padding(.horizontal, pad)
//                Создаем область для прокрутки строк
                ScrollView{
//                    Создаем "ленивый" стак, так как предполагается наличие порядка 1м строк.
//                    "Ленивый" стак отризовывает только видимые строки + несколько строк за приделами зоны видимости
                    LazyVStack(spacing: 0) {
//                        Выводим каждую строку на экран
                        ForEach(show[sorter.field] ?? [], id: \.id) { model in
                            DealCell(deal: model)
                                .padding(.vertical, 10)
                            Divider()
                        }
                    }
                    .padding(.horizontal, pad)
                }
                Divider()
//                Счетчик количества строк, для отладки
                Text("\(show[.date]?.count ?? 0)")
                
//                Выводим на экран доп элемент для настройки сортировки, так как в шапке отсутствует возможность сортировки по дате
                SortView(sorter: $sorter)
                    .padding()
        }
        .onAppear{
//            Подписываемся на получение новых сделок, после загрузки текущего экрана
            server.subscribeToDeals { deals in
//                Сохраняем все входящие данные
                self.model.append(contentsOf: deals)
//                print(model.count)
//                Запускаем обновление таблицы
                if (first){
                    UpdateTable()
                }
            }
        }
//        При изменении поля сортировки, обрабатываем событие
//        .onChange(of: sorter.field){ _ in
//            myQueue.async {
////                Если изменилось поле сортировки, нужно повторно отсортировать массив
//                self.model_show = sorter.Resort(model: model)
//            }
//        }
////        При изменении порядка сортировки, обрабатываем событие
//        .onChange(of: sorter.direction){ _ in
//            myQueue.async {
////                Если изменилось направление сортировки, достаточно развернуть массив массив
//                self.model_show = sorter.Reorder(model: model)
//            }
//        }
    }
    
//    Обновление таблицы
    func UpdateTable(){
//        Если это первое обновление, деалем его без задежржки, что бы показать пользователю
        if (first){
            first = false
            self.model_show = sorter.Resort(model: model)
//            Рекурсивно вызываем следующее обновление
            UpdateTable()
        }
        else{
//            Обновление таблицы 1 раз в 10 секунд (для отзывчивости интерфейса)
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 10){
//                Если массивы одинаковой длинны, таблица обновлена
                if (self.model_show.count != self.model.count){
                    self.model_show = sorter.Resort(model: model)
                    print("Updated")
                }
//                Вызываем рекурсивное обновление
                UpdateTable()
            }
        }
    }
}

//Предпросмотр
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
