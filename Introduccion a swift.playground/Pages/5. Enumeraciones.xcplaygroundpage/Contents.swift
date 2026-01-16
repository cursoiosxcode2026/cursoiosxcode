import Foundation

//Enumeraciones: definir un conjunto de valores dentro de una estructura

enum DiasSemana {
    case lunes
    case martes
    case miercoles
    case jueves
    case viernes
    case sabado
    case domingo
}

print("--------------------ENUMERACIONES------------------")
//Crear una variable que usa el enum DiasSemana
var diaSemana = DiasSemana.sabado
var diaSemana2 : DiasSemana = .martes

//Tambien se puede acceder de manera abreviada
diaSemana = .jueves

if diaSemana == .sabado || diaSemana == .domingo {
    print("Es fin de semana")
}

switch diaSemana {
case .lunes, .martes, .miercoles, .jueves, .viernes:
    print("Es un día entre semana")
case .sabado, .domingo:
    print("Es un día de fin de semana")
    
}

//Raw values: asignar un valor dentro del enum, definiendo tipo
//de dato
//Si no se define el raw devuelve el nombre por ejemplo domingo
enum DiasSemanaConNombre: String {
    case lunes = "Lunes 😩"
    case martes = "Martes"
    case miercoles = "Miércoles"
    case jueves = "Jueves"
    case viernes = "Viernes"
    case sabado = "Sábado 🎉"
    case domingo = "Domingo"
}


enum Posiciones: Int {
    case primero = 1
    case segundo = 2
    case tercero = 3
}

var diaSemanaNombre = DiasSemanaConNombre.sabado

//Para acceder al raw value
print("diaSemanaNombre esta asociado al valor del enum:", diaSemanaNombre.rawValue)

let posicion = Posiciones.primero
print("Estoy en la posicion:", posicion.rawValue, "🏆")



