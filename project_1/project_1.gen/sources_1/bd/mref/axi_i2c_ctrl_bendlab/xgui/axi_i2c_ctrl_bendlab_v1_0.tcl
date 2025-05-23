# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CONFIG_LENGTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LOCAL_DATA_WR_ADDR" -parent ${Page_0}


}

proc update_PARAM_VALUE.CONFIG_LENGTH { PARAM_VALUE.CONFIG_LENGTH } {
	# Procedure called to update CONFIG_LENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CONFIG_LENGTH { PARAM_VALUE.CONFIG_LENGTH } {
	# Procedure called to validate CONFIG_LENGTH
	return true
}

proc update_PARAM_VALUE.LOCAL_DATA_WR_ADDR { PARAM_VALUE.LOCAL_DATA_WR_ADDR } {
	# Procedure called to update LOCAL_DATA_WR_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LOCAL_DATA_WR_ADDR { PARAM_VALUE.LOCAL_DATA_WR_ADDR } {
	# Procedure called to validate LOCAL_DATA_WR_ADDR
	return true
}


proc update_MODELPARAM_VALUE.CONFIG_LENGTH { MODELPARAM_VALUE.CONFIG_LENGTH PARAM_VALUE.CONFIG_LENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CONFIG_LENGTH}] ${MODELPARAM_VALUE.CONFIG_LENGTH}
}

proc update_MODELPARAM_VALUE.LOCAL_DATA_WR_ADDR { MODELPARAM_VALUE.LOCAL_DATA_WR_ADDR PARAM_VALUE.LOCAL_DATA_WR_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LOCAL_DATA_WR_ADDR}] ${MODELPARAM_VALUE.LOCAL_DATA_WR_ADDR}
}

