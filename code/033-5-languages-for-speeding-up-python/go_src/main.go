package distance_go

import (
	"math"
)

// Coord represents a 2D coordinate
type Coord struct {
	X, Y float64
}

type CoordList []Coord

// CalculateDistance calculates the total distance traveled for a slice of coordinates
func CalculateDistance(coords CoordList) float64 {
	totalDistance := 0.0
	for i := 0; i < len(coords)-1; i++ {
		totalDistance += distance(coords[i], coords[i+1])
	}
	return totalDistance
}

// distance calculates the Euclidean distance between two coordinates
func distance(c1, c2 Coord) float64 {
	return math.Sqrt(math.Pow(c2.X-c1.X, 2) + math.Pow(c2.Y-c1.Y, 2))
}
