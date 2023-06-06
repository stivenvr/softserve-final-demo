package main

import (
	"fmt"
	"strings"
)

// var DiccE = map[string]string{
// 	"i": "imes",
// 	"e": "enter",
// 	"a": "ai",
// 	"o": "ober",
// 	"u": "ufat",
// }
// var DiccD = map[string]string{
// 	"u": "ufat",
// 	"o": "ober",
// 	"a": "ai",
// 	"e": "enter",
// 	"i": "imes",
// }

func (m Message) Encrypt() string {
	result := m.MainMsg
	result = strings.Replace(result, "a", "ai", -1)
	result = strings.Replace(result, "e", "enter", -1)
	result = strings.Replace(result, "i", "imes", -1)
	result = strings.Replace(result, "o", "ober", -1)
	result = strings.Replace(result, "u", "ufat", -1)
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	fmt.Println("HOLA")
	return result

}
func (m Message) Decrypt() string {
	result := m.MainMsg
	result = strings.Replace(result, "ufat", "u", -1)
	result = strings.Replace(result, "ober", "o", -1)
	result = strings.Replace(result, "imes", "i", -1)
	result = strings.Replace(result, "enter", "e", -1)
	result = strings.Replace(result, "ai", "a", -1)
	// fmt.Println(result)
	return result

}
