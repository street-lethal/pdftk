package main

import (
	"reflect"
	"testing"
)

func TestConfig_RemainingPages(t *testing.T) {
	tests := []struct {
		name         string
		removedPages []int
		want         []string
	}{
		{
			name:         "normal",
			removedPages: []int{3, 5, 8},
			want:         []string{"1-2", "4-4", "6-7", "9-end"},
		},
		{
			name:         "continuous integers",
			removedPages: []int{3, 5, 6, 9, 10, 11, 12, 17},
			want:         []string{"1-2", "4-4", "7-8", "13-16", "18-end"},
		},
		{
			name:         "starts from 1",
			removedPages: []int{1, 5, 9},
			want:         []string{"2-4", "6-8", "10-end"},
		},
		{
			name:         "starts from 1-3",
			removedPages: []int{1, 2, 3, 9},
			want:         []string{"4-8", "10-end"},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			c := Config{
				RemovedPages: tt.removedPages,
			}
			if got := c.RemainingPages(); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("RemainingPages() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestConfig_TransferPages(t *testing.T) {
	type fields struct {
		RemovedPages  []int
		OriginalPages []int
	}
	tests := []struct {
		name          string
		removedPages  []int
		originalPages []int
		want          OriginToTransferred
	}{
		{
			name:          "normal",
			removedPages:  []int{3, 5, 8},
			originalPages: []int{1, 2, 4, 6, 9, 10},
			want: [][]int{
				{1, 1},
				{2, 2},
				{4, 3},
				{6, 4},
				{9, 6},
				{10, 7},
			},
		},
		{
			name:          "continuous integers",
			removedPages:  []int{3, 5, 6, 9, 10, 11, 12, 17},
			originalPages: []int{1, 2, 4, 7, 14, 20},
			want: [][]int{
				{1, 1},
				{2, 2},
				{4, 3},
				{7, 4},
				{14, 7},
				{20, 12},
			},
		},
		{
			name:          "starts from 1-3",
			removedPages:  []int{1, 2, 3, 9},
			originalPages: []int{4, 7, 14},
			want: [][]int{
				{4, 1},
				{7, 4},
				{14, 10},
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			c := Config{
				RemovedPages:  tt.removedPages,
				OriginalPages: tt.originalPages,
			}
			if got := c.TransferPages(); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("TransferPages() = %v, want %v", got, tt.want)
			}
		})
	}
}
