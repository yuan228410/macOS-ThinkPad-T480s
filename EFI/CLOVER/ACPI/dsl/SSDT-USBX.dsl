#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_USBX", 0x00000000)
{
#endif
	Device (_SB.USBX)
	{
		Name (_ADR, Zero)  // _ADR: Address
		Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
		{
			If (!Arg2)
			{
				Return (Buffer ()
				{
					0x03
				})
			}

			Return (Package ()
			{
				"kUSBSleepPortCurrentLimit", 
				2100, 
				"kUSBSleepPowerSupply", 
				2600, 
				"kUSBWakePortCurrentLimit", 
				2100, 
				"kUSBWakePowerSupply", 
				3200
			})
		}
	}
#ifndef NO_DEFINITIONBLOCK
}
#endif

