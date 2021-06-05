package main

import data.child_modules

######################################################################
#  Warnings are used for troubleshooting, uncomment to use.
######################################################################
#  Return all the management groups under each root_id
warn[msg] {
	mgs := [mg | input.resource_changes[i].type == "azurerm_management_group"; mg := input.resource_changes[i].change.after.display_name]
	id := array.slice(mgs, 0, 1)
	mg := array.slice(mgs, 1, 100)
	msg := sprintf("\nFor root_id: %v \n \nthese management groups will be created:\n%v", [id, mg])
}
