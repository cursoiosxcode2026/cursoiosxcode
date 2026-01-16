import Foundation
//import UIKit
//import SwiftUI

var greeting : String = "Hello, playground"

var inicio = "Hola"

inicio = "adios"

//print (inicio)

var constante = 10
constante = 5

var x = 5, y = 10, z = 5.5
//var n = 5

var micolor : Int = 5
micolor = 10

let mitexto = "😄 emoji"

//comentarios
/*
 Multilinea
 linea 2
 */

let pi = 3.14159

var numero : Int = 5
numero = numero + Int (pi)

let pisumado = pi + Double (numero)

let esverdadero = true
let esfalso = false

var micondicion = esverdadero && !esfalso
print(micondicion)

if micondicion == true {
    print("correcto")
} else {
    print("no es correcto")
}

let tupla1 = (1, "hola", "que tal")

print(tupla1.0)

let tupla2 = (codigo: 500, descripcion: "Error!")

print("Mensaje devuelto: \(tupla2.codigo) con codigo de error: \" \(tupla2.descripcion)\"")

//Variable opcionales (optionals)

var respuestaOpcional : String? = "hola"
respuestaOpcional = nil

var respuestaObligada : String = "adios"

//errores
//respuestaObligada = nil
//respuestaObligada = 5

if respuestaOpcional == nil {
    print("EL usuario NO ha respondido")
}

let datos : String? = nil
let altura: Int? = nil

// ?? Operador coalesce, da un valor por defecto en caso de que sea nil
let datosCompletos = "Nombre: Pepe, " + "Datos: " + (datos ?? "No hay datos")

print(datosCompletos)
print (altura ?? 100)

let miNumero : Int? = 5
let numeroFinal : Int

//puede ser con let o var
guard let numeroFinal = miNumero else {
    fatalError("Conversion no valida")
}
print(numeroFinal)


var a = 5.0, b = 10.0
var c : Double
c = -a / b
print(c)

//c = c+a
//c += a

var num1 = 3, num2 = 5
num1 == 3
/*if (num1 == 3){
    print("son iguales")
}*/

num1 != num2

"hola" == "hola"
"hola" == "Hola".lowercased()
"hola" == "Adios"


if num1 == num2 {
    print("son iguales")
} else {
    print("son diferentes")
}

var alturaTotal = 0
var margen = 10
var contenido = 50
let padding = true
print("calculando alturas -----")
alturaTotal = margen + contenido

if padding {
    alturaTotal = alturaTotal + 20
}

// Operador ternario (ternary)
alturaTotal = 0
alturaTotal = margen + contenido + (padding ? 20 : 0)
print(alturaTotal)







