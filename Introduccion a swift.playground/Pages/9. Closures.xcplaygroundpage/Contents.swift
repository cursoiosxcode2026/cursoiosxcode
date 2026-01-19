import Foundation

//Closures o funciones anonimas

func saludar(nombre:String) -> String {
    return "Hola \(nombre)"
}

let saludarClousure = { (nombre:String) -> String in
    return "Hola \(nombre)"
}

print(saludar(nombre: "Julio"))
print(saludarClousure("Julia"))
print ({(nombre: String) -> String in return "Hola \(nombre)"})

//Notacion: de la mas explicita a la mas abreviada
//

let closure1 = {(a: Int, b: Int) -> Int in
    return a + b}

//Swift infiere automaticamente el tipo de retorno (Int)

let closure2 = { (a: Int, b: Int)
    in return a + b}

//Tambien puede inferir los tipos de los parametros
let closure3: (Int, Int) -> Int = { a, b in
    return a + b
}

//Usar los parametros abreviados ($0, $1)
let closure4: (Int, Int) -> Int = {
    return ($0 + $1)
}

//La forma más breve: cuando es una sola expresión, no hace falta 'return'

let closure5: (Int, Int) -> Int = {$0 + $1}

let closure6: (Int, Int) -> Int = (+)

print(closure1(2,3))
print(closure5(2,3))

//Funciones que reciben closures como parametro
func procesarNumeros (_ a: Int, _ b: Int, operacion: (Int, Int) ->Int) -> Int {
    return operacion(a, b)
}

let sumar = { (x: Int, y: Int) -> Int in x + y}

print(procesarNumeros(2, 3, operacion: sumar))

//Podemos hacerlo como funcion anonima
procesarNumeros(2,3, operacion: {x, y in x + y})

//Idem con argumentos abreviados
procesarNumeros(2,3, operacion: {$0 + $1})

//Trailing closures: cuando la funcion que se pasa es el ULTIMO
//PARAMETRO
procesarNumeros(2, 3) {$0 + $1}

//Ejemplos de uso de los trailing closures en las colecciones

//let numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let numeros = (1 ... 10)

//Filtrar(elimina) los que son mayores que 5
let menoresQue5 = numeros.filter {$0 < 5}

//identica a: numeros.filter ({ $0 < 5})
print(menoresQue5)

//Mapear Valores (recorre todo el array y aplica el closure
//a cada elemento

let numerosAlCuadrado = numeros.map {$0 * $0}
print(numerosAlCuadrado)

let numerosString = numeros.map {String($0)}
print(numerosString)

var numerosVarios = [3, 1, 5, 0, 1, 6, 8, 11, -1, 4]
let ordenadosMenorAMayor = numerosVarios.sorted()
print(ordenadosMenorAMayor)
let ordenadosMayorAMenor = numerosVarios.sorted {$0 > $1}
print(ordenadosMayorAMenor)

//Misma forma que {$0 > $1}, pero abreviada
print(numerosVarios.sorted(by: >))


