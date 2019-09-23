set ns [ new Simulator ]

set nt [ open lp2.tr w]
$ns trace-all $nt

set nf [ open lp2.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n0 label "ping0"
$n1 label "ping1"
$n2 label "ping2"
$n3 label "ping3"
$n4 label "ping4"
$n5 label "router"

$ns duplex-link $n0 $n5 1mb 10ms DropTail
$ns duplex-link $n1 $n5 1mb 10ms DropTail
$ns duplex-link $n2 $n5 1mb 10ms DropTail
$ns duplex-link $n3 $n5 1mb 10ms DropTail
$ns duplex-link $n4 $n5 1mb 10ms DropTail

$ns queue-limit $n0 $n5 5
$ns queue-limit $n1 $n5 5
$ns queue-limit $n2 $n5 5
$ns queue-limit $n3 $n5 5
$ns queue-limit $n4 $n5 5

$ns color 2 Red
$ns color 3 Blue
$ns color 4 Green
$ns color 5 Yellow

Agent/Ping instproc recv { from rtt } {
	$self instvar node_
	puts "node [$node_ id] recived ping answer from node $from with round-trip-time $rtt ms"
}

set p0 [new Agent/Ping]
$ns attach-agent $n0 $p0
$p0 set class_ 1

set p1 [new Agent/Ping]
$ns attach-agent $n1 $p1
$p1 set class_ 2

set p2 [new Agent/Ping]
$ns attach-agent $n2 $p2
$p2 set class_ 3

set p3 [new Agent/Ping]
$ns attach-agent $n3 $p3
$p3 set class_ 4

set p4 [new Agent/Ping]
$ns attach-agent $n4 $p4
$p4 set class_ 5

$ns connect $p2 $p4
#$ns connect $p3 $p4		#uncomment for two ping application
#$ns connect $p1 $p4		#uncomment for three ping application
proc sendPingPacket { } {
	global ns p2 p3 p1
	set intervalTime 0.001
	set now [$ns now]
	$ns at [expr $now + $intervalTime] "$p2 send"
	#$ns at [expr $now + $intervalTime] "$p3 send"			#uncomment for two ping application
	#$ns at [expr $now + $intervalTime] "$p1 send"			#uncomment for three ping application
	$ns at [expr $now + $intervalTime] "sendPingPacket"
}

proc finish { } {
	global ns nt nf
	close $nt
	close $nf
	exec nam lp2.nam &
	exit 0;
}

$ns at 0.1 "sendPingPacket"
$ns at 2.0 "finish"
$ns run
