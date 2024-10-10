package main

import (
	"fmt"
	"os"

	"gopkg.in/yaml.v2"
)

func main() {
	values := make(map[string]interface{})

	yamlFile, err := os.ReadFile("./tmp/values.yaml")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading config file: %v", err)
		os.Exit(1)
	}
	err = yaml.Unmarshal(yamlFile, values)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unmarshal: %v", err)
		os.Exit(1)
	}
	data, err := yaml.Marshal(values)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Marshal: %v", err)
		os.Exit(1)
	}
	fmt.Println(string(data))
}
