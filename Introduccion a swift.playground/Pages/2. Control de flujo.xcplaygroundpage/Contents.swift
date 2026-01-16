import Foundation

//BUCLES FOR

//La variable "indice" va a valer de 1 hasta 3
for indice in 1...3 {
    print("Hola \(indice)")
}

//BUCLES WHILE
//El bucle se ejecuta hasta que NO se cumpla la condición

var  indice2 = 0
while indice2 != 5 {
    print(indice2)
    indice2 = indice2 + 1
}
print("Terminó el bucle while")

var seCumpleCondicion = false
var i = 0
while !seCumpleCondicion {
    if i == 10 {
        seCumpleCondicion = true
    }
    i = i + 1
}

print("Terminó el segundo bucle while")

//Bucle repeat-while
//Este se va a ejecutar SIEMPRE AL MENOS una vez


i = 0
repeat{
    print("Indice i vale \(i)")
    i = i + 1
}while i < 5
print("Terminó el bucle repeat-while")

//Un ejemplo que combina los condicionales con los bucles

let estaHelando = 0
let haceFresco = 10
let estaTemplado = 20
let haceCalor = 30
let noSalirDeCasa = 40

var temperatura = -5

for temperatura in -5...45 {
    print("Temperatura en la calle: \(temperatura)")
    if temperatura <= estaHelando { //menor o igual a 0 grados
        print("Está helando! Ten cuidado al salir")
    } else if temperatura > estaHelando && temperatura <= estaTemplado {
        print("Ponte una rebeca")
    }else if temperatura == estaTemplado {
        print("Puedes ir en camiseta")
    }else if temperatura == noSalirDeCasa {
        print("¡No salgas de casa!")
    } else {
        print("Hace otra temperatura")
    }
}

//Asignacion mediante expresiones condicionales


let consejo = if temperatura <= estaHelando{
    "Abrigate al salir, está helando"
} else if temperatura == estaTemplado{
    "Está templado, puedes ir de manga corta"
} else {
    "Hace otra temperatura, no sé que decirte que te pongas"
}
print(consejo)
print("--------------------------")


//Switch: cuando queremos comparar entre múltiples condiciones
//sin tener que usar estructuras if-else
let valor = 6
switch valor{
case 5:
    print("Vale 5")
case 3:
    print("Vale 3")
case 5...10:
    print("Vale entre 5 y 10")
default:
    print("Vale otra cosa")
}

//Swift también tiene otros controles de flujo como 'continue'
//o 'break'





