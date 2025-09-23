#Clock

set_property PACKAGE_PIN E3 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -name SYSCLK -period 12 [get_ports {clk}]

#Reset 
set_property PACKAGE_PIN N17 [get_ports {rst}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst}]

