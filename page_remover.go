package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"strings"
)

var (
	transferMode = flag.Bool("transfer", false, "transfer pages")
)

func main() {
	data, err := os.ReadFile("data/config.json")
	if err != nil {
		panic(err)
	}

	var cfg Config
	if err := json.Unmarshal(data, &cfg); err != nil {
		panic(err)
	}

	flag.Parse()

	if *transferMode {
		fmt.Println(cfg.TransferPages())
	} else {
		fmt.Println(strings.Join(cfg.RemainingPages(), " "))
	}
}

type Config struct {
	RemovedPages  []int `json:"removed_pages"`
	OriginalPages []int `json:"original_pages"`
}

func (c Config) RemainingPages() []string {
	remainingPages := make([]string, 0, len(c.RemovedPages))

	index := 1
	for _, removedPage := range c.RemovedPages {
		if index < removedPage {
			remainingPages = append(
				remainingPages,
				fmt.Sprintf("%d-%d", index, removedPage-1),
			)
		}
		index = removedPage + 1
	}

	remainingPages = append(
		remainingPages,
		fmt.Sprintf("%d-end", index),
	)

	return remainingPages
}

type OriginToTransferred [][]int

func (o OriginToTransferred) String() string {
	var s string

	for _, keyValue := range o {
		s += fmt.Sprintf("%d\t%d\n", keyValue[0], keyValue[1])
	}

	return s
}

func (c Config) TransferPages() OriginToTransferred {
	originToTransferred := make(OriginToTransferred, 0)

	for _, originalPage := range c.OriginalPages {
		found := false
		for i, removedPage := range c.RemovedPages {
			if originalPage <= removedPage {
				found = true
				originToTransferred = append(
					originToTransferred,
					[]int{originalPage, originalPage - i},
				)
				break
			}
		}

		if !found {
			originToTransferred = append(
				originToTransferred,
				[]int{originalPage, originalPage - len(c.RemovedPages)},
			)
		}
	}

	return originToTransferred
}
