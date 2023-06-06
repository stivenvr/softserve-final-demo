package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"
	"text/template"
)

var tmpl *template.Template

type Message struct {
	MainMsg             string
	EncryptOrDecryptMsg string
	FinalMesg           string
}

func Index(w http.ResponseWriter, r *http.Request) {
	tmpl.ExecuteTemplate(w, "index.html", nil)
}

func Process(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		http.Redirect(w, r, "/", http.StatusSeeOther)
	}

	// http.Redirect(w, r, "/", http.StatusSeeOther)
	m := Message{
		MainMsg:             strings.ToLower(r.FormValue("message")),
		EncryptOrDecryptMsg: r.FormValue("format"),
		FinalMesg:           "",
	}
	// fmt.Println(m.MainMsg)
	// fmt.Println(m.EncryptOrDecryptMsg)
	if m.EncryptOrDecryptMsg == "encrypt" {
		m.FinalMesg = m.Encrypt()
		//fmt.Println(m.MainMsg)
		//fmt.Println(m.FinalMesg)
	}
	if m.EncryptOrDecryptMsg == "decrypt" {
		m.FinalMesg = m.Decrypt()
		fmt.Println(m.FinalMesg)
		//fmt.Println(m.MainMsg)
		//fmt.Println(m.FinalMesg)
	}
	tmpl.ExecuteTemplate(w, "process.html", m)
}

func main() {
	mux := http.NewServeMux()
	tmpl = template.Must(template.ParseGlob("templates/*.html"))
	fs := http.FileServer(http.Dir("./static"))
	mux.Handle("/static/", http.StripPrefix("/static/", fs))

	mux.HandleFunc("/", Index)
	mux.HandleFunc("/process", Process)

	fmt.Println("Inicio del proyecto!!")
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
	log.Fatal(http.ListenAndServe(":5555", mux))
}
