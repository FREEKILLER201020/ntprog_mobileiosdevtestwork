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
    func Resort(model: [Deal], new: [Deal] = []) -> [SortDirection: [SortField: [Deal]]]{
        
        var total: [Deal] = model
//        Если есть новые строки, дабовляем их в массив
        if (!new.isEmpty){
            total.append(contentsOf: new)
        }
        var res: [SortField: [Deal]] = [:]
        var res_tot: [SortDirection:[SortField: [Deal]]] = [:]
//        Выполняем все сортировки в одном направлении
        res[SortField.date] = total.sorted(by: {$0.dateModifier > $1.dateModifier})
        res[SortField.side] = total.sorted(by: {($0.side == .sell ? 0 : 1) > ($1.side == .sell ? 0 : 1)})
        res[SortField.price] = total.sorted(by: {$0.price > $1.price})
        res[SortField.amount] = total.sorted(by: {$0.amount > $1.amount})
        res[SortField.instrument] = total.sorted(by: {$0.instrumentName > $1.instrumentName})
        res_tot[SortDirection.down] = res
//        Выполняем все сортировки в другом направлении
        res = [:]
        res[SortField.date] = total.sorted(by: {$0.dateModifier < $1.dateModifier})
        res[SortField.side] = total.sorted(by: {($0.side == .sell ? 0 : 1) < ($1.side == .sell ? 0 : 1)})
        res[SortField.price] = total.sorted(by: {$0.price < $1.price})
        res[SortField.amount] = total.sorted(by: {$0.amount < $1.amount})
        res[SortField.instrument] = total.sorted(by: {$0.instrumentName < $1.instrumentName})
        res_tot[SortDirection.up] = res
        return res_tot
    }
    
//    Разворачивание массива
    func Reorder(model: [Deal]) -> [SortField: [Deal]]{
//        Возвращаем развернутый массив
        var res: [SortField: [Deal]] = [:]
        res[SortField.date] = res[SortField.date]?.reversed()
        res[SortField.side] = res[SortField.side]?.reversed()
        res[SortField.price] = res[SortField.price]?.reversed()
        res[SortField.amount] = res[SortField.amount]?.reversed()
        res[SortField.instrument] = res[SortField.instrument]?.reversed()
        return res
    }
}

enum SortField: String, CaseIterable{
    case date, instrument, price, amount, side
}

enum SortDirection: String, CaseIterable{
    case up, down
}
