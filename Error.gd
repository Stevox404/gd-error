# GDError
# Author: S. Keyroh
# License: MIT
# Version: 1.0.0
# Description: Generic GDScript Error Logging tool 
# Usage: 
#  + GDError.new(err_msg: String, is_fatal:= false, err_name:= "Error")
#  + Only err_msg is required. All others are optional

class_name GDError

#TODO Find how to make this var static
#TODO can class have multiple constructors?
var stack_trace := true 

var err_name: String
var message: String
var stack: Array
var fatal: bool

func _init(err_msg: String, fatal := false, err_name := "Error"):
	self.err_name = err_name
	self.fatal = fatal
	message = err_msg
	stack = get_stack()
	self.print()

func print() -> void:
	var error := "%0: %1\n".format([err_name, message], "%_")
	error += "\tAt: %0: %1: %2()\n".format(
			[stack[1].source,stack[1].line, 
			stack[1].function], "%_")
	
	if(stack_trace):
		error += "\tStack:\n"
		for i in stack.size():
			if i == 0:
				continue
			error += "\t\t%0: %1: %2()\n".format( 
					[stack[i].source, stack[i].line,
					stack[i].function], "%_")
	
	printerr(error)
	
	if fatal:
		push_error(err_name+": "+message)
		Engine.get_main_loop().quit()
	else:
		push_warning(err_name+": "+message)
