package main

import data.child_modules

######################################################################
#  Warnings are used for troubleshooting, uncomment to use.
######################################################################
#  Return all the management groups under each root_id
warn[msg] {
	id := array.slice(mgs_change_display_name[i], 0, 1)
	mg := array.slice(mgs_change_display_name[i], 1, 100)
	msg := sprintf("\nFor root_id: %v these management groups will be created:\n\n%v\n", [id, mg])
}

########################
# Library
########################

# # # Get the display name from all management groups in the opa.json
mgs_change_display_name[module_name] = mgs {
	module := input.resource_changes[_]
	module_name := module.module_address
	mgs := [mg |
		input.resource_changes[r].type == "azurerm_management_group"
		input.resource_changes[r].module_address == module.module_address
		mg := input.resource_changes[r].change.after.display_name
	]
}
