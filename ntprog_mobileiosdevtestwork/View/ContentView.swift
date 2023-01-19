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
//    Переменная настроки боковых отступов таблицы
    private let pad: CGFloat = 20
//    Переменная доступа к сортировщику наших строк
    @State private var sorter: Sorter = Sorter()
//    Создание последовательно очереди для выполнения фоновых задач
    let myQueue = DispatchQueue(label: "serial") // DispatchQueue is serial by default

    
    var body: some View {
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
                        ForEach(model, id: \.id) { model in
                            DealCell(deal: model)
                                .padding(.vertical, 10)
                            Divider()
                        }
                    }
                    .padding(.horizontal, pad)
                }
                Divider()
//                Счетчик количества строк, для отладки
//                Text("\(model.count)")
                
//                Выводим на экран доп элемент для настройки сортировки, так как в шапке отсутствует возможность сортировки по дате
                SortView(sorter: $sorter)
                    .padding()
        }
        .onAppear{
//            Подписываемся на получение новых сделок, после загрузки текущего экрана
            server.subscribeToDeals { deals in
//                Сортировку строк отправляем в отдельный поток, что бы пользовательский интерфейс оставался отзывчивым
//                поток последовательный что гарантирует коректную обработку всех поступаемых данных
                myQueue.async {
//                    Сохраняем отсортированный массив
                    self.model = self.sorter.Resort(model: self.model, new: deals)
//                    Выводим в консоль общее количество строк в нашем массиве, для отладки
//                    print(self.model.count)
                }
            }
        }
//        При изменении поля сортировки, обрабатываем событие
        .onChange(of: sorter.field){ _ in
            myQueue.async {
//                Если изменилось поле сортировки, нужно повторно отсортировать массив
                self.model = sorter.Resort(model: model)
            }
        }
//        При изменении порядка сортировки, обрабатываем событие
        .onChange(of: sorter.direction){ _ in
            myQueue.async {
//                Если изменилось направление сортировки, достаточно развернуть массив массив
                self.model = sorter.Reorder(model: model)
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
