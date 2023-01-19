//
//  SortView.swift
//  ntprog_mobileiosdevtestwork
//
//  Created by Kirill Burchenko on 19.01.2023.
//

import SwiftUI

struct SortView: View {
//    Привязка к сортировщику
    @Binding var sorter: Sorter
    
    var body: some View {
        HStack(alignment: .top){
            VStack(){
                HStack{
                    Text("Sort by:")
//                    Выбор поля сортировки
                    Picker("Sorting field", selection: $sorter.field) { // 3
                        ForEach(SortField.allCases, id: \.self) { item in // 4
                            Text(item.rawValue.capitalized) // 5
                        }
                    }
//                    Задаем стиль выбора
                    .pickerStyle(.menu)
                }
                
                HStack{
                    Text("Sort direction:")
//                    Выбор направления сортировки
                    Picker("Sorting field", selection: $sorter.direction) { // 3
                        ForEach(SortDirection.allCases, id: \.self) { item in // 4
                            Text(item.rawValue.capitalized) // 5
                        }
                    }
//                    Задаем стиль выбора
                    .pickerStyle(.menu)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView(sorter: .constant(Sorter()))
    }
}

struct SorterButtonStyle: ViewModifier {
    var sorter: Sorter
    var field: SortField
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(sorter.field == field ? Color.accentColor : Color.black)
            .background(.ultraThinMaterial)
            .background(sorter.field == field ? Color.accentColor.opacity(0.1) : Color.white.opacity(0.1))
            .cornerRadius(10)
    }
}

extension View {
    func sorterButtonStyle(sorter: Sorter, field: SortField) -> some View {
        modifier(SorterButtonStyle(sorter: sorter, field: field))
    }
}
