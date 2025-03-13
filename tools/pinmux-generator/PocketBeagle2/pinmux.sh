#!/bin/bash

#cat AM62x.json | jq '.devicePins'
#cat AM62x.json | jq '.useCases'
#cat AM62x.json | jq '.packages .ID_0 .packagePin[202] .devicePinID'

echo_both () {
#	echo "$msg"
	echo "$msg" >> ${file}.dts
	echo "$msg" >> ${file}-pinmux.dts
}

echo_label () {
	msg="	/* ${pcbpin}                ${label_info} */" ; echo_both ; msg="" ; echo_both
	echo "${pcbpin}_PIN=\"${label_pin}\"" >>${file}_config-pin.txt
	echo "${pcbpin}_INFO=\"${label_info}\"" >>${file}_config-pin.txt
	echo "${pcbpin}_CAPE=\"\"" >>${file}_config-pin.txt
	echo "" >>${file}_config-pin.txt
}

echo_label_analog () {
	msg="	/* ${pcbpin} (ALW ball ${ball})  ${label_info} */" ; echo_both ; msg="" ; echo_both
	echo "${pcbpin}_PIN=\"${label_pin}\"" >>${file}_config-pin.txt
	echo "${pcbpin}_INFO=\"${label_info}\"" >>${file}_config-pin.txt
	echo "${pcbpin}_CAPE=\"\"" >>${file}_config-pin.txt
	echo "" >>${file}_config-pin.txt
}

