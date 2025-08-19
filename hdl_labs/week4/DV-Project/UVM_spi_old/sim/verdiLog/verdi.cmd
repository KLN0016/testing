wvCreateWindow
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/home/user16/work/klngan/hdl_labs/week4/DV-Project/UVM_spi/sim/spi_sim.fsdb}
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "510" "153" "900" "700"
verdiWindowResize -win $_Verdi_1 "510" "153" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {G1}
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/spi_tb"
debExit
