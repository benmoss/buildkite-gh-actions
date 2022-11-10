package test

import (
	"math/rand"
	"testing"
	"time"
)

func TestExample(t *testing.T) {
	rand.Seed(time.Now().UnixNano())
	x := rand.Intn(100)
	if x < 50 {
		t.Fatalf("unlucky!! %d", x)
	}
	t.Logf("lucky!! %d", x)
}
