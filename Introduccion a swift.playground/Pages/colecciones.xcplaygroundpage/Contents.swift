import Foundation

//COLECCIONES (collections)

//Arrays
var nombres : [String] = ["Paco", "Maria","Juan", "Ana"]

var numeros = [1,2,3]
var nombresVacios = [String] ()

nombresVacios.append("Julio")
print(nombresVacios)

var todosLosNombres = nombres + nombresVacios
print(todosLosNombres)

print("Hay \(todosLosNombres.count) nombres")

