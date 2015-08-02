default[:ntp][:ip]                  	  = "0.0.0.0"
default[:ntp][:timezone]				  = "GMT"

#Windows 2008 default attributes
default[:ntp][:w2k8][:ip]                 = "0.0.0.0"
default[:ntp][:w2k8][:ActiveTimeBias]     = "4294967236"
default[:ntp][:w2k8][:Bias]               = "0"
default[:ntp][:w2k8][:DaylightBias]       = "4294967236"
default[:ntp][:w2k8][:DaylightName]       = "@tzres.dll,-261"
default[:ntp][:w2k8][:DaylightStart]      = "\x00\x00\x03\x00\x05\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00"
default[:ntp][:w2k8][:DynamicDaylight]    = "0"
default[:ntp][:w2k8][:StandardBias]       = "0"
default[:ntp][:w2k8][:StandardName]       = "@tzres.dll,-262"
default[:ntp][:w2k8][:StandardStart]      = "\x00\x00\x0a\x00\x05\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00"
default[:ntp][:w2k8][:TimeZoneKeyName]    = "GMT Standard Time"

#Windows 2003 default attributes
default[:ntp][:w2k3][:ActiveTimeBias]     = "0"
default[:ntp][:w2k3][:Bias]               = "0"
default[:ntp][:w2k3][:DaylightName]       = "GMT Daylight Time"
default[:ntp][:w2k3][:DaylightStart]      = "\x00\x00\x03\x00\x05\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00"
default[:ntp][:w2k3][:StandardName]       = "GMT Standard Time"
default[:ntp][:w2k3][:TimeZoneKeyName]    = "GMT Standard Time"