echo_pinmux () {
	if [ "x${cp_default}" = "x" ] ; then
		echo "	/* ${pcbpin} (ALW ball ${found_ball}) */" >> ${file}-pinmux.dts
	else
		echo "	/* ${pcbpin} (ALW ball ${found_ball}) ${cp_default} */" >> ${file}-pinmux.dts
		unset default_name
	fi
	echo "	${pcbpin}_pinmux {" >> ${file}-pinmux.dts
	echo "		compatible = \"bone-pinmux-helper\";" >> ${file}-pinmux.dts
	echo "		status = \"okay\";" >> ${file}-pinmux.dts
	list="\"default\", \"gpio\", \"gpio_pu\", \"gpio_pd\""
	cp_pinmux="default gpio gpio_pu gpio_pd"
	if [ "x${cp_info_default}" = "x" ] ; then
		cp_info="${gpio_name} default ${gpio_name} ${gpio_name} ${gpio_name}"
	else
		cp_info="${cp_info_default} default ${gpio_name} ${gpio_name} ${gpio_name}"
		unset cp_info_default
	fi
	if [ "x${got_spi_pin}" = "xenable" ] ; then
		list="${list}, \"spi\""
		cp_pinmux="${cp_pinmux} spi"
		cp_info="${cp_info} ${spi_name}"
	fi
	if [ "x${got_spi_cs_pin}" = "xenable" ] ; then
		list="${list}, \"spi_cs\""
		cp_pinmux="${cp_pinmux} spi_cs"
		cp_info="${cp_info} ${spi_cs_name}"
	fi
	if [ "x${got_spi_sclk_pin}" = "xenable" ] ; then
		list="${list}, \"spi_sclk\""
		cp_pinmux="${cp_pinmux} spi_sclk"
		cp_info="${cp_info} ${spi_sclk_name}"
	fi
	if [ "x${got_uart_pin}" = "xenable" ] ; then
		list="${list}, \"uart\""
		cp_pinmux="${cp_pinmux} uart"
		cp_info="${cp_info} ${uart_name}"
	fi
	if [ "x${got_can_pin}" = "xenable" ] ; then
		list="${list}, \"can\""
		cp_pinmux="${cp_pinmux} can"
		cp_info="${cp_info} ${can_name}"
	fi
	if [ "x${got_i2c_pin}" = "xenable" ] ; then
		list="${list}, \"i2c\""
		cp_pinmux="${cp_pinmux} i2c"
		cp_info="${cp_info} ${i2c_name}"
	fi
	if [ "x${got_eqep_pin}" = "xenable" ] ; then
		list="${list}, \"eqep\""
		cp_pinmux="${cp_pinmux} eqep"
		cp_info="${cp_info} ${eqep_name}"
	fi
	if [ "x${got_pwm_pin}" = "xenable" ] ; then
		list="${list}, \"pwm\""
		cp_pinmux="${cp_pinmux} pwm"
		cp_info="${cp_info} ${pwm_name}"
	fi
	if [ "x${got_pwm2_pin}" = "xenable" ] ; then
		list="${list}, \"pwm2\""
		cp_pinmux="${cp_pinmux} pwm2"
		cp_info="${cp_info} ${pwm2_name}"
	fi
	if [ "x${got_pru_uart_pin}" = "xenable" ] ; then
		list="${list}, \"pru_uart\""
		cp_pinmux="${cp_pinmux} pru_uart"
		cp_info="${cp_info} pru_uart"
	fi
	if [ "x${got_timer_pin}" = "xenable" ] ; then
		list="${list}, \"timer\""
		cp_pinmux="${cp_pinmux} timer"
		cp_info="${cp_info} ${timer_name}"
	fi
	if [ "x${got_pru_ecap_pin}" = "xenable" ] ; then
		list="${list}, \"pru_ecap_pwm\""
		cp_pinmux="${cp_pinmux} pru_ecap_pwm"
		cp_info="${cp_info} pru_ecap_pwm"
	fi
	if [ "x${got_pru0out_pin}" = "xenable" ] ; then
		list="${list}, \"pruout\""
		cp_pinmux="${cp_pinmux} pru0out"
		cp_info="${cp_info} ${pruout_name}"
	fi
	if [ "x${got_pru0in_pin}" = "xenable" ] ; then
		list="${list}, \"pruin\""
		cp_pinmux="${cp_pinmux} pru0in"
		cp_info="${cp_info} ${pruin_name}"
	fi
	if [ "x${got_pru1out_pin}" = "xenable" ] ; then
		list="${list}, \"pru1out\""
		cp_pinmux="${cp_pinmux} pru1out"
		cp_info="${cp_info} ${pruout_name}"
	fi
	if [ "x${got_pru1in_pin}" = "xenable" ] ; then
		list="${list}, \"pru1in\""
		cp_pinmux="${cp_pinmux} pru1in"
		cp_info="${cp_info} ${pruin_name}"
	fi
	if [ "x${got_mcu_uart_pin}" = "xenable" ] ; then
		list="${list}, \"mcu_uart\""
		cp_pinmux="${cp_pinmux} mcu_uart"
		cp_info="${cp_info} mcu_uart"
	fi
	if [ "x${got_mcu_timer_pin}" = "xenable" ] ; then
		list="${list}, \"mcu_timer\""
		cp_pinmux="${cp_pinmux} mcu_timer"
		cp_info="${cp_info} ${timer_name}"
	fi

	echo "${pcbpin}_PRU=\"${cp_pru_gpio_number}\"" >> ${file}_config-pin.txt
	echo "${pcbpin}_GPIO=\"${cp_gpio_number}\"" >> ${file}_config-pin.txt

	if [ "x${cp_default}" = "x" ] ; then
		echo "${pcbpin}_PIN=\"gpio\"" >> ${file}_config-pin.txt
	else
		echo "${pcbpin}_PIN=\"${cp_default}\"" >> ${file}_config-pin.txt
		unset cp_default
	fi

	pinctrlADisable=""
	if [ "x${pcbpinA}" != "x" ]; then
		pinctrlADisable="&${pcbpinA}_disable_pin "
	fi

	echo "${pcbpin}_PINMUX=\"${cp_pinmux}\"" >> ${file}_config-pin.txt
	echo "${pcbpin}_INFO=\"${cp_info}\"" >> ${file}_config-pin.txt
	echo "${pcbpin}_CAPE=\"\"" >> ${file}_config-pin.txt
	echo "" >> ${file}_config-pin.txt

	echo "		pinctrl-names = ${list};" >> ${file}-pinmux.dts
	echo "		pinctrl-0 = <${pinctrlADisable}&${pcbpin}_default_pin>;" >> ${file}-pinmux.dts
	echo "		pinctrl-1 = <${pinctrlADisable}&${pcbpin}_gpio_pin>;" >> ${file}-pinmux.dts
	echo "		pinctrl-2 = <${pinctrlADisable}&${pcbpin}_gpio_pu_pin>;" >> ${file}-pinmux.dts
	echo "		pinctrl-3 = <${pinctrlADisable}&${pcbpin}_gpio_pd_pin>;" >> ${file}-pinmux.dts
	index=4
	if [ "x${got_spi_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_spi_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_spi_cs_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_spi_cs_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_spi_sclk_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_spi_sclk_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_uart_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_uart_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_can_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_can_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_i2c_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_i2c_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_eqep_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_eqep_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pwm_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pwm_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pwm2_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pwm2_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pru_uart_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pru_uart_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pru_ecap_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pru_ecap_pwm_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_timer_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_timer_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pru0out_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pru0out_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pru0in_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pru0in_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pru1out_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pru1out_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_pru1in_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_pru1in_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_mcu_uart_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_mcu_uart_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi
	if [ "x${got_mcu_timer_pin}" = "xenable" ] ; then
		echo "		pinctrl-${index} = <${pinctrlADisable}&${pcbpin}_mcu_timer_pin>;" >> ${file}-pinmux.dts
		index=$((index + 1))
	fi

	echo "	};" >> ${file}-pinmux.dts
	echo "" >> ${file}-pinmux.dts
}

echo_gpio () {

	if [ "x$(echo $gpio_pinmux | grep mcu)" != "x" ]; then

		#echo "#define gpio_${pcbpin} &${gpio_pinmux}" >> ${file}-a-bone-pins.h
		echo "#define ${pcbpin}(settings,mode)	AM62X_MCU_IOPAD(${cro}, settings, mode)  /* ${found_ball}: ${PinID} */" >> ${file}-b-bone-pins.h

		return;
	fi

	echo "		${pcbpin} {" >> ${file}-gpio.dts
	echo "			gpio-name = \"${pcbpin}\";" >> ${file}-gpio.dts
	echo "			gpio = <&main_${gpio_pinmux} 0>;" >> ${file}-gpio.dts
	echo "			input;" >> ${file}-gpio.dts
	echo "			dir-changeable;" >> ${file}-gpio.dts
	echo "		};" >> ${file}-gpio.dts
	echo "">> ${file}-gpio.dts

	echo "#define gpio_${pcbpin} &${gpio_pinmux}" >> ${file}-a-bone-pins.h
	echo "#define ${pcbpin}(settings,mode)	AM62X_IOPAD(${cro}, settings, mode)  /* ${found_ball}: ${PinID} */" >> ${file}-b-bone-pins.h

}

get_json_pkg () {
	###Offline: https://dev.ti.com/sysconfig/deviceData/AM62x/AM62x.json

	wget -c https://dev.ti.com/sysconfig/deviceData/AM62x/AM62x.json

	exit
}

get_name_mode () {
	#cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .signalName' | sed 's/\"//g' | sed 's/\[/_/g' | sed 's/\]//g' || true

	name=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .signalName' | sed 's/\"//g' | sed 's/\[/_/g' | sed 's/\]//g' | awk '{print tolower($0)}' || true)
	mode=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .mode' | sed 's/\"//g' | awk '{print tolower($0)}' || true)
	ioDir=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .ioDir' | sed 's/\"//g' || true)
}

find_ball () {
	echo "##################"
	echo "${pcbpin}"
	#Use "ball" to get devicePinID & powerDomainID

	#cat AM62x.json | jq '.packages .ID_1 .packagePin[0]'
	#{
	#  "devicePinID": "ID_1690",
	#  "ball": "R13",
	#  "powerDomainID": "ID_1691"
	#}


		compare=$(cat AM62x.json | jq ".packages.ID_1.packagePin[] | select(.ball==\"${ball}\").ball" | sed 's/\"//g' || true)
		if [ "x${compare}" = "x${ball}" ] ; then
			#echo "debug-${ball}-----------------------------------------"
			#cat AM62x.json | jq '.packages .ID_1 .packagePin['$number']'
			#echo "debug-${ball}-----------------------------------------"
			found_devicePinID=$(cat AM62x.json | jq ".packages.ID_1.packagePin[] | select(.ball==\"${ball}\").devicePinID" | sed 's/\"//g' || true)
			found_ball=$(cat AM62x.json | jq ".packages.ID_1.packagePin[] | select(.ball==\"${ball}\").ball" | sed 's/\"//g' || true)
			found_powerDomainID=$(cat AM62x.json | jq ".packages.ID_1.packagePin[] | select(.ball==\"${ball}\").powerDomainID" | sed 's/\"//g' || true)
			echo "devicePinID=${found_devicePinID},ball=${found_ball},powerDomainID=${found_powerDomainID}"
		fi

	#Using devicePinID find name

	#cat AM62x.json | jq '.devicePins .ID_1985'
	#{
	#  "type": "DevicePin",
	#  "name": "lcd_hsync",
	#  "description": "",
	#  "devicePinType": "Default",
	#  "id": "ID_1985"
	#}

	#echo "debug-${ball}-----------------------------------------"
	#cat AM62x.json | jq '.devicePins .'${found_devicePinID}''
	#echo "debug-${ball}-----------------------------------------"
	PinID=$(cat AM62x.json | jq '.devicePins .'${found_devicePinID}' .name' | sed 's/\"//g' || true)
	echo "name=${PinID}"

	

	if [ "$(echo ${PinID} | grep "MCU_")" != "" ]; then
		fileDTS="${file}-mcu.dts"
		
	else
		fileDTS="${file}.dts"
	fi


	

	#Using devicePinID find controlRegisterOffset

	#cat AM62x.json | jq '.pinCommonInfos .ID_1985'
	#{
	#  "type": "PinCommonInfo",
	#  "devicePinID": "ID_1985",
	#  "controlRegisterOffset": "0x08e4",
	#  "pupdStateDuringHHV": "OFF",
	#  "pupdStateAfterHHV": "PD",

	#echo "debug-${ball}-----------------------------------------"
	#cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}''
	#echo "debug-${ball}-----------------------------------------"
	cro=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .controlRegisterOffset' | sed 's/\"//g' || true)
	echo "controlRegisterOffset=${cro}"

	unset pupdStateDuringHHV
	pupdStateDuringHHV=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pupdStateDuringHHV' | sed 's/\"//g' || true)
	echo "pupdStateDuringHHV=${pupdStateDuringHHV}"

	unset pupdStateAfterHHV
	pupdStateAfterHHV=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pupdStateAfterHHV' | sed 's/\"//g' || true)
	echo "pupdStateAfterHHV=${pupdStateAfterHHV}"

	#  "pinModeInfo": [
	#    {
	#      "peripheralPinID": "ID_1986",
	#      "mode": "0",
	#      "interfaceName": "LCDC",
	#      "signalName": "lcd_hsync",
	#      "ioDir": "O"
	#    },
	#    {
	#      "peripheralPinID": "ID_1775",
	#      "mode": "1",
	#      "interfaceName": "GPMC",
	#      "signalName": "gpmc_a9",
	#      "ioDir": "O"
	#    },
	#    {
	#      "peripheralPinID": "ID_1715",
	#      "mode": "2",
	#      "interfaceName": "GPMC",
	#      "signalName": "gpmc_a2",
	#      "ioDir": "O"
	#    },
	#    {
	#      "peripheralPinID": "ID_1987",
	#      "mode": "3",
	#      "interfaceName": "ECAT_PRUSS1",
	#      "signalName": "pr1_edio_data_in3",
	#      "ioDir": "I"
	#    },
	#    {
	#      "peripheralPinID": "ID_1988",
	#      "mode": "4",
	#      "interfaceName": "ECAT_PRUSS1",
	#      "signalName": "pr1_edio_data_out3",
	#      "ioDir": "O"
	#    },
	#    {
	#      "peripheralPinID": "ID_1989",
	#      "mode": "5",
	#      "interfaceName": "PRU1_PRUSS1",
	#      "signalName": "pr1_pru1_pru_r30[9]",
	#      "ioDir": "O"
	#    },
	#    {
	#      "peripheralPinID": "ID_1990",
	#      "mode": "6",
	#      "interfaceName": "PRU1_PRUSS1",
	#      "signalName": "pr1_pru1_pru_r31[9]",
	#      "ioDir": "I"
	#    },
	#    {
	#      "peripheralPinID": "ID_1991",
	#      "mode": "7",
	#      "interfaceName": "GPIO2",
	#      "signalName": "gpio2[23]",
	#      "ioDir": "IO"
	#    }
	#  ]
	#}


	length=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo | length' )

	for number in {0..15}
	do
		cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .interfaceName'
		compare=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .interfaceName' | sed 's/\"//g' || true)
		get_name_mode
		echo ${pcbpin}:${ball}:${name}:${mode}:${ioDir}:${number}

#		if [ ! "x${name}" = "xnull" ] ; then
#			echo "/* ${pcbpin}:${ball}:${name}:${mode}:${ioDir} */" >> ${fileDTS}
#		fi

		if [ "x${mode}" = "x${default_mode}" ] ; then
			echo default_mode=index=${number}   ${name}    ${cp_default} 
			default_index=${number}
		fi

		if [ "x${mode}" = "x${gpio_mode}" ] ; then
			echo gpio_mode=index=${number}
			gpio_index=${number}
		fi

		if [ $number -ge $(($length-1)) ]; then
			break
		fi
	done

	unset cp_info_default
	number=${default_index}
	get_name_mode
	echo ${pcbpin}:${ball}:${name}:${mode}:${ioDir}:${number}

	case "${cp_default}" in
	pruin)
		pruin_tmp=$(echo ${name} | sed 's/pr1_//g' | sed 's/pru_r31_/in/g')
		name=${pruin_tmp}
		;;
	esac

	if [ ! "x${use_name}" = "x" ] ; then
		echo "	/* ${pcbpin} (ALW ball ${found_ball}) ${PinID} (${use_name}) */" >> ${fileDTS}
		unset use_name
	else
		echo "	/* ${pcbpin} (ALW ball ${found_ball}) ${PinID} (${name}) */" >> ${fileDTS}
	fi
	cp_info_default=${name}

	echo cp_default=${cp_default}
	case "${cp_default}" in
	gpio|pruin)
		pinsetting="PIN_INPUT"
		;;
	pwm|pwm2)
		pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
		;;
	i2c)
		pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
		;;
	uart|i2c|spi|spi_cs|spi_sclk)
		pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
		;;
	eqep)
		pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
		;;
	emmc|hdmi|audio)
		pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
		;;
	disable)
		pinsetting="PIN_DISABLE"
		
		;;
	*)
		if [ ! "x$cp_default" = "x" ] ; then
			exit 2
		fi
		case "${pupdStateAfterHHV}" in
		PU)
			pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
		;;
		PD)
			pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
		;;
		*)
			echo "pupdStateAfterHHV was not defined [${pupdStateAfterHHV}]"
			pinsetting="PIN_INPUT"
			#exit 2 # //todo check
		;;

		esac
		;;
	esac

	pina_disable=""
	pina_disable_def=""
	if [ "x$pcbpinA" != "x" ]; then
		#pina_disable="${pcbpinA}( PIN_DISABLE , 7)"
 		
		#if [ "$pinsetting" != "PIN_DISABLE" ]; then
		#	pina_disable_def="${pcbpinA}( PIN_DISABLE , 7)"
		#fi

		echo "	${pcbpin}_disable_pin: pinmux_${pcbpin}_disable_pin { pinctrl-single,pins = <" >> ${fileDTS}
		echo "		${pcbpin}( PIN_DISABLE , 7) >; };	/* ${PinID}.${name} */" >> ${fileDTS}
		#unset pcbpinA
	fi

	echo "	${pcbpin}_default_pin: pinmux_${pcbpin}_default_pin { pinctrl-single,pins = <" >> ${fileDTS}
	echo "		${pcbpin}( ${pinsetting} , ${mode}) ${pina_disable_def} >; };	/* ${PinID}.${name} */" >> ${fileDTS}
