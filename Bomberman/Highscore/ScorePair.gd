extends Node

var nickname
var score

#that's needed for custom sorting
func sort( a, b):
	if(a.score < b.score):
		return false
	return true