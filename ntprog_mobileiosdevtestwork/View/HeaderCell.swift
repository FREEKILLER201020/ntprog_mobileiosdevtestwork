//
//  HeaderCell.swift
//  ntprog_mobileiosdevtestwork
//
//  Created by Kirill Burchenko on 19.01.2023.
//

import SwiftUI

struct HeaderCell: View {
//    Общая высота шапки
    @State private var totalHeight = CGFloat(60)
//    Привязка к сортировщику
    @Binding var sorter: Sorter
    
    var body: some View {
//        GeometryReader используем что бы узнать ширину строки
        GeometryReader{ container in
            HStack(spacing: 0){
//                Каждая надпись в шапке будет кнопкой, что бы при нажатии на нее настраивать сортировку
                Button(action: {
//                    Изменяем поле сортировки
                    if (sorter.field != .instrument){
                        sorter.field = .instrument
                    }
//                    Если поле сортировки не меняется, меняем направление. Экономим ресурсы на сортировке
                    else{
                        sorter.direction = sorter.direction == .up ? .down : .up
                    }
                }){
//                    Выводим текст поля шапки
                    HStack(spacing: 1){
                        Text("Instrument")
//                        Если это активное поле сортировки, выводим стрелку направления сортировки
                        if (sorter.field == .instrument){
                            Image(systemName: sorter.direction == .up ? "arrow.up" : "arrow.down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12, height: 12, alignment: .center)
                        }
                    }
                }
//                Настраиваем шрифт текста. Если это активное поле сортировки, делаем его жирным
                .font(.system(size: 12, weight: sorter.field == .instrument ? .bold : .regular))
//                Задаем ширину в 1/4 от общей ширины контейнера
                .frame(width: container.size.width/4, alignment: .center)
                
                Button(action: {
                    if (sorter.field != .price){
                        sorter.field = .price
                    }
                    else{
                        sorter.direction = sorter.direction == .up ? .down : .up
                    }
                }){
                    HStack(spacing: 1){
                        Text("Price")
                        if (sorter.field == .price){
                            Image(systemName: sorter.direction == .up ? "arrow.up" : "arrow.down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12, height: 12, alignment: .center)
                        }
                    }
                }
                .font(.system(size: 12, weight: sorter.field == .price ? .bold : .regular))
                .frame(width: container.size.width/4, alignment: .center)
                
                Button(action: {
                    if (sorter.field != .amount){
                        sorter.field = .amount
                    }
                    else{
                        sorter.direction = sorter.direction == .up ? .down : .up
                    }
                }){
                    HStack(spacing: 1){
                        Text("Amount")
                        if (sorter.field == .amount){
                            Image(systemName: sorter.direction == .up ? "arrow.up" : "arrow.down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12, height: 12, alignment: .center)
                        }
                    }
                }
                .font(.system(size: 12, weight: sorter.field == .amount ? .bold : .regular))
                .frame(width: container.size.width/4, alignment: .center)
                
                Button(action: {
                    if (sorter.field != .side){
                        sorter.field = .side
                    }
                    else{
                        sorter.direction = sorter.direction == .up ? .down : .up
                    }
                }){
                    HStack(spacing: 1){
                        Text("Side")
                        if (sorter.field == .side){
                            Image(systemName: sorter.direction == .up ? "arrow.up" : "arrow.down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12, height: 12, alignment: .center)
                        }
                    }
                }
                .font(.system(size: 12, weight: sorter.field == .side ? .bold : .regular))
                .frame(width: container.size.width/4, alignment: .center)
            }
//            Так как кнопка по умолчанию имеет accentColor, изменяем его на черный
            .foregroundColor(Color.black )
            .font(.system(size: 12))
//            Задаем правила изменения размера шрифта, что бы было видно всю строку
            .scaledToFill()
            .lineLimit(1)
            .minimumScaleFactor(0.1)
//            Настраиваем общую высоту блока
            .frame(height: totalHeight, alignment: .center)
        }
        .frame(height: totalHeight)
    }
}

//Предпросмотр
struct HeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        HeaderCell(sorter: .constant(Sorter()))
            .padding(20)
    }
}
