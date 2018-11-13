package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
	"time"
)

var NFS_PATH string
var NFS_SERVER string

func main() {
	NFS_PATH = os.Getenv("NFS_PATH")
	NFS_SERVER = os.Getenv("NFS_SERVER")

	command := "showmount"
	params := []string{"-e", NFS_SERVER}
	execCommand(command, params)
}

func execCommand(commandName string, params []string) bool {
	var path_is bool
	path_is = false

	for {
		out, err := exec.Command(commandName, params...).Output()
		if err != nil {
			log.Fatal(err)
			break
		}

		fmt.Printf("%q\n", strings.Split(string(out), "\n"))
		for _, path := range strings.Split(string(out), "\n") {
			if strings.HasPrefix(path, NFS_PATH) == true {
				path_is = true
			}
			fmt.Printf("%s\n", path)
		}

		if path_is == false {
			break
		}

		time.Sleep(time.Duration(10) * time.Second)
	}
	return true
}
