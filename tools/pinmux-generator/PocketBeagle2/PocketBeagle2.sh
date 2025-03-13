#!/bin/bash

source $(dirname "$0")/pinmux.sh

file="PocketBeagle2"

echo "

#include \"k3-pinctrl.h\"
#include <dt-bindings/leds/common.h>
#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/board/PocketBeagle2-bone-pins.h>

&main_pmx0 {

" > ${file}.dts

echo "&mcu_pmx0 {" > ${file}-mcu.dts

echo "" >${file}-pinmux.dts
echo "" >${file}-gpio.dts
echo "" >${file}_config-pin.txt
echo "" >${file}-a-bone-pins.h
echo "" >${file}-b-bone-pins.h
echo "" >${file}-bone-pins.h

disable_timer="enable"

#PocketBeagle
gpio_mode="7"

msg="	/************************/" ; echo_both
msg="	/* P1 Header */" ; echo_both
msg="	/************************/" ; echo_both
msg="" ; echo_both

pcbpin="P1_01" ; label_pin="power" ; label_info="VIN-AC" ; echo_label

pcbpin="P1_02"  ; ball="E18"  ; default_mode="7" ; cp_default="gpio"    ; pcbpinA="P1_02A"; find_ball
pcbpin="P1_02A" ; ball="AA19" ; default_mode="7" ; cp_default="disable" ; pcbpinA="P1_02"; find_ball

pcbpin="P1_03" ; ball="F18" label_pin="system" ; label_info="usb1_vbus_out" ; echo_label_analog

pcbpin="P1_04"  ; ball="D20" ; default_mode="7" ; pcbpinA="P1_04A" ; find_ball
pcbpin="P1_04A" ; ball="Y18" ; default_mode="7" ; cp_default="disable" ; pcbpinA="P1_04" ; find_ball

pcbpin="P1_05" ; ball="AB10" label_pin="system" ; label_info="usb1_vbus_in" ; echo_label_analog

pcbpin='P1_06' ; ball='E19' ; default_mode='2' ; cp_default='spi_cs'  ;  pcbpinA='P1_06A'; find_ball
pcbpin='P1_06A' ; ball='AD18' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P1_06' ; find_ball

pcbpin='P1_07' ; label_pin='system' ; label_info='VIN-USB'  ;   echo_label

pcbpin='P1_08' ; ball='A20' ; default_mode='1' ; cp_default='spi_sclk'  ;   find_ball
pcbpin='P1_09' ; ball='AD10' ; label_pin='system' ; label_info='USB1-DN'  ;   echo_label_analog
pcbpin='P1_10' ; ball='A18' ; default_mode='1' ; cp_default='spi'  ;  pcbpinA='P1_10A'; find_ball
pcbpin='P1_10A' ; ball='B19' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P1_10' ; find_ball
pcbpin='P1_11' ; ball='AE9' ; label_pin='system' ; label_info='USB1-DP'  ;   echo_label_analog
pcbpin='P1_12' ; ball='A19' ; default_mode='1' ; cp_default='spi'  ;  pcbpinA='P1_12A'; find_ball
pcbpin='P1_12A' ; ball='AE18' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P1_12' ; find_ball
pcbpin='P1_13' ; ball='N20' ; label_pin='system' ; label_info='USB1-ID'  ;   echo_label_analog
pcbpin='P1_14' ; label_pin='power' ; label_info='VOUT-3_3V'  ;   echo_label
pcbpin='P1_15' ; label_pin='gnd' ; label_info='GND'  ;   echo_label
pcbpin='P1_16' ; label_pin='gnd' ; label_info='GND'  ;   echo_label
pcbpin='P1_17' ; label_pin='power' ; label_info='VREFN'  ;   echo_label_analog
pcbpin='P1_18' ; label_pin='power' ; label_info='VREFP'  ;   echo_label_analog
pcbpin='P1_19' ; ball='AD22' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P1_20' ; ball='Y24' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P1_21' ; ball='AE22' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P1_22' ; label_pin='gnd' ; label_info='GND'  ;   echo_label
pcbpin='P1_23' ; ball='AC21' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P1_24' ; label_pin='power' ; label_info='VOUT-5V'  ;   echo_label
pcbpin='P1_25' ; ball='AB20' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P1_26' ; ball='K24' ; default_mode='1' ; cp_default='i2c'  ;  pcbpinA='P1_26A'; find_ball
pcbpin='P1_26A' ; ball='D6' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P1_26' ; find_ball
pcbpin='P1_27' ; ball='AE23' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P1_28' ; ball='K22' ; default_mode='1' ; cp_default='i2c'  ;  pcbpinA='P1_28A'; find_ball
pcbpin='P1_28A' ; ball='B3' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P1_28' ; find_ball
pcbpin='P1_29' ; ball='Y20' ; default_mode='3' ; cp_default='pruin'  ;   find_ball
pcbpin='P1_30' ; ball='E14' ; default_mode='0' ; cp_default='uart'  ;   find_ball
pcbpin='P1_31' ; ball='Y22' ; default_mode='3' ; cp_default='pruin'  ;   find_ball
pcbpin='P1_32' ; ball='D14' ; default_mode='0' ; cp_default='uart'  ;   find_ball

pcbpin='P1_33A' ; ball='AA23' ; default_mode='6' ; cp_default='pruin'  ;  pcbpinA='P1_33'; find_ball
pcbpin='P1_33' ; ball='A17' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P1_33A'; find_ball

pcbpin='P1_34' ; ball='AD23' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P1_35' ; ball='AE21' ; default_mode='4' ; cp_default='pruin'  ;   find_ball

pcbpin='P1_36' ; ball='V20' ; default_mode='1' ; cp_default='disable'  ;  pcbpinA='P1_36A'; find_ball
pcbpin='P1_36A' ; ball='B17' ; default_mode='8' ; cp_default='pwm'  ;  pcbpinA='P1_36' ; find_ball

msg="" ; echo_both

msg="	/************************/" ; echo_both
msg="	/* P2 Header */" ; echo_both
msg="	/************************/" ; echo_both
msg="" ; echo_both

pcbpin='P2_01' ; ball='B20' ; default_mode='2' ; cp_default='pwm'  ;  pcbpinA='P2_01A'; find_ball
pcbpin='P2_01A' ; ball='AD24' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_01' ; find_ball

pcbpin='P2_02' ; ball='U22' ; default_mode='7' ; cp_default='gpio'  ;   find_ball

pcbpin='P2_03A' ; ball='B18' ; default_mode='7' ; cp_default='gpio'  ;  pcbpinA='P2_03' ; find_ball
pcbpin='P2_03' ; ball='AB22' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_03A'; find_ball

pcbpin='P2_04' ; ball='V24' ; default_mode='7' ; cp_default='gpio'  ;   find_ball

pcbpin='P2_05' ; ball='C15' ; default_mode='1' ; cp_default='uart'  ;  pcbpinA='P2_05A'; find_ball
pcbpin='P2_05A' ; ball='B5' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_05' ; find_ball

pcbpin='P2_06' ; ball='W25' ; default_mode='7' ; cp_default='gpio'  ;   find_ball

pcbpin='P2_07' ; ball='E15' ; default_mode='1' ; cp_default='uart'  ;  pcbpinA='P2_07A'; find_ball
pcbpin='P2_07A' ; ball='A5' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_07' ; find_ball

pcbpin='P2_08' ; ball='W24' ; default_mode='7' ; cp_default='gpio'  ;   find_ball

pcbpin='P2_09' ; ball='A15' ; default_mode='2' ; cp_default='i2c'  ;  pcbpinA='P2_09A'; find_ball
pcbpin='P2_09A' ; ball='D4' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_09' ; find_ball
pcbpin='P2_10' ; ball='AD21' ; default_mode='7' ; cp_default='gpio'  ;   find_ball

pcbpin='P2_11' ; ball='B15' ; default_mode='2' ; cp_default='i2c'  ;  pcbpinA='P2_11A'; find_ball
pcbpin='P2_11A' ; ball='E5' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_11' ; find_ball

pcbpin='P2_12' ; label_pin='system' ; label_info='POWER_BUTTON'  ;   echo_label
pcbpin='P2_13' ; label_pin='power' ; label_info='VOUT-5V'  ;   echo_label
pcbpin='P2_14' ; label_pin='power' ; label_info='BAT-VIN'  ;   echo_label
pcbpin='P2_15' ; label_pin='gnd' ; label_info='GND'  ;   echo_label
pcbpin='P2_16' ; label_pin='power' ; label_info='BAT-TEMP'  ;   echo_label
pcbpin='P2_17' ; ball='AC24' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_18' ; ball='V21' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_19' ; ball='AC20' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_20' ; ball='Y25' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_21' ; label_pin='gnd' ; label_info='GND'  ;   echo_label
pcbpin='P2_22' ; ball='AC25' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_23' ; label_pin='power' ; label_info='VOUT-3_3V'  ;   echo_label
pcbpin='P2_24' ; ball='Y23' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_25' ; ball='B14' ; default_mode='0' ; cp_default='spi'  ;   find_ball
pcbpin='P2_26' ; label_pin='system' ; label_info='RESET#'  ;   echo_label
pcbpin='P2_27' ; ball='B13' ; default_mode='0' ; cp_default='spi'  ;   find_ball
pcbpin='P2_28' ; ball='AB24' ; default_mode='6' ; cp_default='pruin'  ;   find_ball

pcbpin='P2_29' ; ball='A14' ; default_mode='0' ; cp_default='spi_sclk'  ;  pcbpinA='P2_29A'; find_ball
pcbpin='P2_29A' ; ball='M22' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_29' ; find_ball

pcbpin='P2_30' ; ball='AA24' ; default_mode='6' ; cp_default='pruin'  ;   find_ball
pcbpin='P2_31' ; ball='A13' ; default_mode='0' ; cp_default='spi_cs'  ;  pcbpinA='P2_31A'; find_ball
pcbpin='P2_31A' ; ball='AA18' ; default_mode='7' ; cp_default='disable'  ;  pcbpinA='P2_31' ; find_ball
pcbpin='P2_32' ; ball='AB25' ; default_mode='6' ; cp_default='pruin'  ;   find_ball
pcbpin='P2_33' ; ball='AA25' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_34' ; ball='AA21' ; default_mode='6' ; cp_default='pruin'  ;   find_ball
pcbpin='P2_35' ; ball='W21' ; default_mode='7' ; cp_default='gpio'  ;   find_ball
pcbpin='P2_36' ; ball='C13' ; default_mode='7' ; cp_default='gpio'  ;   find_ball

echo "};" >> ${file}.dts

cat ${file}-mcu.dts >> ${file}.dts

echo "};" >> ${file}.dts

echo "/ {" >> ${file}.dts

cat ${file}-pinmux.dts >> ${file}.dts

capeUniversal=0

if [ ${capeUniversal} -eq 1 ]; then

echo "	cape-universal {" >> ${file}.dts
echo "		compatible = \"gpio-of-helper\";" >> ${file}.dts
echo "		status = \"okay\";" >> ${file}.dts
echo "		pinctrl-names = \"default\";" >> ${file}.dts
echo "		pinctrl-0 = <>;" >> ${file}.dts

cat ${file}-gpio.dts >> ${file}.dts

echo "	};" >> ${file}.dts
fi

echo "};" >> ${file}.dts


echo "
///

&main_uart2 {
	status = \"okay\";
};

&main_uart3 {
	status = \"okay\";
};

&main_uart4 {
	status = \"okay\";
};

&main_uart5 {
	status = \"okay\";
};

&main_i2c3 {
	clock-frequency = <400000>;
	status = \"okay\";
};

&main_spi2 {
	status = \"okay\";
};

&epwm0 {
	status = \"okay\";
};

&epwm1 {
	status = \"okay\";
};

&eqep0 {
	status = \"okay\";
};

&eqep1 {
	status = \"okay\";
};

&eqep2 {
	status = \"okay\";
};

///
" >> ${file}.dts


rm -rf ${file}-pinmux.dts || true
rm -rf ${file}-gpio.dts || true

cat ${file}-a-bone-pins.h >> ${file}-bone-pins.h
cat ${file}-b-bone-pins.h >> ${file}-bone-pins.h

rm -rf ${file}-a-bone-pins.h || true
rm -rf ${file}-b-bone-pins.h || true
