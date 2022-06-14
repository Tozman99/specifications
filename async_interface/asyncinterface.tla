---- MODULE asyncinterface ----
EXTENDS TLC
CONSTANT Data
VARIABLES value, ready, ack
typeInvariant ==  /\ value \in Data
                  /\ ready \in (0, 1)
                  /\ ack \in (0, 1)

init == /\ (value \in Data)
        /\ (ready \in (0, 1))
        /\ (ack \in (0, 1))

send == /\ (value \in Data) 
        /\ (ready = ack) 
        /\ (ready' = 1 - ready)
        /\ UNCHANGED ack
recv == /\ ready # ack 
        /\ (ack' = 1 - ack)
        /\ ready' = ready

next == send \/ recv
spec == init /\ [][next]<value, ready, ack>

THEOREM spec => []typeInvariant
====