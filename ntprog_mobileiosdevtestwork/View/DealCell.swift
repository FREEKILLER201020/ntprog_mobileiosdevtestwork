//
//  DealCell.swift
//  ntprog_mobileiosdevtestwork
//
//  Created by Kirill Burchenko on 19.01.2023.
//

import SwiftUI

struct DealCell: View {
//    Строка для отображения
    var deal: Deal
//    Общая высота строки
    @State private var totalHeight = CGFloat(60)
//    Форматирование даты
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT") //Set timezone that you want
        formatter.locale = NSLocale.current
        formatter.dateFormat = "HH:mm:ss dd:MM:yyy"
        return formatter
    }()
    
    var body: some View {
//        GeometryReader используем что бы узнать ширину строки
        GeometryReader{ container in
            VStack(alignment: .leading, spacing: 0){
//                Выводим дату
                Text(dateFormatter.string(from: deal.dateModifier))
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 15)
                HStack(spacing: 0){
//                    Определяем продажу или покупку
                    let sell = deal.side == Deal.Side.sell
//                    Выводим инструмент, обрезаем часть после "_", согласно примеру
                    Text(deal.instrumentName.split(separator: "_")[0])
//                    Задаем ширину в 1/4 от общей ширины контейнера
                        .frame(width: container.size.width/4, alignment: .leading)
//                    Выводим цену в формате 2 знака после запятой с округлением
                    Text("\(deal.price, specifier: "%.2f")")
                        .frame(width: container.size.width/4)
//                    Выводим количество в формате 0 знаков после запятой с округлением
                    Text("\(deal.amount, specifier: "%.0f")")
                        .frame(width: container.size.width/4)
//                    Выводим статус строки
                    Text(sell ? "Sell" : "Buy")
                        .frame(width: container.size.width/4)
//                    Задаем цвет статуса
                        .foregroundColor(sell ? Color.red : Color.green)
                }
//                Устанавливаем размер шрифта
                .font(.system(size: 17))
//                Задаем правила изменения размера шрифта, что бы было видно всю строку
                .scaledToFill()
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            }
//            Задаем высоту блока
            .frame(height: totalHeight, alignment: .center)
        }
        .frame(height: totalHeight)
    }
}

// Предпросмотр
struct DealCell_Previews: PreviewProvider {
    static var previews: some View {
        DealCell(deal: Deal(id: 0, dateModifier: Date(), instrumentName: "USD/RUB_aaa", price: 62.106, amount: 1000000.8, side: Deal.Side.sell))
    }
}
