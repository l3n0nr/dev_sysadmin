#!/usr/bin/env bash
#
## DESCRICAO
## 	Mata processo de pulseeffects travado e levanta outro automaticamente
#
# 
pulse()
{
	killall -9 pulseeffects 

	/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=pulseeffects com.github.wwmm.pulseeffects --gapplication-service &
}

main()
{
	pulse
}

main
