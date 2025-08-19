simSetSimulator "-vcssv" -exec "mux3to1_simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "mux3to1_simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "932" "27" "988" "1016"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBSimReset
srcTBStepNext
srcTBRunSim
schCreateWindow -delim "." -win $_nSchema1 -scope "mux3to1_tb"
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "mux3to1_tb:Init1:48:51:Init"
schPushViewIn -win $_nSchema3
srcSelect -win $_nTrace1 -range {48 51 1 3 1 1}
srcBackwardHistory -win $_nTrace1
srcHBSelect "mux3to1_tb.uut" -win $_nTrace1
schCreateWindow -delim "." -win $_nSchema1 -scope "mux3to1_tb.uut"
verdiSetActWin -win $_nSchema_4
schCreateWindow -delim "." -win $_nSchema1 -scope "mux3to1_tb.uut"
verdiSetActWin -win $_nSchema_5
schCloseWindow -win $_nSchema4
schCloseWindow -win $_nSchema5
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "mux3to1_tb:Init0:16:46:Init"
schPushViewIn -win $_nSchema3
srcSetScope "mux3to1_tb" -delim "." -win $_nTrace1
srcSelect -win $_nTrace1 -range {16 46 1 3 1 1}
debExit
