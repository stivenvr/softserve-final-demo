package main

import (
	"testing"
)

func TestEncrypt(t *testing.T) {
	m := Message{
		MainMsg:             "hola",
		EncryptOrDecryptMsg: "encrypt",
		FinalMesg:           "",
	}
	expectedString := "hoberlaimeas"
	m.FinalMesg = m.Encrypt()
	if m.FinalMesg != expectedString {
		t.Errorf("The expected string is: %v, but got %v", expectedString, m.FinalMesg)
	}

	m.MainMsg = "hijo bueno"
	m.FinalMesg = ""
	expectedString = "himesjober bufatenternober"
	m.FinalMesg = m.Encrypt()
	if m.FinalMesg != expectedString {
		t.Errorf("The expected string is: %v, but got %v", expectedString, m.FinalMesg)
	}
}

func TestDecrypt(t *testing.T) {
	m := Message{
		MainMsg:             "hoberlaimes",
		EncryptOrDecryptMsg: "encrypt",
		FinalMesg:           "",
	}
	expectedString := "hola"
	m.FinalMesg = m.Decrypt()
	if m.FinalMesg != expectedString {
		t.Errorf("The expected string is: %v, but got %v", expectedString, m.FinalMesg)
	}

	m.MainMsg = "himesjober bufatenternober"
	m.FinalMesg = ""
	expectedString = "hijo bueno"
	m.FinalMesg = m.Decrypt()
	if m.FinalMesg != expectedString {
		t.Errorf("The expected string is: %v, but got %v", expectedString, m.FinalMesg)
	}
}
