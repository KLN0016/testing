################################################################################
#This is an internally genertaed by SpyGlass for Message Tagging Support
################################################################################


use spyglass;
use SpyGlass;
use SpyGlass::Objects;
spyRebootMsgTagSupport();

spySetMsgTagCount(2,45);
spyParseTextMessageTagFile("/home/user16/work/klngan/hdl_labs/lab2/lint/sg_both/sg_both/mux3to1/Design_Read/spyglass_spysch/sg_msgtag.txt");

if(!defined $::spyInIspy || !$::spyInIspy)
{
    spyDefineReportGroupingOrder("ALL",
(
"BUILTIN"   => [SGTAGTRUE, SGTAGFALSE]
,"TEMPLATE" => "A"
)
);
}
spyMessageTagTestBenchmark(3,"/home/user16/work/klngan/hdl_labs/lab2/lint/sg_both/sg_both/mux3to1/Design_Read/spyglass.vdb");

1;