#	echo "" >> ${fileDTS}
#	echo "	BONE_PIN(${pcbpin}, default, ${pcbpin}(${pinsetting} | ${mode}))" >> ${fileDTS}

	number=${gpio_index}
	get_name_mode

	echo "	${pcbpin}_gpio_pin: pinmux_${pcbpin}_gpio_pin { pinctrl-single,pins = <" >> ${fileDTS}
	echo "		${pcbpin}( PIN_OUTPUT | INPUT_EN , ${mode}) ${pina_disable} >; };			/* ${PinID}.${name} */" >> ${fileDTS}
#	echo "" >> ${fileDTS}
#	echo "	BONE_PIN(${pcbpin}, gpio, ${pcbpin}(PIN_OUTPUT | INPUT_EN | ${mode}))" >> ${fileDTS}

	echo "	${pcbpin}_gpio_pu_pin: pinmux_${pcbpin}_gpio_pu_pin { pinctrl-single,pins = <" >> ${fileDTS}
	echo "		${pcbpin}( PIN_OUTPUT_PULLUP | INPUT_EN , ${mode}) ${pina_disable} >; };		/* ${PinID}.${name} */" >> ${fileDTS}
#	echo "" >> ${fileDTS}
#	echo "	BONE_PIN(${pcbpin}, gpio_pu, ${pcbpin}(PIN_OUTPUT_PULLUP | INPUT_EN | ${mode}))" >> ${fileDTS}

	echo "	${pcbpin}_gpio_pd_pin: pinmux_${pcbpin}_gpio_pd_pin { pinctrl-single,pins = <" >> ${fileDTS}
	echo "		${pcbpin}( PIN_OUTPUT_PULLDOWN | INPUT_EN , ${mode}) ${pina_disable} >; };	/* ${PinID}.${name} */" >> ${fileDTS}
