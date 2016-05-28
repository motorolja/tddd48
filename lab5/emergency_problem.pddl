(define (problem emergency1)
        (:domain emergency)
        (:objects 
                  heli0 - uav
                  heli1 - uav
                  heli2 - uav
                  heli3 - uav
                  depot0 - depot
		  depotloc - location
                  p0 - location
                  p1 - location
                  p2 - location
                  p3 - location
                  p4 - location
                  p5 - location
                  p6 - location
                  p7 - location
                  medicine - type
                  food - type
                  carrier0 - carrier
                  carrier1 - carrier
                  carrier2 - carrier
                  carrier3 - carrier
        )
        (:init    
				  (loc depot0 depotloc)
                  (loc heli0 depotloc)
                  (loc heli1 depotloc)
                  (loc heli2 depotloc)
                  (loc heli3 depotloc)
				  (empty heli0)
				  (empty heli1)
				  (empty heli2)
				  (empty heli3)
                  (loc carrier0 depotloc)
                  (loc carrier1 depotloc)
                  (loc carrier2 depotloc)
                  (loc carrier3 depotloc)
                  (= (used carrier0) 0)
                  (= (used carrier1) 0)
                  (= (used carrier2) 0)
                  (= (used carrier3) 0)
                  (= (unused carrier0) 4)
                  (= (unused carrier1) 4)
                  (= (unused carrier2) 4)
                  (= (unused carrier3) 4)
                  (= (boxcount carrier0 medicine) 0)
                  (= (boxcount carrier1 medicine) 0)
                  (= (boxcount carrier2 medicine) 0)
                  (= (boxcount carrier3 medicine) 0)
                  (= (boxcount carrier0 food) 0)
                  (= (boxcount carrier1 food) 0)
                  (= (boxcount carrier2 food) 0)
                  (= (boxcount carrier3 food) 0)
                  (= (cratesUndelivered medicine depotloc) 0)
                  (= (cratesUndelivered medicine p0) 4)
                  (= (cratesUndelivered medicine p1) 3)
                  (= (cratesUndelivered medicine p2) 1)
                  (= (cratesUndelivered medicine p3) 0)
                  (= (cratesUndelivered medicine p4) 4)
                  (= (cratesUndelivered medicine p5) 1)
                  (= (cratesUndelivered medicine p6) 4)
                  (= (cratesUndelivered medicine p7) 3)
                  (= (cratesUndelivered food depotloc) 0)
                  (= (cratesUndelivered food p0) 0)
                  (= (cratesUndelivered food p1) 1)
                  (= (cratesUndelivered food p2) 3)
                  (= (cratesUndelivered food p3) 4)
                  (= (cratesUndelivered food p4) 0)
                  (= (cratesUndelivered food p5) 3)
                  (= (cratesUndelivered food p6) 0)
                  (= (cratesUndelivered food p7) 1)
        )

        (:goal    (and 
                     (= (cratesUndelivered medicine p1) 0)
                     (= (cratesUndelivered medicine p2) 0)
                     (= (cratesUndelivered medicine p3) 0)
                     (= (cratesUndelivered medicine p4) 0)
                     (= (cratesUndelivered medicine p5) 0)
                     (= (cratesUndelivered medicine p6) 0)
                     (= (cratesUndelivered medicine p7) 0)
                     (= (cratesUndelivered food p0) 0)
                     (= (cratesUndelivered food p1) 0)
                     (= (cratesUndelivered food p2) 0)
                     (= (cratesUndelivered food p3) 0)
                     (= (cratesUndelivered food p4) 0)
                     (= (cratesUndelivered food p5) 0)
                     (= (cratesUndelivered food p6) 0)
                     (= (cratesUndelivered food p7) 0)
                  )
        )
)
