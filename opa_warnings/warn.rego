package main

import data.child_modules

########################
# Rules
########################

warn[management_group_display_name] {
	management_group_display_name := sprintf("The management_group(s) values per module:\n \n%v\n \n", [mgs_change_display_name])
}

warn[role_definition_name] {
	role_definition_name := sprintf("The role_definition_name(s) per module:\n \n%v\n \n", [role_def_change_name])
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

# # # Get the role_definition_name from all role_assignments in the opa.json
role_def_change_name[module_name] = plcs {
	module := input.resource_changes[_]
	module_name := module.module_address
	plcs := [plc |
		input.resource_changes[r].type == "azurerm_role_definition"
		input.resource_changes[r].module_address == module.module_address
		plc := input.resource_changes[r].change.after.name
	]
}
