import Foundation

var arrayNumero:  [Int] = [1, 2, 5, 7, 6]

print("El arrayNumero es",arrayNumero)


print("El arrayNumero tiene " ,arrayNumero.count," valores")

arrayNumero.append(11)

arrayNumero = arrayNumero + [13,12,17]
print(arrayNumero)

func esPar(_ numero: Int) -> Bool {
    return numero % 2 == 0
    //return numero.isMultiple(of: 2)
}

/*for (indice, elemento) in arrayNumero.enumerated().reversed(){
    if esPar(elemento){
        arrayNumero.remove(at: indice)
       print("Borrando la posicion ",indice, " porque es valor es par: ",elemento)
       print(arrayNumero)
    }else{
        print(elemento, " No es par, no se borra nada")
    }
}

print(arrayNumero) */

func borrarPares(_ array: inout [Int]) -> [Int] {
    for (indice, elemento) in array.enumerated().reversed(){
        if esPar(elemento){
            array.remove(at: indice)
    }
  }
    return array
}

print("\n ----------------arrayNumerosImpares--------------\n")
var arrayNumerosImpares: [Int] = [1, 2, 3, 4, 7, 8]
print("Array inicial",arrayNumerosImpares)
print("Borramos los pares",borrarPares(&arrayNumerosImpares))



var conjuntoNum : Set<Int> = [1,2,4,6,7,8,9,11]
