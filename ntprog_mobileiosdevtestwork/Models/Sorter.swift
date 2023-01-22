//
//  Sorter.swift
//  ntprog_mobileiosdevtestwork
//
//  Created by Kirill Burchenko on 19.01.2023.
//

import Foundation

//Сортировщик данных
struct Sorter{
//    Поле для сортировки
    var field: SortField = .date
//    Направление сортировки
    var direction: SortDirection = .down
    
//    Сортировка массива
    func Resort(model: [Deal], new: [Deal] = []) -> [Deal]{
        
        var total: [Deal] = model
//        Если есть новые строки, дабовляем их в массив
        if (!new.isEmpty){
            total.append(contentsOf: new)
        }
//        Выбираем направление сортировки
        switch self.direction{
        case .down:
//            Выбираем поле сортировки
            switch self.field{
            case .date: return total.sorted(by: {$0.dateModifier > $1.dateModifier})
            case .side: return total.sorted(by: {($0.side == .sell ? 0 : 1) > ($1.side == .sell ? 0 : 1)})
            case .price: return total.sorted(by: {$0.price > $1.price})
            case .amount: return total.sorted(by: {$0.amount > $1.amount})
            case .instrument: return total.sorted(by: {$0.instrumentName > $1.instrumentName})
            }
        case .up:
//            Выбираем поле сортировки
            switch self.field{
            case .date: return total.sorted(by: {$0.dateModifier < $1.dateModifier})
            case .side: return total.sorted(by: {($0.side == .sell ? 0 : 1) < ($1.side == .sell ? 0 : 1)})
            case .price: return total.sorted(by: {$0.price < $1.price})
            case .amount: return total.sorted(by: {$0.amount < $1.amount})
            case .instrument: return total.sorted(by: {$0.instrumentName < $1.instrumentName})
            }
        }
    }
    
//    Разворачивание массива
    func Reorder(model: [Deal]) -> [Deal]{
//        Возвращаем развернутый массив
        return model.reversed()
    }
}

enum SortField: String, CaseIterable{
    case date, instrument, price, amount, side
}

enum SortDirection: String, CaseIterable{
    case up, down
}
