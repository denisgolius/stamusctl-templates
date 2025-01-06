package main

import (
	"fmt"
	"os"
	"path/filepath"

	"gopkg.in/yaml.v2"
)

func main() {
	if len(os.Args) != 3 {
		fmt.Println("Missing config argument")
		os.Exit(1)
	}
	// Read values
	path := os.Args[2]
	yamlFile, err := os.ReadFile(filepath.Join(path, "values.yaml"))
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading config file: %v", err)
		os.Exit(1)
	}
	// Unmarshal values
	values := make(map[string]interface{})
	err = yaml.Unmarshal(yamlFile, values)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unmarshal: %v", err)
	}
	data, err := yaml.Marshal(values)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Marshal: %v", err)
	}
	fmt.Println(string(data))
}