#	echo "" >> ${fileDTS}
#	echo "	BONE_PIN(${pcbpin}, gpio_pd, ${pcbpin}(PIN_OUTPUT_PULLDOWN | INPUT_EN | ${mode}))" >> ${fileDTS}



	echo ${name}

	#// Todo check 
	gpio_mul=$(echo ${name} | awk -F'_' '{print $1}' | awk -F'gpio' '{print $2}' || true)
	gpio_add=$(echo ${name} | awk -F'_' '{print $2}' || true)
	cp_gpio_number=$(echo "${gpio_mul} * 32" | bc)
	cp_gpio_number=$(echo "${cp_gpio_number} + ${gpio_add}" | bc)
	cp_pru_gpio_number=$(echo "${cp_gpio_number} + 32" | bc)



	gpio_name=${name}
	gpio_pinmux=$(echo ${gpio_name} | sed 's/_/ /g')

	unset got_can_pin
	unset got_eqep_pin
	unset got_pwm_pin
	unset got_pwm2_pin
	unset got_i2c_pin
	unset got_pru_ecap_pin
	unset got_pru_uart_pin
	unset got_pru0out_pin
	unset got_pru0in_pin
	unset got_pru1out_pin
	unset got_pru1in_pin
	unset got_spi_pin
	unset got_spi_cs_pin
	unset got_spi_sclk_pin
	unset got_timer_pin
	unset got_uart_pin
	unset got_mcu_spi_pin
	unset got_mcu_spi_cs_pin
	unset got_mcu_spi_sclk_pin
	unset got_mcu_timer_pin
	unset got_mcu_uart_pin


	
	for number in {0..15}
	do
		cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .interfaceName'
		compare=$(cat AM62x.json | jq '.pinCommonInfos .'${found_devicePinID}' .pinModeInfo['$number'] .interfaceName' | sed 's/\"//g' || true)
		get_name_mode
		if [ ! "x${name}" = "xnull" ] ; then
			echo ${name}

			unset valid_pin_mode

			tabs=1
			case "${name}" in 
			mcan*_rx)
				can_name=${name}
				valid_pin_mode="can"
				pinsetting="PIN_INPUT_PULLUP"
				got_can_pin="enable"
				tabs=3
				;;
			mcan*_tx)
				can_name=${name}
				valid_pin_mode="can"
				pinsetting="PIN_OUTPUT_PULLUP"
				got_can_pin="enable"
				tabs=3
				;;
			mcu_mcan*_rx)
				can_name=${name}
				valid_pin_mode="can"
				pinsetting="PIN_INPUT_PULLUP"
				got_can_pin="enable"
				tabs=3
				;;
			mcu_mcan*_tx)
				can_name=${name}
				valid_pin_mode="can"
				pinsetting="PIN_OUTPUT_PULLUP"
				got_can_pin="enable"
				tabs=3
				;;
			eqep*)
				valid_pin_mode="eqep"
				eqep_name=${name}
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_eqep_pin="enable"
				tabs=2
				;;
			ehrpwm*_a|ehrpwm*_b|ecap0_in_pwm0_out)
				valid_pin_mode="pwm"
				pwm_name=${name}
				pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
				got_pwm_pin="enable"
				;;
			ecap*_in_apwm_out)
				#ignore PocketBeagle...
				if [ ! "x${file}" = "xPocketBeagle" ] ; then
				if [ ! "x${file}" = "xBeagleBone_Blue" ] ; then
					valid_pin_mode="pwm2"
					pwm2_name=${name}
					pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
					got_pwm2_pin="enable"
				fi
				fi
				;;
			i2c*_sda|i2c*_scl)
				valid_pin_mode="i2c"
				i2c_name=${name}
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_i2c_pin="enable"
				tabs=2
				;;
			pr1_ecap0*)
				valid_pin_mode="pru_ecap_pwm"
				pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
				got_pru_ecap_pin="enable"
				;;
			pr0_uart0*)
				valid_pin_mode="pru_uart"
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_pru_uart_pin="enable"
				tabs=2
				;;
			pr1_uart0*)
				valid_pin_mode="pru_uart"
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_pru_uart_pin="enable"
				tabs=2
				;;
			pr*_pru1_gpo*)				  #pr1_pru*_pru_r30*)
				valid_pin_mode="pru1out"
				pruout_name=$(echo ${name} | sed 's/pr1_//g' | sed 's/pru_r30_/out/g')
				name=${pruout_name}
				pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
				got_pru1out_pin="enable"
				;;
			pr*_pru1_gpi*)
				valid_pin_mode="pru1in"
				pruin_name=$(echo ${name} | sed 's/pr1_//g' | sed 's/pru_r31_/in/g')
				name=${pruin_name}
				pinsetting="PIN_INPUT"
				got_pru1in_pin="enable"
				tabs=4
				;;
			pr*_pru0_gpo*)				  #pr1_pru*_pru_r30*)
				valid_pin_mode="pru0out"
				pruout_name=$(echo ${name} | sed 's/pr1_//g' | sed 's/pru_r30_/out/g')
				name=${pruout_name}
				pinsetting="PIN_OUTPUT_PULLDOWN | INPUT_EN"
				got_pru0out_pin="enable"
				;;
			pr*_pru0_gpi*)
				valid_pin_mode="pru0in"
				pruin_name=$(echo ${name} | sed 's/pr1_//g' | sed 's/pru_r31_/in/g')
				name=${pruin_name}
				pinsetting="PIN_INPUT"
				got_pru0in_pin="enable"
				tabs=4
				;;
			spi0_d0|spi1_d0)
				valid_pin_mode="spi"
				spi_name=${name}
				pinsetting="PIN_INPUT_PULLUP"
				got_spi_pin="enable"
				tabs=3
				;;
			spi0_d1|spi1_d1)
				valid_pin_mode="spi"
				spi_name=${name}
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_spi_pin="enable"
				tabs=2
				;;
			spi0_cs*|spi1_cs*)
				valid_pin_mode="spi_cs"
				spi_cs_name=${name}
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_spi_cs_pin="enable"
				tabs=2
				;;
			spi*_sclk)
				# See: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf page 4855
				# (1) This output signal is also used as a re-timing input. The associated CONF_<module>_<pin>_RXACTIVE bit for the output clock
				# must be set to 1 to enable the clock input back to the module.
				valid_pin_mode="spi_sclk"
				spi_sclk_name=${name}
				pinsetting="PIN_INPUT_PULLUP"
				got_spi_sclk_pin="enable"
				tabs=3
				;;
			timer*)
				if [ "x${disable_timer}" = "x" ] ; then
					valid_pin_mode="timer"
					timer_name=${name}
					pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
					got_timer_pin="enable"
					tabs=2
				fi
				;;
			uart*_rxd|uart*_txd)
				valid_pin_mode="uart"
				uart_name=${name}
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_uart_pin="enable"
				tabs=2
				;;
			mcu_uart*_rxd|mcu_uart*_txd)
				valid_pin_mode="mcu_uart"
				uart_name=${name}
				pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
				got_mcu_uart_pin="enable"
				tabs=2
				;;
			mcu_timer*)
				if [ "x${disable_timer}" = "x" ] ; then
					valid_pin_mode="mcu_timer"
					timer_name=${name}
					pinsetting="PIN_OUTPUT_PULLUP | INPUT_EN"
					got_mcu_timer_pin="enable"
					tabs=2
				fi
				;;
			esac

			if [ ! "x${valid_pin_mode}" = "x" ] ; then
				echo "	${pcbpin}_${valid_pin_mode}_pin: pinmux_${pcbpin}_${valid_pin_mode}_pin { pinctrl-single,pins = <" >> ${fileDTS}
				echo "		${pcbpin}( ${pinsetting} , ${mode}) ${pina_disable} >; };	/* ${PinID}.${name} */" >> ${fileDTS}
				#echo "	BONE_PIN(${pcbpin}, ${valid_pin_mode}, ${pcbpin}(${pinsetting} | ${mode}))" >> ${fileDTS}
			fi
		fi

		if [ $number -ge $(($length-1)) ]; then
			break
		fi
	done




