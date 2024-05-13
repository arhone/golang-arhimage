package main

import (
	"fmt"
	log "github.com/sirupsen/logrus"
	"os"
	"time"
)

// main - Запуск сервиса
func main() {

	// Подключение логирования
	if err := os.MkdirAll("logs", os.FileMode(0755)); err != nil {
		panic(err)
	}
	logFile, err := os.OpenFile("logs/main.log", os.O_APPEND|os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		panic(err)
	}
	log.SetOutput(logFile)
	log.SetReportCaller(true)
	log.SetFormatter(&log.JSONFormatter{})
	log.Info("Запуск сервиса")

	for 1 > 0 {
		fmt.Println("Hello")
		time.Sleep(1 * time.Second)
	}
}