echo "" >> ${fileDTS}
echo_pinmux
echo_gpio

#0x05 = 0000 0101
#0x26 = 0010 0110
#0x27 = 0010 0111
#0x2F = 0010 1111
#0x30 = 0011 0000
#0x32 = 0011 0010
#0x37 = 0011 0111

#0x05 : PIN_OUTPUT_PULLDOWN | 5
#0x24 : PIN_OUTPUT_PULLDOWN | INPUT_EN | 4
#0x26 : PIN_OUTPUT_PULLDOWN | INPUT_EN | 6
#0x27 : PIN_OUTPUT_PULLDOWN | INPUT_EN | 7
#0x2F : PIN_OUTPUT | INPUT_EN | 7
#0x30 : PIN_OUTPUT_PULLUP | INPUT_EN | 0
#0x32 : PIN_OUTPUT_PULLUP | INPUT_EN | 2
#0x37 : PIN_OUTPUT_PULLUP | INPUT_EN | 7

#			P9_17_default_pin: pinmux_P9_17_default_pin {
#				pinctrl-single,pins = <0x15c  0x37>; };	/* Mode 7, Pull-Up, RxActive */
#			P9_17_gpio_pin: pinmux_P9_17_gpio_pin {
#				pinctrl-single,pins = <0x15c  0x2F>; };	/* Mode 7, RxActive */
#			P9_17_gpio_pu_pin: pinmux_P9_17_gpio_pu_pin {
#				pinctrl-single,pins = <0x15c  0x37>; };	/* Mode 7, Pull-Up, RxActive */
#			P9_17_gpio_pd_pin: pinmux_P9_17_gpio_pd_pin {
#				pinctrl-single,pins = <0x15c  0x27>; };	/* Mode 7, Pull-Down, RxActive */
#			P9_17_spi_pin: pinmux_P9_17_spi_pin {
#				pinctrl-single,pins = <0x15c  0x30>; };	/* Mode 0, Pull-Up, RxActive */
#			P9_17_i2c_pin: pinmux_P9_17_i2c_pin {
#				pinctrl-single,pins = <0x15c  0x32>; };	/* Mode 2, Pull-Up, RxActive */
#			P9_17_pwm_pin: pinmux_P9_17_pwm_pin {
#				pinctrl-single,pins = <0x15c  0x33>; };	/* Mode 3, Pull-Up, RxActive */
#			P9_17_pru_uart_pin: pinmux_P9_17_pru_uart_pin {
#				pinctrl-single,pins = <0x15c  0x34>; };	/* Mode 4, Pull-Up, RxActive */

	echo "##################"
	unset pcbpinA
}

if [ ! -f AM62x.json ] ; then
	get_json_pkg
fi
